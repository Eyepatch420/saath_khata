import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../../shared/models/link_model.dart';
import '../../../customer/domain/repositories/customer_repository.dart';

class LedgerPreferencesScreen extends StatefulWidget {
  const LedgerPreferencesScreen({super.key});

  @override
  State<LedgerPreferencesScreen> createState() => _LedgerPreferencesScreenState();
}

class _LedgerPreferencesScreenState extends State<LedgerPreferencesScreen> {
  bool _loading = true;
  List<VendorLinkItem> _links = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final links = await getIt<CustomerRepository>().getLinkedVendors();
      if (mounted) setState(() { _links = links.where((l) => !l.isPending).toList(); _loading = false; });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggle(int index, bool value) async {
    final link = _links[index];
    // Optimistic update
    setState(() => _links[index] = link.copyWith(customerAutoConfirm: value));
    try {
      await getIt<CustomerRepository>().updateAutoConfirm(link.linkId, enabled: value);
    } catch (e) {
      // Rollback on error
      if (mounted) {
        setState(() => _links[index] = link.copyWith(customerAutoConfirm: link.customerAutoConfirm));
        AppToast.show(context, 'Failed to update preference', type: ToastType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ledger Preferences')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _links.isEmpty
              ? const Center(child: Text('No linked vendors yet'))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _links.length,
                  separatorBuilder: (context, i) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final link = _links[i];
                    final vendorName = link.vendor.businessName ?? link.vendor.name;
                    return SwitchListTile.adaptive(
                      secondary: CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        backgroundImage: link.vendor.profilePhotoUrl != null
                            ? NetworkImage(link.vendor.profilePhotoUrl!)
                            : null,
                        child: link.vendor.profilePhotoUrl == null
                            ? const Icon(Icons.store_rounded, color: AppColors.primary)
                            : null,
                      ),
                      title: Text(vendorName),
                      subtitle: Text(
                        link.customerAutoConfirm
                            ? 'Auto-confirming vendor entries'
                            : 'Manual confirmation required',
                        style: TextStyle(
                          color: link.customerAutoConfirm
                              ? AppColors.success
                              : AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      value: link.customerAutoConfirm,
                      onChanged: (val) => _toggle(i, val),
                      activeThumbColor: AppColors.primary,
                    );
                  },
                ),
    );
  }
}
