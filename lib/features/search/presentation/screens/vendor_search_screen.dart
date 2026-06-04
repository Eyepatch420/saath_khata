import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../domain/models/vendor_search_result.dart';
import '../bloc/search_cubit.dart';
import '../bloc/search_state.dart';

/// Who is opening this search screen — drives the accent colour and FAB copy.
enum SearchViewAs { vendor, customer }

/// All vendor business categories — mirrors the backend VENDOR_CATEGORIES constant.
const _kCategories = [
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

class VendorSearchScreen extends StatefulWidget {
  final SearchViewAs viewAs;

  const VendorSearchScreen({super.key, required this.viewAs});

  @override
  State<VendorSearchScreen> createState() => _VendorSearchScreenState();
}

class _VendorSearchScreenState extends State<VendorSearchScreen> {
  final _controller = TextEditingController();
  String? _selectedCategory;

  Color get _accent => widget.viewAs == SearchViewAs.vendor
      ? AppColors.primary
      : AppColors.customerAccent;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(getIt()),
      child: Builder(builder: (ctx) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                _buildSearchBar(ctx),
                _buildCategoryChips(ctx),
                const Divider(height: 1),
                Expanded(child: _buildResults()),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ── Search bar (Hero destination) ─────────────────────────────────────────

  Widget _buildSearchBar(BuildContext ctx) {
    final surface = Theme.of(ctx).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Hero(
        tag: 'search_pill_hero_${widget.viewAs.name}',
        child: Material(
          color: surface,
          borderRadius: BorderRadius.circular(14),
          elevation: 2,
          shadowColor: Colors.black12,
          child: SizedBox(
            height: 52,
            child: Row(
              children: [
                const SizedBox(width: 14),
                Icon(Icons.search_rounded, color: _accent, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    style: AppTypography.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Search vendors…',
                      hintStyle: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textHint),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (q) =>
                        ctx.read<SearchCubit>().queryChanged(q),
                  ),
                ),
                // Clear / back button
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (listenerCtx, val, child) => val.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded,
                              size: 20, color: AppColors.textHint),
                          onPressed: () {
                            _controller.clear();
                            ctx.read<SearchCubit>().clear();
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.arrow_back_rounded,
                              size: 22, color: AppColors.textHint),
                          onPressed: () => context.pop(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Category chips ─────────────────────────────────────────────────────────

  Widget _buildCategoryChips(BuildContext ctx) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _kCategories.length + 1, // +1 for "All"
        separatorBuilder: (sepCtx, idx) => const SizedBox(width: 8),
        itemBuilder: (itemCtx, i) {
          final isAll = i == 0;
          final label = isAll ? 'All' : _kCategories[i - 1];
          final selected =
              isAll ? _selectedCategory == null : _selectedCategory == label;

          return ChoiceChip(
            label: Text(label),
            selected: selected,
            onSelected: (_) {
              setState(
                  () => _selectedCategory = isAll ? null : label);
              ctx
                  .read<SearchCubit>()
                  .categorySelected(isAll ? null : label);
            },
            selectedColor: _accent.withValues(alpha: 0.15),
            checkmarkColor: _accent,
            labelStyle: AppTypography.bodySmall.copyWith(
              color: selected ? _accent : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
            side: BorderSide(
              color: selected
                  ? _accent.withValues(alpha: 0.5)
                  : Theme.of(context).dividerColor,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }

  // ── Results ────────────────────────────────────────────────────────────────

  Widget _buildResults() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (ctx, state) {
        return switch (state) {
          SearchInitialState() => _Hint(accent: _accent),
          SearchLoadingState() => const Center(
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
          SearchLoadedState(results: final r) when r.isEmpty =>
            _EmptyResult(query: state.query, accent: _accent),
          SearchLoadedState(results: final r) => _ResultsList(
              results: r,
              accent: _accent,
              viewAs: widget.viewAs,
            ),
          SearchErrorState(message: final m) => _ErrorView(
              message: m,
              onRetry: () {
                ctx.read<SearchCubit>().queryChanged(_controller.text);
              },
            ),
        };
      },
    );
  }
}

// ── Result list ───────────────────────────────────────────────────────────────

class _ResultsList extends StatelessWidget {
  final List<VendorSearchResult> results;
  final Color accent;
  final SearchViewAs viewAs;

  const _ResultsList({
    required this.results,
    required this.accent,
    required this.viewAs,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      itemCount: results.length,
      separatorBuilder: (sepCtx, idx) => const SizedBox(height: 8),
      itemBuilder: (itemCtx, i) => _ResultCard(
        result: results[i],
        accent: accent,
        viewAs: viewAs,
      ),
    );
  }
}

// ── Single result card ────────────────────────────────────────────────────────

class _ResultCard extends StatelessWidget {
  final VendorSearchResult result;
  final Color accent;
  final SearchViewAs viewAs;

  const _ResultCard({
    required this.result,
    required this.accent,
    required this.viewAs,
  });

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    final initial = (result.businessName?.isNotEmpty == true
            ? result.businessName!
            : result.name)[0]
        .toUpperCase();

    return Material(
      color: surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          // TODO: navigate to vendor public profile screen when built
        },
        borderRadius: BorderRadius.circular(16),
        splashColor: accent.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: result.profilePhotoUrl != null
                    ? ClipOval(
                        child: Image.network(
                          result.profilePhotoUrl!,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (errCtx, error, stackTrace) => Text(
                            initial,
                            style: TextStyle(
                              color: accent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        initial,
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
              ),
              const SizedBox(width: 14),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Business name (primary)
                    Text(
                      result.displayName,
                      style: AppTypography.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (result.businessName != null &&
                        result.businessName != result.name) ...[
                      const SizedBox(height: 2),
                      Text(
                        result.name,
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                    const SizedBox(height: 6),
                    // Category chip
                    if (result.businessCategory != null)
                      _CategoryChip(
                        label: result.businessCategory!,
                        accent: accent,
                      ),
                    // Address
                    if (result.businessAddress != null &&
                        result.businessAddress!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 12,
                              color: AppColors.textHint),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              result.businessAddress!,
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.textHint),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Chevron
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.textHint, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Category chip ─────────────────────────────────────────────────────────────

class _CategoryChip extends StatelessWidget {
  final String label;
  final Color accent;

  const _CategoryChip({required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: accent,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Empty / hint / error states ───────────────────────────────────────────────

class _Hint extends StatelessWidget {
  final Color accent;
  const _Hint({required this.accent});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.storefront_outlined, size: 56,
              color: accent.withValues(alpha: 0.25)),
          const SizedBox(height: 16),
          Text(
            'Find vendors near you',
            style: AppTypography.h3
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'Search by name, business name,\nor select a category above.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textHint, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _EmptyResult extends StatelessWidget {
  final String query;
  final Color accent;
  const _EmptyResult({required this.query, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 56,
              color: accent.withValues(alpha: 0.25)),
          const SizedBox(height: 16),
          Text('No vendors found', style: AppTypography.h3
              .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Text(
            'No results for "$query".\nTry a different name or category.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textHint, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 48, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text('Something went wrong',
                style: AppTypography.h3
                    .copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textHint),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
