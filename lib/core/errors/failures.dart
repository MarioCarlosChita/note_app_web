import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note_app_web/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Represents a general failure in the application.
abstract class Failure extends Equatable {
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(statusCode is String || statusCode is int,
            'StatusCode cannot be a ${statusCode.runtimeType}');

  final String message;
  final dynamic statusCode;

  /// Formats the error message.
  String get errorMessage {
    final bool showErrorText =
        statusCode is String || int.tryParse(statusCode.toString()) != null;
    return '$statusCode ${showErrorText ? 'Error' : ''}: $message';
  }

  @override
  List<dynamic> get props => <dynamic>[
        message,
        statusCode,
      ];
}

//  Defines a failure related with supabase authentication.
class AuthFailure extends Failure {
  AuthFailure({
    required super.message,
    required super.statusCode,
  });

  AuthFailure.fromException(
    AuthException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
  @override
  String toString() {
    return '$statusCode Error: $message';
  }
}

/// Failure due to an internal error.
class InternalFailure extends Failure {
  InternalFailure({
    required super.message,
    required super.statusCode,
  });

  InternalFailure.fromException(
    InternalException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
  @override
  String toString() {
    return '$statusCode Error: $message';
  }
}

/// Failure due to a server error.
class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
  @override
  String toString() {
    return '$statusCode Error: $message';
  }
}

/// Converts an [Exception] from DataSource into a [Failure] for Repository
Left<Failure, T> handleRepositoryException<T>(
  Exception exception,
  String methodName,
) {
  debugPrint('$exception');

  if (exception is AuthException) {
    return Left<Failure, T>(
      AuthFailure.fromException(
        exception,
      ),
    );
  }

  if (exception is ServerException) {
    return Left<Failure, T>(
      ServerFailure.fromException(exception),
    );
  }
  return Left<Failure, T>(
    InternalFailure.fromException(exception as InternalException),
  );
}
