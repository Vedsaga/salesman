// Package imports:
import 'package:formz/formz.dart';
import 'package:salesman/core/utils/item_map.dart';

enum ListFieldValidationError {
  cannotBeEmpty,
}

class ListItemField
    extends FormzInput<List<ItemMap>, ListFieldValidationError> {
  ListItemField.pure(List<ItemMap> value) : super.pure(value);
  ListItemField.dirty(List<ItemMap> value) : super.dirty(value);

  @override
  ListFieldValidationError? validator(List<dynamic> value) {
    if (value.isEmpty) {
      return ListFieldValidationError.cannotBeEmpty;
    }
    return null;
  }
}
