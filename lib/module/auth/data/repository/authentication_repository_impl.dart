import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../../shared/dtos/sign_in_dto.dart';
import '../../domain/repository/authentication_repository.dart';
import '../remote_data_source/authentication_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });
  final AuthRemoteDataSource authRemoteDataSource;

  @override
  ResultFuture<bool> signInWithPassword({required SignInDto param}) async {
    try {
      final bool responseData = await authRemoteDataSource.signInWithPassword(
        param: param,
      );
      return Right(responseData);
    } on Exception catch (exception) {
      return handleRepositoryException(
        exception,
        'signInWithPassword',
      );
    }
  }

  @override
  ResultFuture<bool> signOut() async {
    try {
      final bool responseData = await authRemoteDataSource.signOut();
      return Right(responseData);
    } on Exception catch (exception) {
      return handleRepositoryException(
        exception,
        'signOut',
      );
    }
  }
}
