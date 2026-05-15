import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String role; // 'vendor' or 'customer'

  const ProfileSetupScreen({super.key, required this.role});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  // Matches VENDOR_CATEGORIES constant in the backend constants/index.ts
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

  String? _selectedCategory;
  bool _obscurePassword = true;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _upiController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isVendor = widget.role == 'vendor';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.completeProfile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: const Icon(Icons.person_outline,
                        size: 50, color: AppColors.primary),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt,
                          size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ─── Account credentials ──────────────────────────────────────
            CustomTextField(
              label: l10n.fullName,
              hintText: l10n.enterYourName,
              prefixIcon: Icons.person_rounded,
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Email',
              hintText: 'you@example.com',
              prefixIcon: Icons.email_rounded,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Password',
              hintText: 'Minimum 8 characters',
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

            // ─── Vendor-only fields ───────────────────────────────────────
            if (isVendor) ...[
              const SizedBox(height: 20),
              CustomTextField(
                label: l10n.businessName,
                hintText: l10n.egBusinessName,
                prefixIcon: Icons.store_rounded,
                controller: _businessNameController,
              ),
              const SizedBox(height: 20),
              Text(l10n.businessCategory, style: AppTypography.labelLarge),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category_rounded,
                      color: AppColors.textSecondary),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                hint: Text(l10n.selectCategory),
                initialValue: _selectedCategory,
                items: _vendorCategories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) =>
                    setState(() => _selectedCategory = val),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: l10n.businessAddress,
                hintText: l10n.enterAddress,
                prefixIcon: Icons.location_on_rounded,
                controller: _businessAddressController,
              ),
            ],

            const SizedBox(height: 20),
            CustomTextField(
              label: l10n.upiId,
              hintText: l10n.upiHint,
              prefixIcon: Icons.payments_rounded,
              controller: _upiController,
            ),
            const SizedBox(height: 40),

            PrimaryButton(
              label: l10n.getStarted.toUpperCase(),
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _handleSignup,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in name, email and password')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // TODO: call POST /api/v1/auth/signup with:
    // {
    //   name, email, password, role: widget.role,
    //   upiId: _upiController.text (if non-empty),
    //   businessName: _businessNameController.text (vendor only),
    //   businessCategory: _selectedCategory (vendor only),
    //   businessAddress: _businessAddressController.text (vendor only),
    // }
    // On success: save tokens via StorageService.saveTokens()
    // Navigate to role-specific home

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (widget.role == 'vendor') {
      context.go(AppRouter.vendorHome);
    } else {
      context.go(AppRouter.customerHome);
    }
  }
}
