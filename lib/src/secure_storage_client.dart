import 'dart:async';

import 'package:common_classes/common_classes.dart';
import 'package:secure_storage_client/src/secure_storage_failure.dart';

abstract class SecureStorageClient {
  /// Read
  ///
  /// Read the data from the secure storage
  ///
  /// [key] is the key of the data to be read. It is required and cannot be empty
  ///
  /// Returns [String] if the data is found
  ///
  /// Throws [SecureStorageFailure] if an error occurs while reading the data from storage
  ///
  ///   - [SecureStorageReadFailure] if an error occurs while reading the data from storage
  ///
  ///   - [SecureStorageKeyNotFound] if the key is not found in the storage
  ///
  ///   - [SecureStorageValueNotFound] if the value is not found in the storage
  ///
  ///   - [SecureStorageInitializationFailure] if secure storage is not initialized
  ///
  FutureOr<Result<String>> read({
    required String key,
  });

  /// Write
  ///
  /// Write the data to the secure storage
  ///
  /// [key] is the key of the data to be written. It is required and cannot be empty
  ///
  /// [value] is the data to be written
  ///
  /// Throws [SecureStorageFailure] if an error occurs while writing the data to storage
  ///
  ///   - [SecureStorageWriteFailure] if an error occurs while writing the data to storage
  ///
  ///   - [SecureStorageInitializationFailure] if secure storage is not initialized
  ///
  FutureOr<Result<void>> write({
    required String key,
    required String value,
  });

  /// Delete
  ///
  /// Delete the data from the secure storage
  ///
  /// [key] is the key of the data to be deleted. It is required and cannot be empty
  ///
  /// Throws [SecureStorageFailure] if an error occurs while deleting the data from storage
  ///
  ///   - [SecureStorageWriteFailure] if an error occurs while deleting the data from storage
  ///
  ///   - [SecureStorageInitializationFailure] if secure storage is not initialized
  ///
  ///   - [SecureStorageKeyNotFound] if the key is not found in the storage
  ///
  FutureOr<Result<void>> delete({
    required String key,
  });

  /// Clear
  ///
  /// Clear all the data from the secure storage
  ///
  /// Throws [SecureStorageFailure] if an error occurs while clearing the data from storage
  ///
  ///   - [SecureStorageWriteFailure] if an error occurs while clearing the data from storage
  ///
  ///   - [SecureStorageInitializationFailure] if secure storage is not initialized
  ///
  FutureOr<Result<void>> clear();
}
