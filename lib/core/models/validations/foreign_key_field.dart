// third party import
import 'package:formz/formz.dart';


enum ForeignKeyFieldValidationError {
  cannotBeEmpty,
  invalidForeignKey,
}

class ForeignKeyField extends FormzInput<int, ForeignKeyFieldValidationError> {
  const ForeignKeyField.pure([int value = 0]) : super.pure(value);
  const ForeignKeyField.dirty([int value = 0]) : super.dirty(value);

  @override
  ForeignKeyFieldValidationError? validator(int value) {
    if (value.isNaN) {
      return ForeignKeyFieldValidationError.cannotBeEmpty;
    }
    if (value <= 0) {
      return ForeignKeyFieldValidationError.invalidForeignKey;
    }
    return null;
  }
}

