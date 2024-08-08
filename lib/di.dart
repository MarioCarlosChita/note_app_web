import 'package:get_it/get_it.dart';

import 'core/network/app_supabase_client.dart';
import 'module/auth/data/remote_data_source/authentication_remote_data_source.dart';
import 'module/auth/data/repository/authentication_repository_impl.dart';
import 'module/auth/domain/repository/authentication_repository.dart';
import 'module/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'module/auth/domain/usecases/sign_out_use_case.dart';
import 'module/note/data/data_remote_source/note_remote_data_source.dart';
import 'module/note/data/repository/note_repository_impl.dart';
import 'module/note/domain/repository/note_repository.dart';
import 'module/note/domain/usecases/add_note_use_case.dart';
import 'module/note/domain/usecases/edit_note_use_case.dart';
import 'module/note/domain/usecases/get_note_use_case.dart';
import 'module/note/domain/usecases/remove_note_use_case.dart';
import 'module/note/domain/usecases/status_note_use_case.dart';

var locator = GetIt.instance;

Future<void> injections() async {
  // Supabase Http Client
  locator.registerLazySingleton<AppSupabaseClient>(() => AppSupabaseClient());
  // Authentication
  await _authenticationDependencies();
  // Notes
  await _noteDependencies();
}

Future<void> _authenticationDependencies() async {
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(appSupabaseClient: locator.get()),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: locator.get()),
  );

  locator.registerLazySingleton<SignInWithPasswordUseCase>(
    () => SignInWithPasswordUseCase(authRepository: locator.get()),
  );

  locator.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(
      authRepository: locator.get(),
    ),
  );
}

Future<void> _noteDependencies() async {
  locator.registerLazySingleton<NoteRemoteDataSource>(
    () => NoteRemoteDataSourceImpl(
      appSupabaseClient: locator.get(),
    ),
  );

  locator.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(
      noteRemoteDataSource: locator.get(),
    ),
  );

  locator.registerLazySingleton<GetNoteUseCase>(
    () => GetNoteUseCase(
      noteRepository: locator.get(),
    ),
  );

  locator.registerLazySingleton<AddNoteUseCase>(
    () => AddNoteUseCase(
      noteRepository: locator.get(),
    ),
  );
  locator.registerLazySingleton<EditNoteUseCase>(
    () => EditNoteUseCase(noteRepository: locator.get()),
  );
  locator.registerLazySingleton<RemoveNoteUseCase>(
    () => RemoveNoteUseCase(
      noteRepository: locator.get(),
    ),
  );
  locator.registerLazySingleton<StatusNoteUseCase>(
    () => StatusNoteUseCase(
      noteRepository: locator.get(),
    ),
  );
}
