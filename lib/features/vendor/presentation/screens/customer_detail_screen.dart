import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/ledger_socket_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../shared/models/ledger_entry.dart';
import '../../../../shared/models/link_model.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../memberships/domain/repositories/membership_repository.dart';
import '../../../memberships/presentation/bloc/membership_cubit.dart';
import '../../../memberships/presentation/widgets/membership_banner.dart';
import '../../../memberships/presentation/widgets/membership_tier_badge.dart';
import '../../../shared_ledger/presentation/bloc/ledger_bloc.dart';
import '../../../shared_ledger/presentation/bloc/ledger_event.dart';
import '../../../shared_ledger/presentation/screens/shared_ledger_screen/widgets/balance_header.dart';
import '../../../shared_ledger/presentation/screens/shared_ledger_screen/widgets/filter_bar.dart';
import '../../../shared_ledger/presentation/screens/shared_ledger_screen/widgets/ledger_actions.dart';
import '../../../shared_ledger/presentation/screens/shared_ledger_screen/widgets/ledger_list.dart';
import '../../../shared_ledger/presentation/screens/monthly_settlement_screen.dart';
import '../widgets/customer_defaults_sheet.dart';


class CustomerDetailScreen extends StatefulWidget {
  final CustomerLinkItem customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen>
    with SingleTickerProviderStateMixin {
  static const _m = 'CustomerDetail';

  late final LedgerBloc _bloc;
  late final MembershipCubit _membershipCubit;
  late final LedgerSocketService _socket;
  late final TabController _tabController;

  // Delivery tab is only shown for delivery-category vendors
  bool _showDeliveryTab = false;

  @override
  void initState() {
    super.initState();
    _bloc = LedgerBloc(getIt())..add(LoadLedger(widget.customer.linkId));
    _membershipCubit =
        MembershipCubit(getIt<MembershipRepository>(), widget.customer.linkId)
          ..load();
    _socket = getIt<LedgerSocketService>();
    _socket.joinLedger(widget.customer.linkId);

    _socket.onEntryAdded((data) {
      try {
        final entry =
            LedgerEntry.fromJson(data['entry'] as Map<String, dynamic>);
        _bloc.add(SocketLedgerEntryAdded(entry));
      } catch (e) {
        AppLogger.e(_m, 'Socket entry_added parse failed', e);
      }
    });

    _socket.onEntryUpdated((data) {
      try {
        final entry =
            LedgerEntry.fromJson(data['entry'] as Map<String, dynamic>);
        _bloc.add(SocketLedgerEntryUpdated(entry));
      } catch (e) {
        AppLogger.e(_m, 'Socket entry_updated parse failed', e);
      }
    });

    _socket.onMembershipUpdated((_) => _membershipCubit.reload());

    // Determine if delivery tab should show (based on vendor's business category)
    // We'll detect it from the auth user's vendor profile via DI context later;
    // for now we default to false and can be overridden via constructor arg.
    _showDeliveryTab = false;

    final tabCount = _showDeliveryTab ? 4 : 3;
    _tabController = TabController(length: tabCount, vsync: this);
  }

  @override
  void dispose() {
    _socket.leaveLedger(widget.customer.linkId);
    _socket.off('ledger:entry_added');
    _socket.off('ledger:entry_updated');
    _socket.off('membership:updated');
    _membershipCubit.close();
    _bloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _bloc),
        BlocProvider.value(value: _membershipCubit),
      ],
      child: _CustomerDetailView(
        customer: widget.customer,
        tabController: _tabController,
        showDeliveryTab: _showDeliveryTab,
      ),
    );
  }
}

class _CustomerDetailView extends StatelessWidget {
  final CustomerLinkItem customer;
  final TabController tabController;
  final bool showDeliveryTab;

  const _CustomerDetailView({
    required this.customer,
    required this.tabController,
    required this.showDeliveryTab,
  });

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final currentUserId =
        authState is AuthAuthenticated ? authState.user.id : '';

    final tabs = [
      const Tab(text: 'History'),
      const Tab(text: 'Dues'),
      if (showDeliveryTab) const Tab(text: 'Delivery'),
      const Tab(text: 'Info'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.displayName, style: AppTypography.h3),
                  if (customer.subName != null)
                    Text(customer.subName!,
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (customer.tierName != null) ...[
              const SizedBox(width: 8),
              MembershipTierBadge(
                tierName: customer.tierName,
                tierLevel: customer.tierLevel,
              ),
            ],
          ],
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: tabs,
          labelStyle: AppTypography.labelLarge.copyWith(fontSize: 13),
          unselectedLabelColor: AppColors.textHint,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // History tab — full ledger list with actions
          _HistoryTab(
            customer: customer,
            currentUserId: currentUserId,
          ),
          // Dues tab — pending entries only + summary
          _DuesTab(
            customer: customer,
            currentUserId: currentUserId,
          ),
          // Delivery tab (only for dairy/tiffin/etc vendors)
          if (showDeliveryTab)
            _DeliveryTab(customer: customer, currentUserId: currentUserId),
          // Info tab — customer details + set defaults
          _InfoTab(customer: customer),
        ],
      ),
    );
  }
}

