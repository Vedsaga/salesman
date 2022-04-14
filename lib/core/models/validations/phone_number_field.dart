

// Package imports:
import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  invalidPhoneNumber,
  cannotBeEmpty,
  tooShort,
  tooLong,
  invalidCharacters
}

class PhoneNumberField extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberField.pure([String value = '']) : super.pure(value);
  const PhoneNumberField.dirty([String value = '']) : super.dirty(value);
  // regex check for phone number
  static final RegExp _phoneNumberRegex = RegExp(r'^\d+$');

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberValidationError.cannotBeEmpty;
    }
    if (!_phoneNumberRegex.hasMatch(value)) {
      return PhoneNumberValidationError.invalidPhoneNumber;
    }
    if (value.length < 10) {
      return PhoneNumberValidationError.tooShort;
    }
    if (value.length > 10) {
      return PhoneNumberValidationError.tooLong;
    }
    return null;
  }
}
