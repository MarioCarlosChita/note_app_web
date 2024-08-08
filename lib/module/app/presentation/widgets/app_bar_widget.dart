import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/router_path_enum.dart';
import '../../../../core/extentions/string_extention.dart';
import '../../../../core/services/guard_route_service.dart';
import '../../../auth/presentation/blocs/authentication_bloc.dart';
import '../../../auth/presentation/blocs/authentication_event.dart';
import '../../../auth/presentation/blocs/authentication_state.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  void _onSignOutSubmitted({
    required String option,
  }) {
    bool isLogOut = option.toLowerCase().contains('logout');

    if (isLogOut) {
      context.read<AuthenticationBloc>().add(SignOutRequested());
    }
  }

  void _onRedirectToLogin() {
    GuardRouteService.currentUser = null;
    GuardRouteService.isUserAuthenticated = false;
    RoutePath.login.go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red,
            maxRadius: 23,
            child: Text(
              (GuardRouteService.currentUser?.name ?? '')
                  .getFirstAndLastUserCharacter()
                  .toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(GuardRouteService.currentUser?.name ?? ''),
          const Spacer(),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen: (previous, current) {
              if (current is SignOutFailed ||
                  current is SignOutLoading ||
                  current is SignOutSuccess) {
                return true;
              }
              return false;
            },
            listener: (BuildContext context, AuthenticationState state) {
              if (state is SignOutSuccess) {
                _onRedirectToLogin();
              }
            },
            child: PopupMenuButton<String>(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              position: PopupMenuPosition.under,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              icon: const Icon(
                Icons.person_outline,
                color: Colors.blueAccent,
                size: 32,
              ),
              itemBuilder: (BuildContext context) {
                return {'Logout'}.map(
                  (String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                      onTap: () {
                        _onSignOutSubmitted(option: choice);
                      },
                    );
                  },
                ).toList();
              },
            ),
          )
        ],
      ),
    );
  }
}
