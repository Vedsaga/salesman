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
    'processing',
    'completed',
    'cancelled',
    'rejected',
  ];
  static final List<String> paymentType = ['receive', 'send'];
  static final List<String> paymentFor = ['delivery', 'return'];
  static final List<String> paymentStatus = ['paid', 'unpaid', 'partial'];
  static final List<String> paymentMode = [
    'cash',
    'credit card',
    'debit card',
    'cheque',
    'bank transfer',
    'UPI',
    'others'
  ];
  static final List<String> deliveryStatus = [
    'in-transit',
    'out-for-delivery',
    'delivered',
    'cancelled',
    'rejected'
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
        paymentType.contains(value) ||
        paymentStatus.contains(value) ||
        paymentMode.contains(value) ||
        deliveryStatus.contains(value) ||
        paymentFor.contains(value) ||
        returnStatus.contains(value)) {
      return null;
    } else {
      return StatusTypeFieldValidationError.invalidStatusType;
    }
  }
}
