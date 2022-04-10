// third part import

// Package imports:
import 'package:formz/formz.dart';

enum GenericFieldValidationError {
  cannotBeEmpty,
  tooShort,
  tooLong,
  invalidCharacters,
}



class GenericField extends FormzInput<String, GenericFieldValidationError> {
  const GenericField.pure([String value = '']) : super.pure(value);
  const GenericField.dirty([String value = '']) : super.dirty(value);

  static final RegExp _genericFieldRegex = RegExp(r'^[a-zA-Z0-9 ]+$');

  @override
  GenericFieldValidationError? validator(String value) {
    if (value.isEmpty) {
      return GenericFieldValidationError.cannotBeEmpty;
    }
    if (value.length < 3) {
      return GenericFieldValidationError.tooShort;
    }
    if (value.length > 20) {
      return GenericFieldValidationError.tooLong;
    }
    if (!_genericFieldRegex.hasMatch(value)) {
      return GenericFieldValidationError.invalidCharacters;
    }
    return null;
  }
}
