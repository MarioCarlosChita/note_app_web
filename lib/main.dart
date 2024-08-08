import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/router.dart';
import 'core/services/guard_route_service.dart';
import 'core/services/supabase_initialize_service.dart';
import 'di.dart';
import 'module/auth/presentation/blocs/authentication_bloc.dart';
import 'module/note/presentation/blocs/note_bloc.dart';
import 'module/shared/blocs/guard_route_bloc/guard_route_bloc.dart';

void main() async {
  await injections();
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Supabase
  await SupabaseInitializeService.initializeSupabase();
  // Get user session to validate the Route.
  await GuardRouteService.fetchUserSession();
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NoteBloc(
            getNoteUseCase: locator.get(),
            addNoteUseCase: locator.get(),
            editNoteUseCase: locator.get(),
            removeNoteUseCase: locator.get(),
            statusNoteUseCase: locator.get(),
          ),
        ),
        BlocProvider(
          create: (_) => GuardRouteBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AuthenticationBloc(
            signInWithPasswordUseCase: locator.get(),
            signOutUseCase: locator.get(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
