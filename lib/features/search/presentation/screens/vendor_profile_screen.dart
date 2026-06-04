import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../link_requests/presentation/bloc/link_request_cubit.dart';
import '../../../link_requests/presentation/bloc/link_request_state.dart';
import '../../domain/models/vendor_public_profile.dart';
import '../../domain/models/vendor_search_result.dart';
import '../../domain/repositories/search_repository.dart';
import 'vendor_search_screen.dart';

/// Full public profile of a vendor — opens from a search result card.
///
/// [preview] is the lightweight data already in hand from the search list,
/// used to render the screen immediately while [VendorPublicProfile] loads
/// from the API (which adds the UPI ID needed for the payment CTA).
class VendorProfileScreen extends StatefulWidget {
  final VendorSearchResult preview;
  final SearchViewAs viewAs;

  const VendorProfileScreen({
    super.key,
    required this.preview,
    required this.viewAs,
  });

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  late Future<VendorPublicProfile> _profileFuture;

  Color get _accent => widget.viewAs == SearchViewAs.vendor
      ? AppColors.primary
      : AppColors.customerAccent;

  @override
  void initState() {
    super.initState();
    _profileFuture =
        getIt<SearchRepository>().getVendorProfile(widget.preview.userId);
  }

  SendLinkRequestCubit get _sendCubit => getIt<SendLinkRequestCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _sendCubit,
      child: _ProfileScaffold(
        preview: widget.preview,
        viewAs: widget.viewAs,
        profileFuture: _profileFuture,
        accent: _accent,
      ),
    );
  }
}

class _ProfileScaffold extends StatelessWidget {
  final VendorSearchResult preview;
  final SearchViewAs viewAs;
  final Future<VendorPublicProfile> profileFuture;
  final Color accent;

