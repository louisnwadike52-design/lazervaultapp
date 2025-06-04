import 'dart:math';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../datasources/invoice_local_datasource.dart';
import '../models/invoice_model.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceLocalDataSource localDataSource;

  InvoiceRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Invoice>> getAllInvoices() async {
    final models = await localDataSource.getAllInvoices();
    return models.cast<Invoice>();
  }

  @override
  Future<List<Invoice>> getInvoicesByUserId(String userId) async {
    final invoices = await getAllInvoices();
    return invoices.where((invoice) => invoice.fromUserId == userId).toList();
  }

  @override
  Future<List<Invoice>> getInvoicesByStatus(InvoiceStatus status) async {
    final invoices = await getAllInvoices();
    return invoices.where((invoice) => invoice.status == status).toList();
  }

  @override
  Future<Invoice?> getInvoiceById(String id) async {
    final model = await localDataSource.getInvoiceById(id);
    return model;
  }

  @override
  Future<Invoice> createInvoice(Invoice invoice) async {
    final newInvoice = invoice.copyWith(
      id: _generateInvoiceId(),
      createdAt: DateTime.now(),
      qrCodeData: await _generateQRData(invoice),
    );
    
    final model = InvoiceModel.fromEntity(newInvoice);
    await localDataSource.saveInvoice(model);
    return newInvoice;
  }

  @override
  Future<Invoice> updateInvoice(Invoice invoice) async {
    final model = InvoiceModel.fromEntity(invoice);
    await localDataSource.saveInvoice(model);
    return invoice;
  }

  @override
  Future<void> deleteInvoice(String id) async {
    await localDataSource.deleteInvoice(id);
  }

  @override
  Future<Invoice> sendInvoice(String invoiceId) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    final updatedInvoice = invoice.copyWith(
      status: InvoiceStatus.pending,
      dueDate: invoice.dueDate ?? DateTime.now().add(Duration(days: 30)),
    );

    return await updateInvoice(updatedInvoice);
  }

  @override
  Future<Invoice> markInvoiceAsPaid(String invoiceId, PaymentMethod paymentMethod, String? paymentReference) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    final updatedInvoice = invoice.copyWith(
      status: InvoiceStatus.paid,
      paidAt: DateTime.now(),
      paymentMethod: paymentMethod,
      paymentReference: paymentReference ?? _generatePaymentReference(),
    );

    return await updateInvoice(updatedInvoice);
  }

  @override
  Future<Invoice> cancelInvoice(String invoiceId) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    final updatedInvoice = invoice.copyWith(status: InvoiceStatus.cancelled);
    return await updateInvoice(updatedInvoice);
  }

  @override
  Future<String> generateQRCode(String invoiceId) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    // Generate QR code data with payment information
    final qrData = await _generateQRData(invoice);
    
    // Update invoice with QR code data
    final updatedInvoice = invoice.copyWith(qrCodeData: qrData);
    await updateInvoice(updatedInvoice);
    
    return qrData;
  }

  @override
  Future<List<Invoice>> searchInvoices(String query) async {
    final invoices = await getAllInvoices();
    final lowerQuery = query.toLowerCase();
    
    return invoices.where((invoice) {
      return invoice.title.toLowerCase().contains(lowerQuery) ||
             invoice.description.toLowerCase().contains(lowerQuery) ||
             (invoice.toName?.toLowerCase().contains(lowerQuery) ?? false) ||
             (invoice.toEmail?.toLowerCase().contains(lowerQuery) ?? false) ||
             invoice.id.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<Invoice>> getOverdueInvoices() async {
    final invoices = await getAllInvoices();
    final now = DateTime.now();
    
    return invoices.where((invoice) {
      return invoice.status == InvoiceStatus.pending &&
             invoice.dueDate != null &&
             now.isAfter(invoice.dueDate!);
    }).toList();
  }

  @override
  Future<Map<String, dynamic>> getInvoiceStatistics(String userId) async {
    final invoices = await getInvoicesByUserId(userId);
    
    final totalInvoices = invoices.length;
    final paidInvoices = invoices.where((i) => i.status == InvoiceStatus.paid).length;
    final pendingInvoices = invoices.where((i) => i.status == InvoiceStatus.pending).length;
    final overdueInvoices = invoices.where((i) => i.isOverdue).length;
    
    final totalAmount = invoices.fold<double>(0, (sum, invoice) => sum + invoice.totalAmount);
    final paidAmount = invoices
        .where((i) => i.status == InvoiceStatus.paid)
        .fold<double>(0, (sum, invoice) => sum + invoice.totalAmount);
    final pendingAmount = invoices
        .where((i) => i.status == InvoiceStatus.pending)
        .fold<double>(0, (sum, invoice) => sum + invoice.totalAmount);

    return {
      'total_invoices': totalInvoices,
      'paid_invoices': paidInvoices,
      'pending_invoices': pendingInvoices,
      'overdue_invoices': overdueInvoices,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'pending_amount': pendingAmount,
      'collection_rate': totalInvoices > 0 ? (paidInvoices / totalInvoices) * 100 : 0,
    };
  }

  @override
  Future<String> generateInvoicePDF(String invoiceId) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    // For now, return a placeholder path
    // In a real implementation, you would use a PDF generation library
    return '/path/to/generated/invoice_${invoiceId}.pdf';
  }

  @override
  Future<void> shareInvoice(String invoiceId, List<String> recipients) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    // Generate shareable content
    final shareText = '''
Invoice: ${invoice.title}
Amount: ${invoice.currency} ${invoice.totalAmount.toStringAsFixed(2)}
Due Date: ${invoice.dueDate?.toString().split(' ')[0] ?? 'N/A'}
Status: ${invoice.statusDisplayName}

Payment Link: https://payment.app/invoice/${invoice.id}
    ''';

    await Share.share(shareText, subject: 'Invoice: ${invoice.title}');
  }

  @override
  Future<void> recordPayment(String invoiceId, double amount, PaymentMethod method, String reference) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    // For this implementation, we'll mark the invoice as paid if full amount is received
    if (amount >= invoice.totalAmount) {
      await markInvoiceAsPaid(invoiceId, method, reference);
    }
    
    // In a real implementation, you might support partial payments
    // and maintain a payment history
  }

  @override
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId) async {
    final invoice = await getInvoiceById(invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    // For this implementation, return simple payment history
    if (invoice.status == InvoiceStatus.paid && invoice.paidAt != null) {
      return [
        {
          'id': 'payment_${invoice.id}',
          'amount': invoice.totalAmount,
          'method': invoice.paymentMethod?.name ?? 'unknown',
          'reference': invoice.paymentReference ?? '',
          'date': invoice.paidAt!.toIso8601String(),
          'status': 'completed',
        }
      ];
    }

    return [];
  }

  @override
  Future<List<Invoice>> getInvoicesTaggedToUser(String userId) async {
    final invoices = await getAllInvoices();
    return invoices.where((invoice) => invoice.toUserId == userId).toList();
  }

  // Private helper methods
  String _generateInvoiceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(9999);
    return 'INV-$timestamp-$random';
  }

  String _generatePaymentReference() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return 'PAY-$timestamp-$random';
  }

  Future<String> _generateQRData(Invoice invoice) async {
    // Generate QR code data with payment information
    // This could be a payment URL, bank transfer details, or crypto address
    
    final qrData = {
      'invoice_id': invoice.id,
      'amount': invoice.totalAmount,
      'currency': invoice.currency,
      'recipient': invoice.fromUserId,
      'description': invoice.title,
      'due_date': invoice.dueDate?.toIso8601String(),
      'payment_url': 'https://payment.app/pay/${invoice.id}',
    };

    // Convert to a payment URI format (could be customized based on payment method)
    return 'lazervault://pay?${Uri(queryParameters: qrData.map((k, v) => MapEntry(k, v.toString()))).query}';
  }
} 