import 'secure_storage_localizations.dart';

/// The translations for English (`en`).
class SecureStorageLocalizationsEn extends SecureStorageLocalizations {
  SecureStorageLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get generalFailure => 'An internal error has occurred. Please try again later. If the problem persists, please contact your administrator';

  @override
  String get readFailure => 'Error reading encrypted data';

  @override
  String get writeFailure => 'Error writing encrypted data';

  @override
  String get initializationFailure => 'Secure storage could not be initialized';

  @override
  String get valueNotFoundFailure => 'Error value not found in secure storage';

  @override
  String get keyNotFoundFailure => 'Error key not found in secure storage';
}
