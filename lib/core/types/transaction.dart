import 'package:lazervault/src/features/authentication/domain/entities/user.dart';

class Transaction {
  final TransactionType type;
  final num amount;
  final String? accountNo;
  final String? transactionId;
  final DateTime? dateTime;
  final String? notes;
  final TransactionStatus? status;
  final User? user;

  const Transaction({
    required this.type,
    required this.amount,
    this.accountNo,
    this.transactionId,
    this.dateTime,
    this.notes,
    this.status,
    this.user,
  });
}

class TransferTransaction extends Transaction {
  final int? transferFee;

  const TransferTransaction(
      {required super.type,
      required super.amount,
      super.accountNo,
      super.transactionId,
      super.dateTime,
      super.notes,
      super.status,
      super.user,
      this.transferFee});
}

enum TransactionType {
  billPay('Bill Pay'),
  shopping('Shopping'),
  tuitionFee('Tuition Fee');

  final String displayName;

  const TransactionType(this.displayName);
}

enum TransactionAttribute {
  name('Name'),
  amount("Amount (GBP)"),
  accountNo('Account No.'),
  transactionId("Transaction Id"),
  email("Email"),
  dateTime("Date Time"),
  category("Category"),
  bank("Bank"),
  notes("Notes"),
  status("Status"),
  transferType("Type of Transfer"),
  transferFee("Transfer Fee");

  final String displayName;

  const TransactionAttribute(this.displayName);
}

enum TransactionStatus {
  completed('Completed'),
  pending("Pending");

  final String displayName;

  const TransactionStatus(this.displayName);
}
