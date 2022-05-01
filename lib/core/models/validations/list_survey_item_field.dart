// Package imports:
import 'package:formz/formz.dart';
import 'package:salesman/core/utils/survey_item.dart';

enum ListSurveyItemFieldValidationError {
  cannotBeEmpty,
}

class ListSurveyItemField
    extends FormzInput<List<SurveyItem>, ListSurveyItemFieldValidationError> {
  ListSurveyItemField.pure(List<SurveyItem> value) : super.pure(value);
  ListSurveyItemField.dirty(List<SurveyItem> value) : super.dirty(value);

  @override
  ListSurveyItemFieldValidationError? validator(List<SurveyItem> value) {
    if (value.isEmpty) {
      return ListSurveyItemFieldValidationError.cannotBeEmpty;
    }
    return null;
  }
}