  const _ProfileScaffold({
    required this.preview,
    required this.viewAs,
    required this.profileFuture,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendLinkRequestCubit, SendRequestState>(
      listener: (ctx, state) {
        if (state is SendRequestSuccess) {
          AppToast.show(
            ctx,
            'Request sent! ${preview.displayName} will be notified.',
            type: ToastType.success,
          );
        } else if (state is SendRequestError) {
          AppToast.show(ctx, state.message, type: ToastType.error);
        }
      },
      child: Scaffold(
        body: FutureBuilder<VendorPublicProfile>(
        future: profileFuture,
        builder: (ctx, snap) {
          // Use preview data until full profile arrives
          final name = snap.data?.name ?? preview.name;
          final businessName =
              snap.data?.businessName ?? preview.businessName;
          final category =
              snap.data?.businessCategory ?? preview.businessCategory;
          final address =
              snap.data?.businessAddress ?? preview.businessAddress;
          final photoUrl =
              snap.data?.profilePhotoUrl ?? preview.profilePhotoUrl;
          final upiId = snap.data?.upiId;
          final displayName =
              businessName?.isNotEmpty == true ? businessName! : name;
          final initial = displayName.isNotEmpty
              ? displayName[0].toUpperCase()
              : '?';

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(
                context,
                displayName: displayName,
                name: name,
                photoUrl: photoUrl,
                initial: initial,
                category: category,
                userId: preview.userId,
              ),
              SliverToBoxAdapter(
                child: _buildBody(
                  context,
                  snap: snap,
                  displayName: displayName,
                  name: name,
                  category: category,
                  address: address,
                  upiId: upiId,
                ),
              ),
            ],
          );
        },
        ),
      ),
    );
  }

  // ── Expandable header ────────────────────────────────────────────────────

  Widget _buildAppBar(
    BuildContext context, {
    required String displayName,
    required String name,
    required String? photoUrl,
    required String initial,
    required String? category,
    required String userId,
  }) {
    // Category drives the gradient so each shop type looks distinct
    final gradient = _gradientForCategory(category);

    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      stretch: true,
      backgroundColor: gradient.colors.last,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      // Title fades in as the header collapses
      title: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 200),
        child: Text(
          displayName,
          style: AppTypography.h3.copyWith(color: Colors.white),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [StretchMode.zoomBackground],
        background: DecoratedBox(
          decoration: BoxDecoration(gradient: gradient),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                // Hero avatar — flies from the search result card
                Hero(
                  tag: 'vendor_avatar_$userId',
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.9),
                          width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: photoUrl != null
                          ? Image.network(
                              photoUrl,
                              width: 88,
                              height: 88,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) =>
                                  _AvatarInitial(
                                initial: initial,
                                size: 88,
                              ),
                            )
                          : _AvatarInitial(initial: initial, size: 88),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  displayName,
                  style: AppTypography.h2.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                if (name != displayName)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      'by $name',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Body ─────────────────────────────────────────────────────────────────

  Widget _buildBody(
    BuildContext context, {
    required AsyncSnapshot<VendorPublicProfile> snap,
    required String displayName,
    required String name,
    required String? category,
    required String? address,
    required String? upiId,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 20, 16, MediaQuery.of(context).viewPadding.bottom + 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category pill
          if (category != null)
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 24),

          // Info cards
          _InfoSection(
            accent: accent,
            address: address,
            upiId: upiId,
            isLoadingExtra: snap.connectionState == ConnectionState.waiting,
          ),

          const SizedBox(height: 28),

          // CTA
          _buildCta(context, displayName: displayName, upiId: upiId),
        ],
      ),
    );
  }

  // ── CTA ──────────────────────────────────────────────────────────────────

  Widget _buildCta(
    BuildContext context, {
    required String displayName,
    required String? upiId,
  }) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      builder: (ctx, authState) {
        final user =
            authState is AuthAuthenticated ? authState.user : null;

        if (viewAs == SearchViewAs.customer && user != null) {
          return _CustomerCta(
            user: user,
            vendorName: displayName,
            vendorId: preview.userId,
            accent: accent,
            upiId: upiId,
          );
        }

        if (viewAs == SearchViewAs.vendor && user != null) {
          return _VendorCta(
            user: user,
            upiId: upiId,
            vendorName: displayName,
            accent: accent,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ── Info section ─────────────────────────────────────────────────────────────

class _InfoSection extends StatelessWidget {
  final Color accent;
  final String? address;
  final String? upiId;
  final bool isLoadingExtra;

  const _InfoSection({
    required this.accent,
    required this.address,
    required this.upiId,
    required this.isLoadingExtra,
  });

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    final items = <_InfoItem>[];

    if (address != null && address!.isNotEmpty) {
      items.add(_InfoItem(
        icon: Icons.location_on_rounded,
        label: 'Address',
        value: address!,
        accent: accent,
      ));
    }

    if (isLoadingExtra) {
      items.add(_InfoItem(
        icon: Icons.account_balance_wallet_outlined,
        label: 'UPI',
        value: '…',
        accent: accent,
      ));
    } else if (upiId != null && upiId!.isNotEmpty) {
      items.add(_InfoItem(
        icon: Icons.account_balance_wallet_rounded,
        label: 'UPI ID',
        value: upiId!,
        accent: accent,
        isCopyable: true,
      ));
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (ctx, idx) => Divider(
          height: 1,
          indent: 56,
          color: Theme.of(context).dividerColor,
        ),
        itemBuilder: (ctx, i) => items[i],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;
  final bool isCopyable;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
    this.isCopyable = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isCopyable
          ? () {
              Clipboard.setData(ClipboardData(text: value));
              AppToast.show(
                context,
                'UPI ID copied!',
                type: ToastType.success,
              );
            }
          : null,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: accent, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textHint)),
                  const SizedBox(height: 2),
                  Text(value, style: AppTypography.bodyMedium),
                ],
              ),
            ),
            if (isCopyable)
              Icon(Icons.copy_rounded,
                  size: 16, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}

// ── Customer CTA ─────────────────────────────────────────────────────────────

class _CustomerCta extends StatelessWidget {
  final dynamic user;
  final String vendorName;
  final String vendorId;
  final Color accent;
  final String? upiId;

