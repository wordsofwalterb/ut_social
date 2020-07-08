import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:ut_social/core/util/globals.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object event) {
    super.onEvent(bloc, event);
    Global.analytics.logEvent(
      name: event.toString(),
      parameters: {
        'description': bloc.toString(),
      },
    );
    print(event);
  }

  @override
  void onError(
      Bloc<dynamic, dynamic> bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    Global.analytics.logEvent(
      name: 'Error',
      parameters: {
        'description': error.toString(),
      },
    );
    print(error);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
