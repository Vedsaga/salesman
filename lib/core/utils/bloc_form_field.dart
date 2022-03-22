// third party imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:salesman/core/utils/type_defs.dart';

class BlocFormField<T> with EquatableMixin {
  T? value;
  LocaleString? error;

  BlocFormField([this.value, this.error]);

  @override
  List<Object?> get props => [value, error];

  BlocFormField<T> copyWith({
    T? value,
    LocaleString? error,
  }) {
    return BlocFormField<T>(
      value ?? this.value,
      error ?? this.error,
    );
  }
}
