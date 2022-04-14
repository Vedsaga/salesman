// Package imports:
import 'package:formz/formz.dart';

enum DateTimeFieldValidationError {
  cannotBeEmpty,
  invalidDate,
}

 class DateTimeField extends FormzInput<DateTime?, DateTimeFieldValidationError> {
    DateTimeField.pure(DateTime? value) : super.pure(value);
  DateTimeField.dirty(DateTime? value) : super.dirty(value);
  
  @override
  DateTimeFieldValidationError? validator(DateTime? value) {
    if (value == null) {
      return DateTimeFieldValidationError.cannotBeEmpty;
    }
    return null;
  }
}
