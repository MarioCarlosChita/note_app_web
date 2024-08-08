import 'package:equatable/equatable.dart';

abstract class GuardRouteState extends Equatable {}

class GuardRouteLoading extends GuardRouteState {
  @override
  List<Object?> get props => [];
}

class GuardRouteInitial extends GuardRouteState {
  @override
  List<Object?> get props => [];
}

class LoadedUserSession extends GuardRouteState {
  @override
  List<Object?> get props => [];
}

class GuardRouteUseSessionFailed extends GuardRouteState {
  @override
  List<Object?> get props => [];
}
