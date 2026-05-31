import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../data/models/user_model.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../shared/widgets/app_toast.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _mobileCtrl;
  late final TextEditingController _upiCtrl;
  late final TextEditingController _bizNameCtrl;
  late final TextEditingController _bizCategoryCtrl;
  late final TextEditingController _bizAddressCtrl;

  File? _pickedImage;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _mobileCtrl = TextEditingController(text: widget.user.mobile ?? '');
    _upiCtrl = TextEditingController(text: widget.user.upiId ?? '');
    _bizNameCtrl = TextEditingController(text: widget.user.businessName ?? '');
    _bizCategoryCtrl =
        TextEditingController(text: widget.user.businessCategory ?? '');
    _bizAddressCtrl =
        TextEditingController(text: widget.user.businessAddress ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _mobileCtrl.dispose();
    _upiCtrl.dispose();
    _bizNameCtrl.dispose();
    _bizCategoryCtrl.dispose();
    _bizAddressCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);
    final picked =
        await ImagePicker().pickImage(source: source, imageQuality: 80);
    if (picked != null && mounted) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Camera'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            if (_pickedImage != null || widget.user.profilePhotoUrl != null)
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.error),
                title: const Text('Remove photo',
                    style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _pickedImage = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    if (_pickedImage != null) {
      try {
        final formData = FormData.fromMap({
          'photo': await MultipartFile.fromFile(
            _pickedImage!.path,
            filename: 'profile.jpg',
          ),
        });
        await getIt<ApiClient>()
            .postFormData(ApiEndpoints.uploadPhoto, formData: formData);
      } catch (e) {
        if (!mounted) return;
        // Photo upload failed — show a warning but continue saving the
        // rest of the profile. Don't block the user from updating their name,
        // UPI ID, etc. just because Cloudinary is unavailable.
        final msg = e.toString().contains('SERVICE_UNAVAILABLE') ||
                e.toString().contains('not available') ||
                e.toString().contains('unavailable')
            ? 'Photo upload unavailable — other changes will be saved'
            : 'Photo upload failed — other changes will still be saved';
        AppToast.show(context, msg, type: ToastType.warning);
        // fall through to save the rest of the profile
      }
    }

    if (!mounted) return;
    context.read<AuthBloc>().add(AuthProfileUpdateRequested(
      name: _nameCtrl.text.trim(),
      mobile:
          _mobileCtrl.text.trim().isEmpty ? null : _mobileCtrl.text.trim(),
      upiId: _upiCtrl.text.trim().isEmpty ? null : _upiCtrl.text.trim(),
      businessName: widget.user.isVendor && _bizNameCtrl.text.trim().isNotEmpty
          ? _bizNameCtrl.text.trim()
          : null,
      businessCategory: widget.user.isVendor &&
              _bizCategoryCtrl.text.trim().isNotEmpty
          ? _bizCategoryCtrl.text.trim()
          : null,
      businessAddress:
          widget.user.isVendor && _bizAddressCtrl.text.trim().isNotEmpty
              ? _bizAddressCtrl.text.trim()
              : null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous is AuthLoading,
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          setState(() => _isSaving = false);
          AppToast.show(context, 'Profile updated successfully', type: ToastType.success);
          context.pop();
        } else if (state is AuthError) {
          setState(() => _isSaving = false);
          AppToast.show(context, state.message, type: ToastType.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _isSaving
                  ? const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : TextButton(
                      onPressed: _save,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ],
        ),
        body: SafeArea(child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _showPhotoOptions,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!) as ImageProvider
                              : widget.user.profilePhotoUrl != null
                                  ? NetworkImage(widget.user.profilePhotoUrl!)
                                  : null,
                          backgroundColor: AppColors.primary,
                          child: (_pickedImage == null &&
                                  widget.user.profilePhotoUrl == null)
                              ? const Icon(Icons.person_rounded,
                                  size: 50, color: Colors.white)
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
                            child: const Icon(Icons.camera_alt_rounded,
                                size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Personal Info',
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Name is required'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mobileCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _upiCtrl,
                  decoration: const InputDecoration(
                    labelText: 'UPI ID',
                    hintText: 'e.g. name@upi',
                    prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  ),
                ),
                if (widget.user.isVendor) ...[
                  const SizedBox(height: 32),
                  Text(
                    'Business Info',
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bizNameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Business Name',
                      prefixIcon: Icon(Icons.store_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bizCategoryCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Business Category',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bizAddressCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Business Address',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    maxLines: 2,
                  ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
