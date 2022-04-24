import 'package:formz/formz.dart';

enum CustomObjectFieldError {
  cannotBeNull,
}


class CustomObjectField extends FormzInput<Object?, CustomObjectFieldError> {
  const CustomObjectField.pure([Object? value]) : super.pure(value);
  const CustomObjectField.dirty([Object? value]) : super.dirty(value);

  @override
  CustomObjectFieldError? validator(Object? value) {
    if (value == null) {
      return CustomObjectFieldError.cannotBeNull;
    }
    return null;
  }
}
