import '../bill_payment_entity.dart';

extension MeterTypeExtension on MeterType {
  String get displayName {
    switch (this) {
      case MeterType.prepaid:
        return 'Prepaid';
      case MeterType.postpaid:
        return 'Postpaid';
    }
  }
}
