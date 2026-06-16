import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/ledger_socket_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/ledger_entry.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../customer/domain/repositories/customer_repository.dart';
import '../../../memberships/domain/repositories/membership_repository.dart';
import '../../../memberships/presentation/bloc/membership_cubit.dart';
import '../../../memberships/presentation/widgets/membership_banner.dart';
import '../../../vendor/domain/repositories/vendor_repository.dart';
import '../../../voice_entry/presentation/widgets/voice_entry_sheet.dart';
import '../bloc/ledger_bloc.dart';
import '../bloc/ledger_event.dart';
import 'shared_ledger_screen/widgets/balance_header.dart';
import 'shared_ledger_screen/widgets/filter_bar.dart';
import 'shared_ledger_screen/widgets/info_row.dart';
import 'shared_ledger_screen/widgets/ledger_actions.dart';
import 'shared_ledger_screen/widgets/ledger_list.dart';

class SharedLedgerScreen extends StatefulWidget {
  final String linkId;
  final String customerName;
  final bool isVendorView;

  const SharedLedgerScreen({
    super.key,
    required this.linkId,
    required this.customerName,
    this.isVendorView = true,
  });

  @override
  State<SharedLedgerScreen> createState() => _SharedLedgerScreenState();
}

class _SharedLedgerScreenState extends State<SharedLedgerScreen> {
  static const _m = 'LedgerScreen';
  late final LedgerBloc _bloc;
  late final MembershipCubit _membershipCubit;
  late final LedgerSocketService _socket;

  @override
  void initState() {
    super.initState();
    _bloc = LedgerBloc(getIt())..add(LoadLedger(widget.linkId));
    _membershipCubit =
        MembershipCubit(getIt<MembershipRepository>(), widget.linkId)..load();
    _socket = getIt<LedgerSocketService>();
    _socket.joinLedger(widget.linkId);

    _socket.onMembershipUpdated((_) {
      AppLogger.v(_m, 'Socket membership:updated received');
      _membershipCubit.reload();
    });

    _socket.onEntryAdded((data) {
      try {
        final entry =
            LedgerEntry.fromJson(data['entry'] as Map<String, dynamic>);
        AppLogger.v(_m, 'Socket entry_added received id:${entry.id}');
        _bloc.add(SocketLedgerEntryAdded(entry));
      } catch (e) {
        AppLogger.e(_m, 'Failed to parse socket entry_added', e);
      }
    });

    _socket.onEntryUpdated((data) {
      try {
        final entry =
            LedgerEntry.fromJson(data['entry'] as Map<String, dynamic>);
        AppLogger.v(_m, 'Socket entry_updated received id:${entry.id}');
        _bloc.add(SocketLedgerEntryUpdated(entry));
      } catch (e) {
        AppLogger.e(_m, 'Failed to parse socket entry_updated', e);
      }
    });
  }

  @override
  void dispose() {
    _socket.leaveLedger(widget.linkId);
    _socket.off('ledger:entry_added');
    _socket.off('ledger:entry_updated');
    _socket.off('membership:updated');
    _membershipCubit.close();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _bloc),
        BlocProvider.value(value: _membershipCubit),
      ],
      child: SharedLedgerView(
        customerName: widget.customerName,
        linkId: widget.linkId,
        isVendorView: widget.isVendorView,
      ),
    );
  }
}

// ─── Main View ────────────────────────────────────────────────────────────────

class SharedLedgerView extends StatelessWidget {
  final String customerName;
  final String linkId;
  final bool isVendorView;

