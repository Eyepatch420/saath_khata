import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_logger.dart';

/// Global BLoC observer — wired once in main().
/// Logs every event, state transition, and error across all BLoCs.
class AppBlocObserver extends BlocObserver {
  static const _m = 'BLoC';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.i(_m, '▶ Created  ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.v(_m, '→ Event    ${bloc.runtimeType}  ← ${event.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.i(
      _m,
      '↔ State    ${bloc.runtimeType}  '
      '${transition.currentState.runtimeType} → ${transition.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.e(_m, '💥 Error    ${bloc.runtimeType}', error);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogger.i(_m, '■ Closed   ${bloc.runtimeType}');
  }
}