// ─── History Tab ──────────────────────────────────────────────────────────────

class _HistoryTab extends StatelessWidget {
  final CustomerLinkItem customer;
  final String currentUserId;

  const _HistoryTab({required this.customer, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LedgerBalanceHeader(
          linkId: customer.linkId,
          customerName: customer.displayName,
          isVendorView: true,
        ),
        MembershipBanner(
          customerName: customer.displayName,
          isVendorView: true,
        ),
        const LedgerFilterBar(),
        Expanded(
          child: LedgerList(
            linkId: customer.linkId,
            customerName: customer.displayName,
            currentUserId: currentUserId,
            isVendorView: true,
          ),
        ),
        LedgerActions(
          linkId: customer.linkId,
          customerName: customer.displayName,
          isVendorView: true,
        ),
      ],
    );
  }
}

// ─── Dues Tab ─────────────────────────────────────────────────────────────────

class _DuesTab extends StatelessWidget {
  final CustomerLinkItem customer;
  final String currentUserId;

  const _DuesTab({required this.customer, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LedgerBalanceHeader(
          linkId: customer.linkId,
          customerName: customer.displayName,
          isVendorView: true,
        ),
        Expanded(
          child: LedgerList(
            linkId: customer.linkId,
            customerName: customer.displayName,
            currentUserId: currentUserId,
            isVendorView: true,
            filterStatus: EntryStatus.pending,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<LedgerBloc>(),
                    child: MonthlySettlementScreen(
                      customerName: customer.displayName,
                      isVendorView: true,
                    ),
                  ),
                ),
              ),
              icon: const Icon(Icons.calendar_month_rounded, size: 16),
              label: const Text('View Monthly Statement'),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Delivery Tab ─────────────────────────────────────────────────────────────

class _DeliveryTab extends StatelessWidget {
  final CustomerLinkItem customer;
  final String currentUserId;

  const _DeliveryTab({required this.customer, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LedgerList(
            linkId: customer.linkId,
            customerName: customer.displayName,
            currentUserId: currentUserId,
            isVendorView: true,
            filterType: EntryType.credit,
          ),
        ),
        LedgerActions(
          linkId: customer.linkId,
          customerName: customer.displayName,
          isVendorView: true,
        ),
      ],
    );
  }
}

// ─── Info Tab ─────────────────────────────────────────────────────────────────

class _InfoTab extends StatelessWidget {
  final CustomerLinkItem customer;

  const _InfoTab({required this.customer});

  @override
  Widget build(BuildContext context) {
    final c = customer.customer;
    final hasDefaults = customer.defaultProduct != null;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _InfoSection(
          title: 'Customer',
          children: [
            _InfoRow('Name', c.name),
            if (c.mobile != null) _InfoRow('Mobile', c.mobile!),
            if (customer.nickname != null)
              _InfoRow('Your nickname', customer.nickname!),
            _InfoRow(
                'Linked since',
                _formatDate(customer.createdAt)),
          ],
        ),
        const SizedBox(height: 20),
        _InfoSection(
          title: 'Default Delivery',
          trailing: TextButton(
            onPressed: () => _showDefaultsSheet(context),
            child: Text(hasDefaults ? 'Edit' : 'Set'),
          ),
          children: hasDefaults
              ? [
                  if (customer.defaultProduct != null)
                    _InfoRow('Product', customer.defaultProduct!),
                  if (customer.defaultQty != null)
                    _InfoRow(
                        'Qty',
                        '${customer.defaultQty!.toStringAsFixed(customer.defaultQty! % 1 == 0 ? 0 : 2)}'
                        ' ${customer.defaultUnit ?? ''}'),
                  if (customer.defaultPricePerUnit != null)
                    _InfoRow('Price/unit',
                        '₹${customer.defaultPricePerUnit!.toStringAsFixed(2)}'),
                ]
              : [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'No default set. Staff Quick Delivery will ask each time.',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textHint),
                    ),
                  ),
                ],
        ),
        if (customer.tierName != null) ...[
          const SizedBox(height: 20),
          _InfoSection(
            title: 'Membership',
            children: [
              _InfoRow('Tier', customer.tierName!),
            ],
          ),
        ],
      ],
    );
  }

  void _showDefaultsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => CustomerDefaultsSheet(customer: customer),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return iso;
    }
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? trailing;

  const _InfoSection({
    required this.title,
    required this.children,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: AppTypography.labelLarge
                      .copyWith(color: AppColors.textSecondary)),
              if (trailing != null) trailing as Widget,
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textHint)),
          ),
          Expanded(
            child: Text(value, style: AppTypography.bodyMedium),
          ),
        ],
      ),
    );
  }
}
