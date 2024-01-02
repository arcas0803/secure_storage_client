import 'dart:async';

import 'package:common_classes/common_classes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:secure_storage_client/src/secure_storage_client.dart';
import 'package:secure_storage_client/src/secure_storage_failure.dart';

/// Implementation of the [SecureStorageClient] interface
///
/// This implementation uses the [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) package
///
class SecureStorageClientImpl implements SecureStorageClient {
  final FlutterSecureStorage _flutterSecureStorage;

  final Logger? _logger;

  final FutureOr<void> Function(Failure)? _telemetryOnError;

  final FutureOr<void> Function()? _telemetryOnSuccess;

  /// [logger] is a logger instance to log the events. If not provided, no logs will be printed
  ///
  /// [telemetryOnError] is a function that will be called when an error occurs. It is used to send telemetry to the server. If not provided, no telemetry will be sent
  ///
  /// [telemetryOnSuccess] is a function that will be called when an operation is successful. It is used to send telemetry to the server. If not provided, no telemetry will be sent
  ///
  SecureStorageClientImpl({
    Logger? logger,
    FutureOr<void> Function(Failure)? telemetryOnError,
    FutureOr<void> Function()? telemetryOnSuccess,
  })  : _flutterSecureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        ),
        _logger = logger,
        _telemetryOnError = telemetryOnError,
        _telemetryOnSuccess = telemetryOnSuccess;

  @override
  FutureOr<Result<void>> clear() {
    _logger?.d('[Start] Clearing secure storage');
    return Result.asyncGuard<void>(
      () async {
        await _flutterSecureStorage.deleteAll();

        _logger?.d('[Success] Secure storage cleared');

        _telemetryOnSuccess?.call();
      },
      onError: (error, stackTrace) {
        final failure = SecureStorageWriteFailure(
          error: error.toString(),
          stackTrace: stackTrace,
        );

        _logger?.e(
          '[Error] Error clearing secure storage',
          time: DateTime.now(),
          error: error,
          stackTrace: stackTrace,
        );

        _telemetryOnError?.call(
          failure,
        );
        return failure;
      },
    );
  }

  @override
  FutureOr<Result<void>> delete({required String key}) {
    _logger?.d('[Start] Deleting key $key from secure storage');

    if (key.isEmpty) {
      final failure = SecureStorageWriteFailure(
        error: 'Key cannot be empty',
        stackTrace: StackTrace.current,
      );

      _logger?.e('[Error] Key cannot be empty');

      _telemetryOnError?.call(failure);

      return Result<void>.error(
        failure,
      );
    }

    return Result.asyncGuard(
      () async {
        _logger?.d('[Process] checking if key $key exists in secure storage');
        final keyExist = await _flutterSecureStorage.containsKey(key: key);

        if (!keyExist) {
          throw SecureStorageKeyNotFound(
            key: key,
            error: 'Key $key not found in secure storage',
            stackTrace: StackTrace.current,
          );
        }

        await _flutterSecureStorage.delete(key: key);

        _logger?.d('[Success] Key $key deleted from secure storage');

        _telemetryOnSuccess?.call();
      },
      onError: (error, stackTrace) {
        _logger?.e(
          '[Error] Key $key not found in secure storage',
          time: DateTime.now(),
          error: error,
          stackTrace: stackTrace,
        );
        if (error is SecureStorageKeyNotFound) {
          _telemetryOnError?.call(error);

          return error;
        }

        final failure = SecureStorageWriteFailure(
          error: error.toString(),
          stackTrace: stackTrace,
        );

        _telemetryOnError?.call(failure);

        return failure;
      },
    );
  }

  @override
  FutureOr<Result<String>> read({required String key}) {
    _logger?.d('[Start] Reading key $key from secure storage');

    if (key.isEmpty) {
      final failure = SecureStorageReadFailure(
        error: 'Key cannot be empty',
        stackTrace: StackTrace.current,
      );

      _logger?.e('[Error] Key cannot be empty');

      _telemetryOnError?.call(failure);

      return Result<String>.error(
        failure,
      );
    }

    return Result.asyncGuard<String>(
      () async {
        _logger?.d('[Process] checking if key $key exists in secure storage');
        final keyExist = await _flutterSecureStorage.containsKey(key: key);

        if (!keyExist) {
          throw SecureStorageKeyNotFound(
            key: key,
            error: 'Key $key not found in secure storage',
            stackTrace: StackTrace.current,
          );
        }

        _logger?.d('[Process] reading key $key from secure storage');
        final value = await _flutterSecureStorage.read(key: key);

        if (value == null) {
          throw SecureStorageValueNotFound(
            value: 'No value found for key $key',
            error: 'Value $value not found in secure storage',
            stackTrace: StackTrace.current,
          );
        }

        _logger?.d('[Success] Key $key read from secure storage');
        _telemetryOnSuccess?.call();
        return value;
      },
      onError: (error, stackTrace) {
        _logger?.e(
          '[Error] Key $key not found in secure storage',
          time: DateTime.now(),
          error: error,
          stackTrace: stackTrace,
        );

        switch (error) {
          case SecureStorageKeyNotFound:
            _telemetryOnError?.call(error as SecureStorageKeyNotFound);
            return error as SecureStorageKeyNotFound;
          case SecureStorageValueNotFound:
            _telemetryOnError?.call(error as SecureStorageValueNotFound);
            return error as SecureStorageValueNotFound;
          default:
            final failure = SecureStorageReadFailure(
              error: error.toString(),
              stackTrace: stackTrace,
            );

            _telemetryOnError?.call(failure);

            return failure;
        }
      },
    );
  }

  @override
  FutureOr<Result<void>> write({required String key, required String value}) {
    _logger?.d('[Start] Writing key $key to secure storage');

    if (key.isEmpty) {
      final failure = SecureStorageWriteFailure(
        error: 'Key cannot be empty',
        stackTrace: StackTrace.current,
      );

      _logger?.e('[Error] Key cannot be empty');

      _telemetryOnError?.call(failure);

      return Result<void>.error(
        failure,
      );
    }

    if (value.isEmpty) {
      final failure = SecureStorageWriteFailure(
        error: 'Value cannot be empty',
        stackTrace: StackTrace.current,
      );

      _logger?.e('[Error] Value cannot be empty');

      return Result<void>.error(
        failure,
      );
    }

    return Result.asyncGuard<void>(
      () async {
        _logger?.d('[Process] writing key $key to secure storage');

        await _flutterSecureStorage.write(key: key, value: value);

        _logger?.d('[Success] Key $key written to secure storage');

        _telemetryOnSuccess?.call();
      },
      onError: (error, stackTrace) {
        _logger?.e(
          '[Error] Error writing key $key to secure storage',
          time: DateTime.now(),
          error: error,
          stackTrace: stackTrace,
        );

        final failure = SecureStorageWriteFailure(
          error: error.toString(),
          stackTrace: stackTrace,
        );

        _telemetryOnError?.call(failure);

        return failure;
      },
    );
  }
}
