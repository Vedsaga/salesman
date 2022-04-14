// Package imports:
import 'package:formz/formz.dart';

enum StatusTypeFieldValidationError {
  cannotBeEmpty,
  invalidStatusType,
}

class StatusTypeField
    extends FormzInput<String, StatusTypeFieldValidationError> {
  const StatusTypeField.pure([String value = '']) : super.pure(value);
  const StatusTypeField.dirty([String value = '']) : super.dirty(value);

  static final List<String> deliveryOrderStatus = [
    'pending',
    'processing',
    'out-for-delivery',
    'delivered',
    'cancelled',
    'rejected',
    'delayed',
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
  static final List<String> transportStatus = [
    'pending',
    'in-progress',
    'completed',
    'cancelled'
  ];
  static final List<String> returnOrderStatus = [
    'pending',
    'approved',
    'collected',
    'returned',
    'rejected',
    'cancelled'
  ];

  @override
  StatusTypeFieldValidationError? validator(String value) {
    if (value.isEmpty) {
      return StatusTypeFieldValidationError.cannotBeEmpty;
    }
    // if value is available in any of the list then return null else return invalidStatusType
    if (deliveryOrderStatus.contains(value) ||
        paymentType.contains(value) ||
        paymentStatus.contains(value) ||
        paymentMode.contains(value) ||
        transportStatus.contains(value) ||
        paymentFor.contains(value) ||
        returnOrderStatus.contains(value)) {
      return null;
    } else {
      return StatusTypeFieldValidationError.invalidStatusType;
    }
  }
}
