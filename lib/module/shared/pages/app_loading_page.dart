import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_web/core/enums/router_path_enum.dart';
import 'package:note_app_web/module/shared/blocs/guard_route_bloc/guard_route_bloc.dart';
import 'package:note_app_web/module/shared/blocs/guard_route_bloc/guard_route_event.dart';
import 'package:note_app_web/module/shared/blocs/guard_route_bloc/guard_route_state.dart';

class AppLoadingPage extends StatefulWidget {
  const AppLoadingPage({
    super.key,
  });
  @override
  State<AppLoadingPage> createState() => _AppLoadingPageState();
}

class _AppLoadingPageState extends State<AppLoadingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            context.read<GuardRouteBloc>().add(LoadUserSessionRequested());
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: BlocConsumer<GuardRouteBloc, GuardRouteState>(
        listener: (BuildContext context, GuardRouteState state) {
          if (state is LoadedUserSession) {
            RoutePath.home.go(context);
          }
        },
        builder: (BuildContext context, GuardRouteState state) {
          return const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  EvaIcons.edit2Outline,
                  size: 62,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 64,
                ),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