  const _CustomerCta({
    required this.user,
    required this.vendorName,
    required this.vendorId,
    required this.accent,
    required this.upiId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendLinkRequestCubit, SendRequestState>(
      builder: (ctx, state) {
        final sent = state is SendRequestSuccess;
        final sending = state is SendRequestSending;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: sent || sending
                  ? null
                  : () => ctx
                      .read<SendLinkRequestCubit>()
                      .send(vendorId: vendorId),
              style: ElevatedButton.styleFrom(
                backgroundColor: sent ? AppColors.success : accent,
                disabledBackgroundColor: sent
                    ? AppColors.success
                    : accent.withValues(alpha: 0.4),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              icon: sending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Icon(
                      sent
                          ? Icons.check_circle_rounded
                          : Icons.handshake_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
              label: Text(
                sent
                    ? 'Request Sent'
                    : sending
                        ? 'Sending…'
                        : 'Send Connection Request',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            if (upiId != null && upiId!.isNotEmpty) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: upiId!));
                  AppToast.show(ctx, 'UPI ID copied!',
                      type: ToastType.success);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side:
                      BorderSide(color: accent.withValues(alpha: 0.5)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                icon: Icon(Icons.payment_rounded, color: accent, size: 20),
                label: Text('Pay via UPI',
                    style: TextStyle(
                        color: accent, fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        );
      },
    );
  }
}

// ── Vendor CTA ────────────────────────────────────────────────────────────────

/// Shown when a vendor user views another vendor's profile.
///
/// Flow: the current vendor shares their email with the other vendor, who
/// then adds it via their own "Add Customer" flow. Once added, the ledger
/// becomes visible in the current user's Customer account.
///
/// This requires the current user to have a Customer account with the same
/// email — but they don't need to switch accounts RIGHT NOW to initiate it.
class _VendorCta extends StatelessWidget {
  final dynamic user; // UserModel
  final String? upiId;
  final String vendorName;
  final Color accent;

  const _VendorCta({
    required this.user,
    required this.upiId,
    required this.vendorName,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary: share email so the other vendor can add them as customer
        ElevatedButton.icon(
          onPressed: () => _showShareEmailSheet(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: accent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          icon: const Icon(Icons.handshake_rounded,
              color: Colors.white, size: 20),
          label: const Text(
            'Start a Ledger with this Vendor',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        // Secondary: copy UPI to pay directly
        if (upiId != null && upiId!.isNotEmpty) ...[
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: upiId!));
              AppToast.show(context, 'UPI ID copied!', type: ToastType.success);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(color: accent.withValues(alpha: 0.5)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            icon: Icon(Icons.payment_rounded, color: accent, size: 20),
            label: Text(
              'Copy UPI ID to Pay',
              style: TextStyle(color: accent, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ],
    );
  }

  void _showShareEmailSheet(BuildContext context) {
    final email = user.email as String;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.handshake_rounded, color: accent, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start a Ledger', style: AppTypography.h3),
                      const SizedBox(height: 2),
                      Text(
                        'with $vendorName',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Step 1
            _StepRow(
              number: '1',
              accent: accent,
              text:
                  'Share your email with $vendorName so they can add you as a customer.',
            ),
            const SizedBox(height: 12),
            // Step 2
            _StepRow(
              number: '2',
              accent: accent,
              text:
                  'Once they add you, open the app as your Customer account to see the shared ledger.',
            ),
            const SizedBox(height: 20),
            // Email display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accent.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.email_rounded, color: accent, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      email,
                      style: AppTypography.labelLarge.copyWith(color: accent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: email));
                  Navigator.pop(ctx);
                  AppToast.show(
                    context,
                    'Email copied! Share it with $vendorName.',
                    type: ToastType.success,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.copy_rounded,
                    color: Colors.white, size: 18),
                label: const Text(
                  'Copy My Email',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step row helper ───────────────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final String number;
  final Color accent;
  final String text;

  const _StepRow({
    required this.number,
    required this.accent,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Avatar initial fallback ───────────────────────────────────────────────────

class _AvatarInitial extends StatelessWidget {
  final String initial;
  final double size;

  const _AvatarInitial({required this.initial, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: Colors.white.withValues(alpha: 0.25),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.38,
        ),
      ),
    );
  }
}

// Private helper — gradient per category
LinearGradient _gradientForCategory(String? category) {
  final colors = switch (category) {
    'Milk / Dairy' => [const Color(0xFF1565C0), const Color(0xFF0D47A1)],
    'Tiffin / Food' => [const Color(0xFFE65100), const Color(0xFFBF360C)],
    'Kirana / Grocery' => [const Color(0xFF2E7D32), const Color(0xFF1B5E20)],
    'Salon / Parlour' => [const Color(0xFF6A1B9A), const Color(0xFF4A148C)],
    'Newspaper' => [const Color(0xFF37474F), const Color(0xFF263238)],
    'Water Can' => [const Color(0xFF0277BD), const Color(0xFF01579B)],
    'Press / Dhobi' => [const Color(0xFF558B2F), const Color(0xFF33691E)],
    'Transport / Auto' => [const Color(0xFFF57F17), const Color(0xFFE65100)],
    'Maid / Cook' => [const Color(0xFFC62828), const Color(0xFFB71C1C)],
    'Construction Labour' => [
      const Color(0xFF4E342E),
      const Color(0xFF3E2723)
    ],
    _ => [const Color(0xFF00695C), const Color(0xFF00897B)],
  };
  return LinearGradient(
    colors: colors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