  const SharedLedgerView({
    super.key,
    required this.customerName,
    required this.linkId,
    this.isVendorView = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = context.read<AuthBloc>().state;
    final currentUserId =
        authState is AuthAuthenticated ? authState.user.id : '';

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // ── Collapsing title AppBar — only visible at very top ───────────
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customerName, style: AppTypography.h3),
                Row(
                  children: [
                    Text(
                      l10n.sharedLedger,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(width: 6),
                    _LiveDot(socket: getIt<LedgerSocketService>()),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => _confirmDeleteLink(context, l10n),
                icon: const Icon(Icons.link_off_rounded),
                tooltip: 'Remove ledger',
                color: AppColors.error,
              ),
              IconButton(
                onPressed: () => _showLedgerInfo(context, l10n),
                icon: const Icon(Icons.info_outline_rounded),
              ),
            ],
          ),

          // ── Balance + Membership — hides when scrolling down ─────────────
          SliverToBoxAdapter(
            child: Column(
              children: [
                LedgerBalanceHeader(
                  linkId: linkId,
                  customerName: customerName,
                  isVendorView: isVendorView,
                ),
                MembershipBanner(
                  customerName: customerName,
                  isVendorView: isVendorView,
                ),
              ],
            ),
          ),

          // ── Tab/filter bar — always pinned, never hides ──────────────────
          const SliverPersistentHeader(
            pinned: true,
            delegate: _StickyFilterBarDelegate(),
          ),
        ],
        body: LedgerList(
          linkId: linkId,
          customerName: customerName,
          currentUserId: currentUserId,
        ),
      ),
      floatingActionButton: Builder(
        builder: (innerContext) => FloatingActionButton(
          heroTag: 'voiceEntryFab',
          backgroundColor: AppColors.primary,
          tooltip: l10n.voiceConfirmEntry,
          onPressed: () => showVoiceEntrySheet(
            innerContext,
            linkId: linkId,
            isVendorView: isVendorView,
            language: innerContext.read<LocaleProvider>().locale.languageCode,
            ledgerBloc: innerContext.read<LedgerBloc>(),
          ),
          child: const Icon(Icons.mic_rounded, color: Colors.white),
        ),
      ),
      bottomNavigationBar: LedgerActions(
        linkId: linkId,
        customerName: customerName,
        isVendorView: isVendorView,
      ),
    );
  }

  // ── Delete link ───────────────────────────────────────────────────────────

  void _confirmDeleteLink(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Remove ledger?'),
        content: Text(
          isVendorView
              ? 'This will deactivate your link with $customerName. Both parties will lose access to this shared ledger.'
              : 'This will remove your connection with $customerName.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogCtx).pop();
              try {
                if (isVendorView) {
                  await getIt<VendorRepository>().deactivateLink(linkId);
                } else {
                  await getIt<CustomerRepository>().deactivateLink(linkId);
                }
                if (context.mounted) context.pop();
              } catch (e) {
                if (context.mounted) {
                  AppToast.show(
                    context,
                    e.toString().replaceFirst('Exception: ', ''),
                    type: ToastType.error,
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showLedgerInfo(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.ledgerInfoTitle, style: AppTypography.h3),
            const SizedBox(height: 16),
            LedgerInfoRow(
              icon: Icons.lock_rounded,
              color: AppColors.success,
              label: l10n.statusConfirmed,
              desc: l10n.statusConfirmedDesc,
            ),
            LedgerInfoRow(
              icon: Icons.access_time_rounded,
              color: AppColors.warning,
              label: l10n.statusPending,
              desc: l10n.statusPendingDesc,
            ),
            LedgerInfoRow(
              icon: Icons.warning_amber_rounded,
              color: AppColors.error,
              label: l10n.statusDisputed,
              desc: l10n.statusDisputedDesc,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─── Sticky filter bar delegate ───────────────────────────────────────────────

class _StickyFilterBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyFilterBarDelegate();

  // Match the container height in LedgerFilterBar (padding 8 top + 8 bottom + chip height ~36)
  static const double _height = 52.0;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      elevation: overlapsContent ? 2 : 0,
      color: Theme.of(context).colorScheme.surface,
      child: const LedgerFilterBar(),
    );
  }

  @override
  bool shouldRebuild(_StickyFilterBarDelegate oldDelegate) => false;
}

// ─── Live connection indicator ────────────────────────────────────────────────

class _LiveDot extends StatefulWidget {
  final LedgerSocketService socket;
  const _LiveDot({required this.socket});

  @override
  State<_LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<_LiveDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;
  late bool _isLive;
  StreamSubscription<bool>? _sub;

  @override
  void initState() {
    super.initState();
    _isLive = widget.socket.isConnected;

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );

    _sub = widget.socket.connectionStream.listen((connected) {
      if (mounted) setState(() => _isLive = connected);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLive) {
      return Tooltip(
        message: 'Offline — updates paused',
        child: Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: AppColors.textHint,
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    return Tooltip(
      message: 'Live — real-time updates on',
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: AppColors.success,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
