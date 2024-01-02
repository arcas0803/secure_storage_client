import 'package:common_classes/common_classes.dart';

sealed class SecureStorageFailure extends Failure {
  SecureStorageFailure(
      {required super.message,
      required super.error,
      required super.stackTrace});
}

final class SecureStorageReadFailure extends SecureStorageFailure {
  SecureStorageReadFailure({
    String message = 'Error reading data from secure storage',
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: message,
          error: error,
          stackTrace: stackTrace,
        );
}

final class SecureStorageWriteFailure extends SecureStorageFailure {
  SecureStorageWriteFailure({
    String message = 'Error writing data to secure storage',
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: message,
          error: error,
          stackTrace: stackTrace,
        );
}

final class SecureStorageInitializationFailure extends SecureStorageFailure {
  SecureStorageInitializationFailure({
    String message = 'Error initializing secure storage.',
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: message,
          error: error,
          stackTrace: stackTrace,
        );
}

final class SecureStorageKeyNotFound extends SecureStorageFailure {
  SecureStorageKeyNotFound({
    required String key,
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: 'Key $key not found in secure storage',
          error: error,
          stackTrace: stackTrace,
        );
}

final class SecureStorageValueNotFound extends SecureStorageFailure {
  SecureStorageValueNotFound({
    required String value,
    required String error,
    required StackTrace stackTrace,
  }) : super(
          message: 'Value $value not found in secure storage',
          error: error,
          stackTrace: stackTrace,
        );
}
