import 'package:equatable/equatable.dart';

abstract class GuardRouteEvent extends Equatable {}

class LoadUserSessionRequested extends GuardRouteEvent {
  @override
  List<Object?> get props => [];
}
