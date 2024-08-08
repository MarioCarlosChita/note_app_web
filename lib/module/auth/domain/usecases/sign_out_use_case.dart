import '../../../../core/usecase/usecases.dart';
import '../../../../core/utils/typedefs.dart';
import '../repository/authentication_repository.dart';

class SignOutUseCase extends UseCaseWithoutParams<bool> {
  SignOutUseCase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  ResultFuture<bool> call() async => authRepository.signOut();
}
