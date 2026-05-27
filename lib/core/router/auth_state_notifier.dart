import 'package:flutter/foundation.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';

/// Bridges AuthBloc to GoRouter's refreshListenable so the router
/// re-evaluates its redirect whenever auth state changes.
class AuthStateNotifier extends ChangeNotifier {
  AuthState _authState = const AuthInitial();

  AuthState get authState => _authState;

  void onAuthStateChanged(AuthState state) {
    _authState = state;
    notifyListeners();
  }
}
