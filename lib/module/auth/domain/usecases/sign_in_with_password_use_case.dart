import '../../../../core/usecase/usecases.dart';
import '../../../../core/utils/typedefs.dart';
import '../../../shared/dtos/sign_in_dto.dart';
import '../repository/authentication_repository.dart';

class SignInWithPasswordUseCase extends UseCaseWithParams<bool, SignInDto> {
  SignInWithPasswordUseCase({
    required this.authRepository,
  });
  final AuthRepository authRepository;

  @override
  ResultFuture<bool> call(SignInDto params) async =>
      await authRepository.signInWithPassword(
        param: params,
      );
}
