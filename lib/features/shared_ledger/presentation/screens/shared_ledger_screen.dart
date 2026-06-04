import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/ledger_socket_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/ledger_entry.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
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
  late final LedgerSocketService _socket;

  @override
  void initState() {
    super.initState();
    _bloc = LedgerBloc(getIt())..add(LoadLedger(widget.linkId));
    _socket = getIt<LedgerSocketService>();
    _socket.joinLedger(widget.linkId);

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
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: SharedLedgerView(
        customerName: widget.customerName,
        linkId: widget.linkId,
        isVendorView: widget.isVendorView,
      ),
    );
  }
}

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
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(customerName, style: AppTypography.h3),
            Text(
              l10n.sharedLedger,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.primary),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showLedgerInfo(context, l10n),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            LedgerBalanceHeader(
              linkId: linkId,
              customerName: customerName,
              isVendorView: isVendorView,
            ),
            const LedgerFilterBar(),
            Expanded(
              child: LedgerList(
                linkId: linkId,
                customerName: customerName,
                currentUserId: currentUserId,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LedgerActions(
        linkId: linkId,
        customerName: customerName,
        isVendorView: isVendorView,
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
