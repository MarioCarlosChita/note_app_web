import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app_web/core/errors/failures.dart';
import 'package:note_app_web/core/utils/strings.dart';
import 'package:note_app_web/module/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:note_app_web/module/auth/domain/usecases/sign_out_use_case.dart';
import 'package:note_app_web/module/auth/presentation/blocs/authentication_event.dart';
import 'package:note_app_web/module/auth/presentation/blocs/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.signInWithPasswordUseCase,
    required this.signOutUseCase,
  }) : super(SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  final SignInWithPasswordUseCase signInWithPasswordUseCase;
  final SignOutUseCase signOutUseCase;

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(SignOutLoading());
    final Either<Failure, bool> result = await signOutUseCase();
    result.fold(
      (Failure failure) => emit(SignOutFailed(message: failure.message)),
      (bool data) => emit(SignOutSuccess()),
    );
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(SignInLoading());

    final Either<Failure, bool> result = await signInWithPasswordUseCase(
      event.param,
    );

    result.fold(
      (Failure failure) {
        if (failure is AuthFailure) {
          emit(
            SignInFailed(message: userInvalidCredential),
          );
        } else {
          emit(
            SignInFailed(
              message: failure.message,
            ),
          );
        }
      },
      (bool data) => emit(
        SignInSuccess(),
      ),
    );
  }
}
