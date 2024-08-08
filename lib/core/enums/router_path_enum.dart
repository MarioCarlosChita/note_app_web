import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RoutePath {
  login("/login"),
  home("/home"),
  initial("/");

  const RoutePath(this.path);
  final String path;

  /// Shortcut for `context.go()`
  void go(BuildContext context, {Object? extra}) => context.go(
        path,
        extra: extra,
      );

  /// Shortcut for `context.push()`
  void push(BuildContext context, {Object? extra}) => context.push(
        path,
        extra: extra,
      );
}
