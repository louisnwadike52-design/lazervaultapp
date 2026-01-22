import '../../../../core/network/grpc_client.dart';
import '../../../../core/network/retry_helper.dart';
import '../../../../generated/invoice.pb.dart' as pb;

import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';

/// gRPC-based implementation of InvoiceRepository
/// This implementation communicates with the backend gRPC service for invoice operations.
/// For methods not yet supported by the backend, UnimplementedError is thrown.
class InvoiceRepositoryGrpcImpl implements InvoiceRepository {
  final GrpcClient grpcClient;
  final String currentUserId; // Current authenticated user ID

  InvoiceRepositoryGrpcImpl({
    required this.grpcClient,
    required this.currentUserId,
  });

  @override
  Future<List<Invoice>> getAllInvoices() async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoicesRequest()
          ..accountId = currentUserId
          ..limit = 100
          ..offset = 0;
        final options = await grpcClient.callOptions;

        final response = await grpcClient.invoiceClient.getInvoices(
          request,
          options: options,
        );

        return response.invoices.map((inv) => _fromProto(inv)).toList();
      },
    );
  }

  @override
  Future<Invoice?> getInvoiceById(String id) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoiceRequest()..invoiceId = id;
        final options = await grpcClient.callOptions;

        final response = await grpcClient.invoiceClient.getInvoice(
          request,
          options: options,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<Invoice> createInvoice(Invoice invoice) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CreateInvoiceRequest()
          ..accountId = currentUserId
          ..recipientEmail = invoice.toEmail ?? ''
          ..recipientName = invoice.toName ?? ''
          ..description = invoice.description ?? invoice.title
          ..amount = invoice.amount
          ..dueDate = invoice.dueDate?.toUtc().toIso8601String() ?? DateTime.now().add(Duration(days: 30)).toUtc().toIso8601String()
          ..tax = invoice.taxAmount ?? 0.0
          ..discount = invoice.discountAmount ?? 0.0
          ..notes = invoice.notes ?? '';

        // Add invoice items
        if (invoice.items.isNotEmpty) {
          request.items.addAll(invoice.items.map((item) => pb.InvoiceItem()
            ..description = '${item.name}: ${item.description ?? ''}'
            ..quantity = item.quantity.toInt()
            ..unitPrice = item.unitPrice
            ..total = item.totalPrice));
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.createInvoice(
          request,
          options: options,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<Invoice> sendInvoice(String invoiceId) async {
    throw UnimplementedError('sendInvoice not yet available in backend API');
  }

  @override
  Future<List<Invoice>> getInvoicesByUserId(String userId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoicesRequest()
          ..accountId = userId
          ..limit = 100
          ..offset = 0;
        final options = await grpcClient.callOptions;

        final response = await grpcClient.invoiceClient.getInvoices(
          request,
          options: options,
        );

        return response.invoices.map((inv) => _fromProto(inv)).toList();
      },
    );
  }

  @override
  Future<List<Invoice>> getInvoicesByStatus(InvoiceStatus status) async {
    return retryWithBackoff(
      operation: () async {
        // Get invoices and filter by status (using status string field)
        final request = pb.GetInvoicesRequest()
          ..accountId = currentUserId
          ..limit = 100
          ..offset = 0;

        if (status == InvoiceStatus.paid) {
          request.status = 'paid';
        } else if (status == InvoiceStatus.pending) {
          request.status = 'pending';
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoices(
          request,
          options: options,
        );

        return response.invoices.map((inv) => _fromProto(inv)).toList();
      },
    );
  }

  @override
  Future<Invoice> updateInvoice(Invoice invoice) async {
    throw UnimplementedError('updateInvoice not yet available in backend API');
  }

  @override
  Future<void> deleteInvoice(String id) async {
    throw UnimplementedError('deleteInvoice not yet available in backend API');
  }

  @override
  Future<List<Invoice>> getInvoicesTaggedToUser(String userId) async {
    // For now, get all invoices and filter by recipient ID
    final allInvoices = await getAllInvoices();
    return allInvoices.where((inv) => inv.toUserId == userId).toList();
  }

  @override
  Future<Invoice> markInvoiceAsPaid(String invoiceId, PaymentMethod paymentMethod, String? paymentReference) async {
    return retryWithBackoff(
      operation: () async {
        // Use payInvoice RPC which takes invoiceId, accountId, and pin
        final request = pb.PayInvoiceRequest()
          ..invoiceId = invoiceId
          ..accountId = currentUserId
          ..pin = ''; // PIN would come from user input

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.payInvoice(
          request,
          options: options,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<Invoice> cancelInvoice(String invoiceId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CancelInvoiceRequest()
          ..invoiceId = invoiceId
          ..reason = 'User requested cancellation';
        final options = await grpcClient.callOptions;

        final response = await grpcClient.invoiceClient.cancelInvoice(
          request,
          options: options,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<String> generateQRCode(String invoiceId) async {
    throw UnimplementedError('QR code generation handled client-side');
  }

  @override
  Future<List<Invoice>> searchInvoices(String query) async {
    // Client-side search for now
    final allInvoices = await getAllInvoices();
    final lowerQuery = query.toLowerCase();
    return allInvoices.where((inv) {
      return inv.title.toLowerCase().contains(lowerQuery) ||
             (inv.description?.toLowerCase().contains(lowerQuery) ?? false) ||
             inv.toEmail?.toLowerCase().contains(lowerQuery) == true;
    }).toList();
  }

  @override
  Future<List<Invoice>> getOverdueInvoices() async {
    final allInvoices = await getAllInvoices();
    final now = DateTime.now();
    return allInvoices.where((inv) {
      return inv.status != InvoiceStatus.paid &&
             inv.dueDate != null &&
             inv.dueDate!.isBefore(now);
    }).toList();
  }

  @override
  Future<Map<String, dynamic>> getInvoiceStatistics(String userId) async {
    // Get all SENT invoices (created by this user)
    final invoices = await getInvoicesByUserId(userId);

    // Calculate statistics for sent invoices only
    final paidInvoices = invoices.where((inv) => inv.status == InvoiceStatus.paid).toList();
    final pendingInvoices = invoices.where((inv) => inv.status == InvoiceStatus.pending).toList();
    final overdueInvoices = invoices.where((inv) => inv.isOverdue && inv.status != InvoiceStatus.paid).toList();
    final unpaidInvoices = invoices.where((inv) => inv.status != InvoiceStatus.paid).toList();

    final totalAmount = invoices.fold<double>(0, (sum, inv) => sum + inv.amount);
    final totalPaid = paidInvoices.fold<double>(0, (sum, inv) => sum + inv.amount);
    final totalUnpaid = unpaidInvoices.fold<double>(0, (sum, inv) => sum + inv.amount);

    // Calculate collection rate (percentage of paid amount vs total amount)
    final collectionRate = totalAmount > 0 ? (totalPaid / totalAmount) * 100 : 0.0;

    return {
      'total_invoices': invoices.length,
      'paid_invoices': paidInvoices.length,
      'pending_invoices': pendingInvoices.length,
      'overdue_invoices': overdueInvoices.length,
      'unpaid_invoices': unpaidInvoices.length,
      'total_amount': totalAmount,
      'total_paid': totalPaid,
      'total_unpaid': totalUnpaid,
      'collection_rate': collectionRate,
    };
  }

  @override
  Future<String> generateInvoicePDF(String invoiceId) async {
    throw UnimplementedError('PDF generation handled client-side or separate service');
  }

  @override
  Future<void> shareInvoice(String invoiceId, List<String> recipients) async {
    throw UnimplementedError('Share handled client-side');
  }

  @override
  Future<void> recordPayment(String invoiceId, double amount, PaymentMethod method, String reference) async {
    throw UnimplementedError('Payment recording handled by payment service');
  }

  @override
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId) async {
    throw UnimplementedError('Payment history handled by payment service');
  }

  @override
  Future<TagUsersResponse> tagUsersToInvoice(String invoiceId, List<String> userIds, List<String> emails, List<String> phoneNumbers) async {
    throw UnimplementedError('tagUsersToInvoice not yet available in backend API');
  }

  @override
  Future<List<InvoiceUser>> searchUsers(String query, {int limit = 20}) async {
    throw UnimplementedError('searchUsers not yet available in backend API');
  }

  // Helper: Convert protobuf to entity
  Invoice _fromProto(pb.Invoice proto) {
    // Parse invoice items or create a default item
    List<InvoiceItem> items;
    if (proto.items.isNotEmpty) {
      items = proto.items.map((item) => InvoiceItem(
        id: 'item_${DateTime.now().millisecondsSinceEpoch}',
        name: _extractNameFromDescription(item.description),
        description: item.description.isNotEmpty ? item.description : null,
        quantity: item.quantity.toDouble(),
        unitPrice: item.unitPrice,
        totalPrice: item.total,
        category: null,
      )).toList();
    } else {
      // Create a default invoice item from the invoice amount
      items = [InvoiceItem(
        id: 'item_default',
        name: 'Invoice Item',
        description: proto.description.isNotEmpty ? proto.description : 'Invoice item',
        quantity: 1,
        unitPrice: proto.amount,
        totalPrice: proto.amount,
      )];
    }

    // Parse status from string
    final statusStr = proto.status.toLowerCase();
    final status = statusStr == 'paid' || statusStr == 'completed'
        ? InvoiceStatus.paid
        : InvoiceStatus.pending;

    // Calculate total amount from proto fields
    final totalAmount = proto.totalAmount > 0 ? proto.totalAmount : proto.amount;

    return Invoice(
      id: proto.id,
      title: proto.description.isNotEmpty ? proto.description : 'Invoice',
      description: proto.description.isNotEmpty ? proto.description : '',
      amount: proto.amount,
      currency: proto.currency.isNotEmpty ? proto.currency : 'USD',
      status: status,
      type: InvoiceType.invoice,
      createdAt: proto.createdAt.isNotEmpty ? DateTime.parse(proto.createdAt) : DateTime.now(),
      dueDate: proto.dueDate.isNotEmpty ? DateTime.parse(proto.dueDate) : null,
      fromUserId: proto.userId,
      toUserId: proto.accountId.isNotEmpty ? proto.accountId : null,
      toEmail: proto.recipientEmail.isNotEmpty ? proto.recipientEmail : null,
      toName: proto.recipientName.isNotEmpty ? proto.recipientName : null,
      paymentReference: proto.paymentReference.isNotEmpty ? proto.paymentReference : null,
      items: items,
      notes: proto.notes.isNotEmpty ? proto.notes : null,
      taxAmount: proto.tax > 0 ? proto.tax : null,
      discountAmount: proto.discount > 0 ? proto.discount : null,
      totalAmount: totalAmount,
      paymentMethod: null, // Not available in current proto
      recipientDetails: null, // Not available in current proto
      payerDetails: null, // Not available in current proto
    );
  }

  // Helper: Extract name from description
  String _extractNameFromDescription(String description) {
    if (description.contains(':')) {
      return description.split(':').first.trim();
    }
    if (description.length > 30) {
      return description.substring(0, 30) + '...';
    }
    return description.isNotEmpty ? description : 'Item';
  }
}
