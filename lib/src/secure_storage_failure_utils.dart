import 'package:flutter/widgets.dart';
import 'package:secure_storage_client/localization/secure_storage_localizations.dart';
import 'package:secure_storage_client/src/secure_storage_failure.dart';

class SecureStorageFailureUtils {
  String getFailureNameUI({
    required BuildContext context,
    required SecureStorageFailure failure,
  }) {
    switch (failure) {
      case SecureStorageReadFailure():
        return SecureStorageLocalizations.of(context)!.readFailure;
      case SecureStorageWriteFailure():
        return SecureStorageLocalizations.of(context)!.writeFailure;
      case SecureStorageInitializationFailure():
        return SecureStorageLocalizations.of(context)!.initializationFailure;
      case SecureStorageKeyNotFound():
        return SecureStorageLocalizations.of(context)!.keyNotFoundFailure;
      case SecureStorageValueNotFound():
        return SecureStorageLocalizations.of(context)!.valueNotFoundFailure;
    }
  }
}
