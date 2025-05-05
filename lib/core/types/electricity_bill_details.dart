import 'package:equatable/equatable.dart';

class ElectricityBillDetails extends Equatable {
  final String billId;
  final String month;
  final ElectricityBillStatus status;
  final int amount;

  const ElectricityBillDetails({
    required this.amount,
    required this.billId,
    required this.month,
    required this.status,
  });

  @override
  List<Object?> get props => [billId, month, status, amount];
}

enum ElectricityBillDetailsAttr {
  name('Name'),
  amount("Bill Amount"),
  billNo('ID No.'),
  month("Month"),
  status("Status");

  final String displayName;

  const ElectricityBillDetailsAttr(this.displayName);
}

enum ElectricityBillStatus {
  pending('pending'),
  paid('paid'),
  due('due');

  final String displayName;

  const ElectricityBillStatus(this.displayName);
}
