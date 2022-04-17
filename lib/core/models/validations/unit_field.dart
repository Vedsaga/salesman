

// Package imports:
import 'package:formz/formz.dart';

enum UnitFieldError {
  mustBeSelected,
  invalidValue,
}

class UnitField extends FormzInput<String, UnitFieldError> {
  const UnitField.pure([String value = 'unit']) : super.pure(value);
  const UnitField.dirty([String value = 'unit']) : super.dirty(value);

  static final List<String> units = [
    'kg',
    'gram',
    'liter',
    'ml',
    'piece',
    'dozen',
    'box',
    'packet',
    'bottle',
  ];

  @override
  UnitFieldError? validator(String value) {
    if (value.isEmpty || value == 'unit') {
      return UnitFieldError.mustBeSelected;
    }
    if (!units.contains(value)) {
      return UnitFieldError.invalidValue;
    }
    return null;
  }
}
