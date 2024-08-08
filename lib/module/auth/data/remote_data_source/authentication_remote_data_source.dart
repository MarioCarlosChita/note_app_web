import 'package:note_app_web/core/errors/exceptions.dart';
import 'package:note_app_web/core/network/app_supabase_client.dart';
import 'package:note_app_web/module/shared/dtos/sign_in_dto.dart';

abstract class AuthRemoteDataSource {
  Future<bool> signInWithPassword({
    required SignInDto param,
  });

  Future<bool> signOut();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.appSupabaseClient,
  });
  final AppSupabaseClient appSupabaseClient;

  @override
  Future<bool> signInWithPassword({
    required SignInDto param,
  }) async {
    try {
      await appSupabaseClient.supabase.auth.signInWithPassword(
        email: param.email,
        password: param.password,
      );
      return true;
    } catch (exception) {
      throw handleDataSourceException(
        exception,
        'signInWithPassword',
      );
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await appSupabaseClient.supabase.auth.signOut();
      return true;
    } catch (exception) {
      throw handleDataSourceException(
        exception,
        'signOut',
      );
    }
  }
}
