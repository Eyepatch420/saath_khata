import '../../domain/models/vendor_search_result.dart';

sealed class SearchState {
  const SearchState();
}

/// Before the user has typed anything.
class SearchInitialState extends SearchState {
  const SearchInitialState();
}

/// Debounce delay or API in-flight.
class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

/// Results available (may be an empty list).
class SearchLoadedState extends SearchState {
  final List<VendorSearchResult> results;
  final String query;
  final String? category;

  const SearchLoadedState({
    required this.results,
    required this.query,
    this.category,
  });
}

/// Network or server error.
class SearchErrorState extends SearchState {
  final String message;
  const SearchErrorState({required this.message});
}
