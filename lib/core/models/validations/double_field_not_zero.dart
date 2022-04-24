

// Package imports:
import 'package:formz/formz.dart';

enum DoubleFieldNotZeroValidationError {
  cannotBeEmpty,
  cannotBeZero,
  cannotBeNegative,
  invalidFormat,
}

class DoubleFieldNotZero extends FormzInput<double, DoubleFieldNotZeroValidationError> {
  const DoubleFieldNotZero.pure([double value = 0.0]) : super.pure(value);
  const DoubleFieldNotZero.dirty([double value = 0.0]) : super.dirty(value);

  // regex to validate the input value to only allow numbers and a dot
  static final RegExp _doubleRegex = RegExp(r'^[0-9]+(\.[0-9]*)?$');

  @override
  DoubleFieldNotZeroValidationError? validator(double value) {
    if (value.isNaN) {
      return DoubleFieldNotZeroValidationError.cannotBeEmpty;
    }
    if (value == 0.0) {
      return DoubleFieldNotZeroValidationError.cannotBeZero;
    }
    if (value < 0.0) {
      return DoubleFieldNotZeroValidationError.cannotBeNegative;
    }
    if (!_doubleRegex.hasMatch(value.toString())) {
      return DoubleFieldNotZeroValidationError.invalidFormat;
    }
    return null;
  }
  
}
