import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class SignInInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class SignInLoading extends AuthenticationState {
  @override
  List<String> get props => [];
}

class SignInSuccess extends AuthenticationState {
  @override
  List<String> get props => [];
}

class UserInvalidCredential extends AuthenticationState {
  UserInvalidCredential({
    required this.message,
  });
  final String message;
  @override
  List<String> get props => <String>[];
}

class SignInFailed extends AuthenticationState {
  SignInFailed({
    required this.message,
  });

  final String message;

  @override
  List<String> get props => [
        message,
      ];
}

class SignOutLoading extends AuthenticationState {
  @override
  List<Object?> get props => <Object?>[];
}

class SignOutSuccess extends AuthenticationState {
  @override
  List<Object?> get props => <Object?>[];
}

class SignOutFailed extends AuthenticationState {
  SignOutFailed({
    required this.message,
  });

  final String message;

  @override
  List<String> get props => [
        message,
      ];
}
