// third party import

// Package imports:
import 'package:formz/formz.dart';

enum DateTimeFieldValidationError {
  cannotBeEmpty,
  invalidDate,
}

 class DateTimeField extends FormzInput<DateTime?, DateTimeFieldValidationError> {
    DateTimeField.pure(DateTime? value) : super.pure(value ?? DateTime.now());
  DateTimeField.dirty(DateTime? value) : super.dirty(value ?? DateTime.now());
  
  @override
  DateTimeFieldValidationError? validator(DateTime? value) {
    if (value == null) {
      return DateTimeFieldValidationError.cannotBeEmpty;
    }
    return null;
  }
}
