import 'package:equatable/equatable.dart';
import 'package:note_app_web/module/shared/dtos/sign_in_dto.dart';

abstract class AuthenticationEvent extends Equatable {}

class SignInRequested extends AuthenticationEvent {
  SignInRequested({
    required this.param,
  });

  final SignInDto param;

  @override
  List<SignInDto> get props => [
        param,
      ];
}

class SignOutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
