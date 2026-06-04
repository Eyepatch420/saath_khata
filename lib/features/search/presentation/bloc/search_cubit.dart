import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repo;
  Timer? _debounce;

  String _query = '';
  String? _category;

  SearchCubit(this._repo) : super(const SearchInitialState());

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  // ── Public API ──────────────────────────────────────────────────────────────

  void queryChanged(String q) {
    _query = q.trim();
    _debounce?.cancel();

    if (_query.isEmpty && _category == null) {
      emit(const SearchInitialState());
      return;
    }

    emit(const SearchLoadingState());
    _debounce = Timer(const Duration(milliseconds: 420), _execute);
  }

  void categorySelected(String? category) {
    _category = category;
    _debounce?.cancel();

    if (_query.isEmpty && _category == null) {
      emit(const SearchInitialState());
      return;
    }

    // Category changes fire immediately — no debounce needed.
    emit(const SearchLoadingState());
    _execute();
  }

  void clear() {
    _query = '';
    _category = null;
    _debounce?.cancel();
    emit(const SearchInitialState());
  }

  // ── Private ─────────────────────────────────────────────────────────────────

  Future<void> _execute() async {
    try {
      final results = await _repo.searchVendors(
        q: _query.isEmpty ? null : _query,
        category: _category,
      );
      // Guard against emitting after close or superseded request.
      if (!isClosed) {
        emit(SearchLoadedState(
          results: results,
          query: _query,
          category: _category,
        ));
      }
    } catch (e) {
      if (!isClosed) {
        emit(SearchErrorState(
          message: e.toString().replaceFirst('Exception: ', ''),
        ));
      }
    }
  }
}
