// third party import
import 'package:formz/formz.dart';

enum StatusTypeFieldValidationError {
  cannotBeEmpty,
  invalidStatusType,
}

class StatusTypeField
    extends FormzInput<String, StatusTypeFieldValidationError> {
  const StatusTypeField.pure([String value = '']) : super.pure(value);
  const StatusTypeField.dirty([String value = '']) : super.dirty(value);

  static final List<String> orderStatus = [
    'pending',
    'approved',
    'rejected',
    'cancelled'
  ];
  static final List<String> orderType = ['delivery', 'return'];
  static final List<String> paymentStatus = ['paid', 'unpaid', 'partial'];
  static final List<String> paymentType = [
    'cash',
    'credit',
    'debit',
    'cheque',
    'upi'
  ];
  static final List<String> deliveryStatus = [
    'pending',
    'delivered',
    'cancelled'
  ];
  static final List<String> returnStatus = [
    'pending',
    'approved',
    'rejected',
    'cancelled'
  ];

  @override
  StatusTypeFieldValidationError? validator(String value) {
    if (value.isEmpty) {
      return StatusTypeFieldValidationError.cannotBeEmpty;
    }
    // if value is available in any of the list then return null else return invalidStatusType
    if (orderStatus.contains(value) ||
        orderType.contains(value) ||
        paymentStatus.contains(value) ||
        paymentType.contains(value) ||
        deliveryStatus.contains(value) ||
        returnStatus.contains(value)) {
      return null;
    } else {
      return StatusTypeFieldValidationError.invalidStatusType;
    }
  }
}
