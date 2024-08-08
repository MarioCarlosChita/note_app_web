import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/enums/router_path_enum.dart';
import '../../../../core/helper/form_validator_helper.dart';
import '../../../../core/services/guard_route_service.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/utils/strings.dart';
import '../../../shared/dtos/sign_in_dto.dart';
import '../blocs/authentication_bloc.dart';
import '../blocs/authentication_event.dart';
import '../blocs/authentication_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  void _onSignInSubmitted() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<AuthenticationBloc>().add(
            SignInRequested(
              param: SignInDto(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            ),
          );
    }
  }

  void _onShowSnackBar(
    BuildContext context,
    String message,
  ) {
    SnackBarService.showSnackBar(
      context: context,
      message: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 400,
          ),
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            buildWhen: (previous, current) {
              if (current is SignInFailed ||
                  current is SignInLoading ||
                  current is SignInSuccess) {
                return true;
              }
              return false;
            },
            listener: (BuildContext context, AuthenticationState state) {
              if (state is SignInSuccess) {
                GuardRouteService.isUserAuthenticated = true;
                RoutePath.initial.go(context);
              }
              if (state is SignInFailed) {
                _onShowSnackBar(context, state.message);
              }
              if (state is UserInvalidCredential) {
                _onShowSnackBar(context, state.message);
              }
            },
            builder: (BuildContext context, AuthenticationState state) {
              return Column(
                children: [
                  const Icon(
                    EvaIcons.edit2Outline,
                    size: 62,
                    color: Colors.lightBlue,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  FormBuilderTextField(
                    name: 'email',
                    controller: _emailController,
                    validator: FormValidatorHelper.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabled: state is! SignInLoading,
                      fillColor: Colors.white,
                      filled: true,
                      focusColor: Colors.blueAccent,
                      hintText: "Email",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    controller: _passwordController,
                    obscureText: _isPasswordHidden,
                    keyboardType: TextInputType.visiblePassword,
                    validator: FormValidatorHelper.validatePassword,
                    decoration: InputDecoration(
                      enabled: state is! SignInLoading,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                        icon: _isPasswordHidden
                            ? const Icon(
                                Icons.visibility_off_outlined,
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                              ),
                      ),
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusColor: Colors.blueAccent,
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: const Text(
                          "Forget password?",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: _onSignInSubmitted,
                        height: 42,
                        minWidth: 120,
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: state is SignInLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text(
                                enter,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
