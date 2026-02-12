import 'package:equatable/equatable.dart';
import '../../domain/entities/qr_payment_entity.dart';
import '../../domain/entities/qr_transaction_entity.dart';

abstract class QRPaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QRPaymentInitial extends QRPaymentState {}

class QRPaymentLoading extends QRPaymentState {}

class QRGenerated extends QRPaymentState {
  final QRPaymentEntity qrCode;
  final String qrData;

  QRGenerated({required this.qrCode, required this.qrData});

  @override
  List<Object?> get props => [qrCode, qrData];
}

class QRDetailsLoaded extends QRPaymentState {
  final QRPaymentEntity qrCode;

  QRDetailsLoaded({required this.qrCode});

  @override
  List<Object?> get props => [qrCode];
}

class QRPaymentProcessing extends QRPaymentState {}

class QRPaymentSuccess extends QRPaymentState {
  final QRTransactionEntity transaction;
  final double newBalance;

  QRPaymentSuccess({required this.transaction, required this.newBalance});

  @override
  List<Object?> get props => [transaction, newBalance];
}

class GeneratedQRCodesLoaded extends QRPaymentState {
  final List<QRPaymentEntity> qrCodes;

  GeneratedQRCodesLoaded({required this.qrCodes});

  @override
  List<Object?> get props => [qrCodes];
}

class QRPaymentsLoaded extends QRPaymentState {
  final List<QRTransactionEntity> transactions;

  QRPaymentsLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class QRCancelled extends QRPaymentState {
  final String message;

  QRCancelled({required this.message});

  @override
  List<Object?> get props => [message];
}

class QRTransactionReceiptLoaded extends QRPaymentState {
  final QRTransactionEntity transaction;

  QRTransactionReceiptLoaded({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class QRPaymentError extends QRPaymentState {
  final String message;

  QRPaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}
