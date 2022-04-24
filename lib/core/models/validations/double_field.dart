

// Package imports:
import 'package:formz/formz.dart';

enum DoubleFieldValidationError {
  cannotBeEmpty,
  cannotBeNegative,
  invalidFormat,
}

class DoubleField extends FormzInput<double, DoubleFieldValidationError> {
  const DoubleField.pure([double value = 0.0]) : super.pure(value);
  const DoubleField.dirty([double value = 0.0]) : super.dirty(value);

  // regex to validate the input value to only allow numbers and a dot
  static final RegExp _doubleRegex = RegExp(r'^[0-9]+(\.[0-9]*)?$');

  @override
  DoubleFieldValidationError? validator(double value) {
    if (value.isNaN) {
      return DoubleFieldValidationError.cannotBeEmpty;
    }
    if (value < 0.0) {
      return DoubleFieldValidationError.cannotBeNegative;
    }
    if (!_doubleRegex.hasMatch(value.toString())) {
      return DoubleFieldValidationError.invalidFormat;
    }
    return null;
  }
}
