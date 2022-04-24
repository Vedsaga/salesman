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
    'process',
    'dispatch',
    'deliver',
    'cancel',
    'reject',
    'delayed',
  ];
  static final List<String> paymentType = ['receive', 'send'];
  static final List<String> paymentFor = ['delivery', 'return', 'other'];
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
    'started',
    'complete',
    'cancel',
    'delayed',
    'postpone',
  ];
  static final List<String> returnOrderStatus = [
    'pending',
    'approve',
    'collect',
    'return',
    'reject',
    'cancel'
  ];

  static final List<String> vehicleStatus = ['available', 'unavailable'];
  static final List<String> vehicleType = [
    'truck',
    'mini truck',
    'auto-rickshaw',
    'motor cycle',
    'bicycle',
    'van',
    'others'
  ];

  static final List<String> fuelType = [
    'petrol',
    'diesel',
    'lpg',
    'cng',
    'electric',
    'others'
  ];

  static final List<String> returnReason = ['damaged', 'expired', 'others'];

  @override
  StatusTypeFieldValidationError? validator(String value) {
    if (value.isEmpty) {
      return StatusTypeFieldValidationError.cannotBeEmpty;
    }
    // if value is available in any of the list then return null else return invalidStatusType
    if (deliveryOrderStatus.contains(value) ||
        paymentType.contains(value) ||
        paymentFor.contains(value) ||
        paymentStatus.contains(value) ||
        paymentMode.contains(value) ||
        transportStatus.contains(value) ||
        returnOrderStatus.contains(value) ||
        vehicleStatus.contains(value) ||
        vehicleType.contains(value) ||
        fuelType.contains(value)) {
      return null;
    } else {
      return StatusTypeFieldValidationError.invalidStatusType;
    }
  }
}
