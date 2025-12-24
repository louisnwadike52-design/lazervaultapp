import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../domain/repositories/barcode_payment_repository.dart';
import 'barcode_payment_state.dart';

class BarcodePaymentCubit extends Cubit<BarcodePaymentState> {
  final BarcodePaymentRepository repository;

  BarcodePaymentCubit({required this.repository}) : super(BarcodePaymentInitial());

  Future<void> generateBarcode({
    required double amount,
    required String currency,
    String? description,
    int? validityMinutes,
  }) async {
    emit(BarcodePaymentLoading());

    final result = await repository.generateBarcode(
      amount: amount,
      currency: currency,
      description: description,
      validityMinutes: validityMinutes,
    );

    result.fold(
      (failure) => emit(BarcodePaymentError(message: failure.message)),
      (barcode) {
        // Create QR data JSON
        final qrData = {
          'type': 'barcode_payment',
          'barcode_code': barcode.barcodeCode,
          'amount': barcode.amount,
          'currency': barcode.currency,
          'recipient': barcode.username,
          'expires_at': barcode.expiresAt.millisecondsSinceEpoch ~/ 1000,
        };
        emit(BarcodeGenerated(
          barcode: barcode,
          qrData: jsonEncode(qrData),
        ));
      },
    );
  }

  Future<void> getBarcodeDetails({required String barcodeCode}) async {
    emit(BarcodePaymentLoading());

    final result = await repository.getBarcodeDetails(barcodeCode: barcodeCode);

    result.fold(
      (failure) => emit(BarcodePaymentError(message: failure.message)),
      (barcode) => emit(BarcodeDetailsLoaded(barcode: barcode)),
    );
  }

  Future<void> processBarcodePayment({
    required String barcodeCode,
    required String sourceAccountId,
  }) async {
    emit(BarcodePaymentProcessing());

    final result = await repository.processBarcodePayment(
      barcodeCode: barcodeCode,
      sourceAccountId: sourceAccountId,
    );

    result.fold(
      (failure) => emit(BarcodePaymentError(message: failure.message)),
      (transaction) => emit(BarcodePaymentSuccess(transaction: transaction)),
    );
  }

  Future<void> getMyGeneratedBarcodes({int? limit, int? offset}) async {
    emit(BarcodePaymentLoading());

    final result = await repository.getMyGeneratedBarcodes(
      limit: limit,
      offset: offset,
    );

    result.fold(
      (failure) => emit(BarcodePaymentError(message: failure.message)),
      (barcodes) => emit(GeneratedBarcodesLoaded(barcodes: barcodes)),
    );
  }

  Future<void> getMyScannedBarcodes({int? limit, int? offset}) async {
    emit(BarcodePaymentLoading());

    final result = await repository.getMyScannedBarcodes(
      limit: limit,
      offset: offset,
    );

    result.fold(
      (failure) => emit(BarcodePaymentError(message: failure.message)),
      (transactions) => emit(ScannedBarcodesLoaded(transactions: transactions)),
    );
  }

  Future<void> cancelBarcode({required String barcodeId}) async {
    emit(BarcodePaymentLoading());

    final result = await repository.cancelBarcode(barcodeId: barcodeId);

    result.fold(
      (failure) => emit(BarcodePaymentError(message: failure.message)),
      (_) {
        emit(BarcodeCancelled(message: 'Barcode cancelled successfully'));
        // Refresh the list
        getMyGeneratedBarcodes();
      },
    );
  }

  void reset() {
    emit(BarcodePaymentInitial());
  }
}
