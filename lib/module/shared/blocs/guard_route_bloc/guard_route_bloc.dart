import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_web/core/services/guard_route_service.dart';
import 'package:note_app_web/module/shared/blocs/guard_route_bloc/guard_route_event.dart';
import 'package:note_app_web/module/shared/blocs/guard_route_bloc/guard_route_state.dart';

class GuardRouteBloc extends Bloc<GuardRouteEvent, GuardRouteState> {
  GuardRouteBloc() : super(GuardRouteInitial()) {
    on<LoadUserSessionRequested>(_onLoadUserSessionRequested);
  }

  Future<void> _onLoadUserSessionRequested(
    LoadUserSessionRequested event,
    Emitter<GuardRouteState> emit,
  ) async {
    emit(GuardRouteLoading());
    await GuardRouteService.fetchUserSession();
    emit(LoadedUserSession());
  }
}
