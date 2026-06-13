import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../shared/models/location_model.dart';
import '../../../../shared/widgets/location_picker_tile.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String role; // 'vendor' or 'customer'

  const ProfileSetupScreen({super.key, required this.role});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  // Matches VENDOR_CATEGORIES in backend constants/index.ts
  static const List<String> _vendorCategories = [
    'Milk / Dairy',
    'Press / Dhobi',
    'Maid / Cook',
    'Newspaper',
    'Water Can',
    'Tiffin / Food',
    'Kirana / Grocery',
    'Salon / Parlour',
    'Construction Labour',
    'Transport / Auto',
    'Other',
  ];

  final _picker = ImagePicker();

  // Form state
  String? _selectedCategory;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  XFile? _pickedImage;
  bool _isUploadingPhoto = false;
  LocationData? _pickedLocation;

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _upiController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  // ─── Photo picker ──────────────────────────────────────────────────────────

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context); // close bottom sheet
    try {
      final xFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );
      if (xFile != null) setState(() => _pickedImage = xFile);
    } catch (_) {
      // User denied permission or cancelled
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading:
                  const Icon(Icons.camera_alt_rounded, color: AppColors.primary),
              title: const Text('Take a photo'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded,
                  color: AppColors.primary),
              title: const Text('Choose from gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            if (_pickedImage != null)
              ListTile(
                leading: const Icon(Icons.delete_rounded, color: AppColors.error),
                title: const Text('Remove photo',
                    style: TextStyle(color: AppColors.error)),
                onTap: () {
                  setState(() => _pickedImage = null);
                  Navigator.pop(context);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─── Photo upload (called after successful signup) ─────────────────────────

  Future<void> _uploadPhotoThenNavigate(AuthAuthenticated state) async {
    // Capture the destination before any async gap.
    final destination =
        state.user.isVendor ? AppRouter.vendorHome : AppRouter.customerHome;

    if (_pickedImage == null) {
      if (mounted) context.go(destination);
      return;
    }

    setState(() => _isUploadingPhoto = true);
    try {
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          _pickedImage!.path,
          filename: 'profile.jpg',
          contentType: DioMediaType('image', 'jpeg'),
        ),
      });
      await getIt<ApiClient>()
          .postFormData(ApiEndpoints.uploadPhoto, formData: formData);
    } catch (_) {
      // Non-critical — user can update photo from profile later
    } finally {
      if (mounted) {
        setState(() => _isUploadingPhoto = false);
        context.go(destination);
      }
    }
  }

  // ─── Signup validation & dispatch ─────────────────────────────────────────

  void _handleSignup(BuildContext ctx) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirm.isEmpty) {
      AppToast.show(ctx, AppLocalizations.of(ctx)!.fillRequiredFields, type: ToastType.warning);
      return;
    }

    // Mobile is required — it's a connection identifier (link by phone).
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
      AppToast.show(ctx, 'Enter a valid 10-digit mobile number', type: ToastType.error);
      return;
    }

    if (password != confirm) {
      AppToast.show(ctx, 'Passwords do not match', type: ToastType.error);
      return;
    }

    if (password.length < 8) {
      AppToast.show(ctx, 'Password must be at least 8 characters', type: ToastType.error);
      return;
    }

    ctx.read<AuthBloc>().add(
          AuthSignupRequested(
            name: name,
            email: email,
            password: password,
            role: widget.role,
            mobile: phone,
            upiId: _upiController.text.trim().isEmpty
                ? null
                : _upiController.text.trim(),
            businessName: _businessNameController.text.trim().isEmpty
                ? null
                : _businessNameController.text.trim(),
            businessCategory: _selectedCategory,
            businessAddress: _businessAddressController.text.trim().isEmpty
                ? null
                : _businessAddressController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isVendor = widget.role == 'vendor';

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state is AuthAuthenticated) {
          _uploadPhotoThenNavigate(state);
        } else if (state is AuthError) {
          AppToast.show(ctx, state.message, type: ToastType.error);
        }
      },
      builder: (ctx, state) {
        final isLoading = state is AuthLoading || _isUploadingPhoto;
        final loadingLabel = _isUploadingPhoto
            ? 'Uploading photo...'
            : l10n.getStarted.toUpperCase();

        return Scaffold(
          appBar: AppBar(title: Text(l10n.completeProfile)),
          body: SafeArea(child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Profile photo ───────────────────────────────────────
                Center(
                  child: GestureDetector(
                    onTap: isLoading ? null : _showPhotoOptions,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.1),
                          backgroundImage: _pickedImage != null
                              ? FileImage(File(_pickedImage!.path))
                              : null,
                          child: _pickedImage == null
                              ? const Icon(Icons.person_outline,
                                  size: 50, color: AppColors.primary)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt,
                                size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Tap to add profile photo',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 32),

                // ─── Account credentials ─────────────────────────────────
                CustomTextField(
                  label: l10n.fullName,
                  hintText: l10n.enterYourName,
                  prefixIcon: Icons.person_rounded,
                  controller: _nameController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: l10n.email,
                  hintText: 'you@example.com',
                  prefixIcon: Icons.email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Mobile number',
                  hintText: '10-digit mobile number',
                  prefixIcon: Icons.phone_rounded,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: l10n.password,
                  hintText: l10n.passwordMinChars,
                  prefixIcon: Icons.lock_rounded,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppColors.textHint,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  prefixIcon: Icons.lock_outline_rounded,
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppColors.textHint,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),

                // ─── Vendor-only fields ──────────────────────────────────
                if (isVendor) ...[
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: l10n.businessName,
                    hintText: l10n.egBusinessName,
                    prefixIcon: Icons.store_rounded,
                    controller: _businessNameController,
                  ),
                  const SizedBox(height: 20),
                  Text(l10n.businessCategory,
                      style: AppTypography.labelLarge),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.category_rounded,
                          color: AppColors.textSecondary),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    hint: Text(l10n.selectCategory),
                    initialValue: _selectedCategory,
                    items: _vendorCategories
                        .map((cat) =>
                            DropdownMenuItem(value: cat, child: Text(cat)))
                        .toList(),
                    onChanged: isLoading
                        ? null
                        : (val) => setState(() => _selectedCategory = val),
                  ),
                  const SizedBox(height: 20),
                  LocationPickerTile(
                    location: _pickedLocation,
                    enabled: !isLoading,
                    onTap: () async {
                      final result = await context.push<LocationData>(
                        AppRouter.locationPicker,
                        extra: _pickedLocation,
                      );
                      if (result != null) {
                        setState(() {
                          _pickedLocation = result;
                          _businessAddressController.text = result.displayName;
                        });
                      }
                    },
                  ),
                ],

                // ─── UPI (optional, both roles) ──────────────────────────
                const SizedBox(height: 20),
                CustomTextField(
                  label: '${l10n.upiId} (optional)',
                  hintText: l10n.upiHint,
                  prefixIcon: Icons.payments_rounded,
                  controller: _upiController,
                ),
                const SizedBox(height: 40),

                PrimaryButton(
                  label: loadingLabel,
                  isLoading: isLoading,
                  onPressed:
                      isLoading ? null : () => _handleSignup(ctx),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: isLoading ? null : () => ctx.pop(),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          ),
        );
      },
    );
  }
}
