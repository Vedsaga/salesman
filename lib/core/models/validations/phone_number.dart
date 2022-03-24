// third party imports:
import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  invalidPhoneNumber,
  cannotBeEmpty,
  tooShort,
  tooLong,
  invalidCharacters
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure([String value = '']) : super.pure(value);
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);
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
    if (value.length > 11) {
      return PhoneNumberValidationError.tooLong;
    }
    return null;
  }
}
