import '../../../../core/utils/typedefs.dart';
import '../../../shared/dtos/sign_in_dto.dart';

abstract class AuthRepository {
  ResultFuture<bool> signInWithPassword({
    required SignInDto param,
  });

  ResultFuture<bool> signOut();
}
