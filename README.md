# Secure Storage Client

This is a client for the access to the secure storage service.

It's base on [FlutterSecureStorage](https://pub.dev/packages/flutter_secure_storage) package.

## Getting Started

### Installation

Add the following to your `pubspec.yaml` file:

```yaml

dependencies:
  secure_storage_client: ^0.0.1
    git:
      url: https://github.com/arcas0803/secure_storage_client.git
      ref: main

```

## Usage

### Import

```dart

import 'package:secure_storage_client/secure_storage_client.dart';

```

### Methods

#### read

```dart

final secureStorage = SecureStorage();

secureStorage.read(key: 'your_key');

```

#### write

```dart

final secureStorage = SecureStorage();

secureStorage.write(key: 'your_key', value: 'your_value');

```

#### delete

```dart

final secureStorage = SecureStorage();

secureStorage.delete(key: 'your_key');

```

#### Clean

```dart

final secureStorage = SecureStorage();

secureStorage.clean();

```

### Configuration

#### Logger

It's possible to enable the logger to see the logs of the client.

Just pass the `logger` parameter to the constructor.

```dart

final logger = Logger();

final secureStorage = SecureStorage(logger: logger);

```

#### Telemetry

It's possible to handle telemetry events passing to methods to the constructor.

```dart

final secureStorage = SecureStorage(
  FutureOr<void> Function(Failure)? telemetryOnError,
  FutureOr<void> Function()? telemetryOnSuccess,
);

```

Telemetry on error is called when an error occurs.

Telemetry on success is called when the method is executed successfully.

#### Error handling

The exceptions available are:

- `SecureStorageReadFailure` when the read method fails.

- `SecureStorageWriteFailure` when the write method fails.

- `SecureStorageKeyNotFoundFailure` when the key is not found.

- `SecureStorageValueNotFoundFailure` when the value is not found.

- `SecureStorageIntializationFailure` when the initialization fails.

There is an class called `SecureStorageFailureUtil` with a method called `getFailureNameUI` to get a user friendly message from the exception.

```dart

final failureName = SecureStorageFailureUtil.getFailureNameUI(
    context: context, 
    failure:failure);

```

