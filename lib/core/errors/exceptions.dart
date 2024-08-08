import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Represents an exception thrown by the server, containing a message and a status code.
class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<dynamic> get props => <String>[
        message,
        statusCode,
      ];
}

/// Defines an exception for internal errors, including a descriptive message and a specific status code.
class InternalException extends Equatable implements Exception {
  const InternalException({
    required this.message,
    this.statusCode = 500,
  });

  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => <dynamic>[
        message,
        statusCode,
      ];
}

/// Converts an `Object? exception` into a [Exception] for DataSource
Exception handleDataSourceException(
  Object? exception,
  String methodName,
) {
  debugPrint('##### DataSource Exception ($methodName): $exception #####');

  if (exception is AuthException) {
    throw AuthException(
      exception.message,
      statusCode: exception.statusCode,
    );
  }

  if (exception is ServerException) {
    throw ServerException(
      message: exception.message,
      statusCode: exception.statusCode,
    );
  } else {
    throw InternalException(
      message: exception.toString(),
    );
  }
}
