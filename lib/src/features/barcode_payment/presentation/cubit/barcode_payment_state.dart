import 'package:equatable/equatable.dart';
import '../../domain/entities/barcode_payment_entity.dart';
import '../../domain/entities/barcode_transaction_entity.dart';

abstract class BarcodePaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BarcodePaymentInitial extends BarcodePaymentState {}

class BarcodePaymentLoading extends BarcodePaymentState {}

// Generate Barcode States
class BarcodeGenerated extends BarcodePaymentState {
  final BarcodePaymentEntity barcode;
  final String qrData;

  BarcodeGenerated({required this.barcode, required this.qrData});

  @override
  List<Object?> get props => [barcode, qrData];
}

// Get Barcode Details States
class BarcodeDetailsLoaded extends BarcodePaymentState {
  final BarcodePaymentEntity barcode;

  BarcodeDetailsLoaded({required this.barcode});

  @override
  List<Object?> get props => [barcode];
}

// Process Payment States
class BarcodePaymentProcessing extends BarcodePaymentState {}

class BarcodePaymentSuccess extends BarcodePaymentState {
  final BarcodeTransactionEntity transaction;

  BarcodePaymentSuccess({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

// History States
class GeneratedBarcodesLoaded extends BarcodePaymentState {
  final List<BarcodePaymentEntity> barcodes;

  GeneratedBarcodesLoaded({required this.barcodes});

  @override
  List<Object?> get props => [barcodes];
}

class ScannedBarcodesLoaded extends BarcodePaymentState {
  final List<BarcodeTransactionEntity> transactions;

  ScannedBarcodesLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

// Cancel Barcode States
class BarcodeCancelled extends BarcodePaymentState {
  final String message;

  BarcodeCancelled({required this.message});

  @override
  List<Object?> get props => [message];
}

// Error State
class BarcodePaymentError extends BarcodePaymentState {
  final String message;

  BarcodePaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}
