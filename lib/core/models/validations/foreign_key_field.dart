// third party import
import 'package:formz/formz.dart';


enum ForeignKeyFieldValidationError {
  cannotBeEmpty,
  invalidForeignKey,
}

class ForeignKeyField extends FormzInput<int, ForeignKeyFieldValidationError> {
  const ForeignKeyField.pure([int? value]) : super.pure(value ?? -1);
  const ForeignKeyField.dirty([int? value]) : super.dirty(value ?? -1);

  @override
  ForeignKeyFieldValidationError? validator(int value) {
    if (value.isNaN) {
      return ForeignKeyFieldValidationError.cannotBeEmpty;
    }
    if (value < 0) {
      return ForeignKeyFieldValidationError.invalidForeignKey;
    }
    return null;
  }
}

