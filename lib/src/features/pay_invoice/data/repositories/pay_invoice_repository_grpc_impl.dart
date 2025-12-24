import '../../../../core/network/grpc_client.dart';
import '../../../../core/network/retry_helper.dart';
import '../../../../generated/invoice_payment.pb.dart' as pb;
import '../../../../generated/common.pb.dart' as common_pb;
import '../../../../generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;

import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';
import '../../../invoice/domain/repositories/invoice_repository.dart';
import '../../../invoice/domain/entities/invoice_entity.dart' as invoice_entity;

/// gRPC-based implementation of PayInvoiceRepository
/// This implementation communicates with the backend gRPC invoice payment service.
/// Uses InvoiceRepository to fetch invoice data.
class PayInvoiceRepositoryGrpcImpl implements PayInvoiceRepository {
  final GrpcClient grpcClient;
  final String currentUserId;
  final InvoiceRepository invoiceRepository;

  PayInvoiceRepositoryGrpcImpl({
    required this.grpcClient,
    required this.currentUserId,
    required this.invoiceRepository,
  });

  @override
  Future<PaymentResult> payInvoice(String invoiceId, PaymentDetails paymentDetails) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.ProcessInvoicePaymentRequest()
          ..invoiceId = invoiceId
          ..paymentMethodId = paymentDetails.accountId ?? ''
          ..amount = paymentDetails.amount
          ..currency = paymentDetails.currency;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.paymentClient.processInvoicePayment(
          request,
          options: options,
        );

        return PaymentResult(
          success: response.success,
          transactionId: response.result.transactionId,
          paymentReference: response.result.paymentReference,
          errorMessage: response.success ? null : response.message,
          status: _fromProtoPaymentStatus(response.result.status),
          processedAt: _fromProtoTimestamp(response.result.processedAt),
        );
      },
      maxRetries: 2, // Lower retries for payment to avoid duplicate charges
    );
  }

  @override
  Future<Map<String, dynamic>> getUserAccountBalance(String userId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetUserAccountBalanceRequest();
        final options = await grpcClient.callOptions;

        final response = await grpcClient.paymentClient.getUserAccountBalance(
          request,
          options: options,
        );

        // Convert proto accounts to map format
        final accounts = response.accounts.map((account) => {
          'account_number': account.accountNumber,
          'account_name': account.accountName,
          'currency': account.currency,
          'available_balance': account.availableBalance,
        }).toList();

        return {
          'accounts': accounts,
          'total_balance': response.accounts.fold<double>(
            0,
            (sum, account) => sum + account.availableBalance,
          ),
        };
      },
    );
  }

  @override
  Future<PaymentResult> processPartialPayment(String invoiceId, PaymentDetails paymentDetails) async {
    // Backend supports partial payments through the same ProcessInvoicePayment RPC
    return payInvoice(invoiceId, paymentDetails);
  }

  @override
  Future<List<Map<String, dynamic>>> getUserPaymentMethods(String userId) async {
    // This would typically call a GetUserPaymentMethods RPC
    // For now, derive from account balance
    final accountData = await getUserAccountBalance(userId);
    final accounts = accountData['accounts'] as List;

    return accounts.map((account) => {
      'id': account['account_number'],
      'type': 'account_balance',
      'name': account['account_name'],
      'currency': account['currency'],
      'balance': account['available_balance'],
    }).toList();
  }

  // Invoice query methods - delegate to InvoiceRepository

  @override
  Future<List<TaggedInvoice>> getTaggedInvoices(String userId) async {
    final invoices = await invoiceRepository.getInvoicesTaggedToUser(userId);
    return invoices.map((inv) => _invoiceToTaggedInvoice(inv)).toList();
  }

  @override
  Future<List<TaggedInvoice>> getTaggedInvoicesByStatus(String userId, PaymentStatus status) async {
    final invoices = await invoiceRepository.getInvoicesTaggedToUser(userId);
    final paymentStatus = _toInvoiceStatus(status);
    return invoices
        .where((inv) => inv.status == paymentStatus)
        .map((inv) => _invoiceToTaggedInvoice(inv))
        .toList();
  }

  @override
  Future<List<TaggedInvoice>> getOverdueInvoices(String userId) async {
    final invoices = await invoiceRepository.getInvoicesTaggedToUser(userId);
    final now = DateTime.now();
    return invoices
        .where((inv) =>
          inv.status != invoice_entity.InvoiceStatus.paid &&
          inv.dueDate != null &&
          inv.dueDate!.isBefore(now))
        .map((inv) => _invoiceToTaggedInvoice(inv))
        .toList();
  }

  @override
  Future<List<TaggedInvoice>> getUpcomingInvoices(String userId, {int days = 7}) async {
    final invoices = await invoiceRepository.getInvoicesTaggedToUser(userId);
    final now = DateTime.now();
    final futureDate = now.add(Duration(days: days));
    return invoices
        .where((inv) =>
          inv.status != invoice_entity.InvoiceStatus.paid &&
          inv.dueDate != null &&
          inv.dueDate!.isAfter(now) &&
          inv.dueDate!.isBefore(futureDate))
        .map((inv) => _invoiceToTaggedInvoice(inv))
        .toList();
  }

  @override
  Future<TaggedInvoice?> getTaggedInvoiceById(String invoiceId) async {
    final invoice = await invoiceRepository.getInvoiceById(invoiceId);
    if (invoice == null) return null;
    return _invoiceToTaggedInvoice(invoice);
  }

  @override
  Future<List<TaggedInvoice>> searchTaggedInvoices(String userId, String query) async {
    final invoices = await invoiceRepository.getInvoicesTaggedToUser(userId);
    final lowerQuery = query.toLowerCase();
    return invoices
        .where((inv) =>
          inv.title.toLowerCase().contains(lowerQuery) ||
          (inv.description.toLowerCase().contains(lowerQuery)) ||
          (inv.toEmail?.toLowerCase().contains(lowerQuery) ?? false))
        .map((inv) => _invoiceToTaggedInvoice(inv))
        .toList();
  }

  @override
  Future<List<TaggedInvoice>> filterInvoicesByPriority(String userId, InvoicePriority priority) async {
    final invoices = await invoiceRepository.getInvoicesTaggedToUser(userId);
    // Filter by priority based on due date and amount
    return invoices
        .map((inv) => _invoiceToTaggedInvoice(inv))
        .where((inv) => inv.priority == priority)
        .toList();
  }

  @override
  Future<List<TaggedInvoice>> filterInvoicesByDateRange(String userId, DateTime start, DateTime end) async {
    final invoices = await invoiceRepository.getInvoicesTaggedToUser(userId);
    return invoices
        .where((inv) =>
          inv.createdAt.isAfter(start) &&
          inv.createdAt.isBefore(end))
        .map((inv) => _invoiceToTaggedInvoice(inv))
        .toList();
  }

  @override
  Future<bool> requestPaymentExtension(String invoiceId, DateTime newDueDate, String? reason) async {
    throw UnimplementedError('RequestPaymentExtension not yet available in backend API');
  }

  @override
  Future<bool> disputeInvoice(String invoiceId, String reason) async {
    throw UnimplementedError('DisputeInvoice not yet available in backend API');
  }

  @override
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId) async {
    throw UnimplementedError('GetPaymentHistory not yet available in backend API');
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics(String userId) async {
    throw UnimplementedError('GetPaymentStatistics not yet available in backend API');
  }

  @override
  Future<List<Map<String, dynamic>>> getRecentTransactions(String userId, {int limit = 20}) async {
    throw UnimplementedError('GetRecentTransactions not yet available in backend API');
  }

  @override
  Future<bool> markInvoiceAsViewed(String invoiceId) async {
    throw UnimplementedError('MarkInvoiceAsViewed not yet available in backend API');
  }

  @override
  Future<bool> setPaymentReminder(String invoiceId, DateTime reminderDate) async {
    throw UnimplementedError('SetPaymentReminder handled client-side');
  }

  @override
  Future<bool> requestInvoiceDetails(String invoiceId) async {
    throw UnimplementedError('RequestInvoiceDetails not yet available in backend API');
  }

  @override
  Future<bool> addPaymentMethod(String userId, Map<String, dynamic> paymentMethodData) async {
    throw UnimplementedError('AddPaymentMethod not yet available in backend API');
  }

  @override
  Future<bool> removePaymentMethod(String userId, String paymentMethodId) async {
    throw UnimplementedError('RemovePaymentMethod not yet available in backend API');
  }

  // Helper: Map proto payment status to domain status
  PaymentStatus _fromProtoPaymentStatus(common_pb.InvoicePaymentStatus status) {
    switch (status) {
      case common_pb.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING:
        return PaymentStatus.pending;
      case common_pb.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PROCESSING:
        return PaymentStatus.processing;
      case common_pb.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_COMPLETED:
        return PaymentStatus.completed;
      case common_pb.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_FAILED:
        return PaymentStatus.failed;
      case common_pb.InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_CANCELLED:
        return PaymentStatus.cancelled;
      default:
        return PaymentStatus.pending;
    }
  }

  // Helper: Convert protobuf timestamp to DateTime
  DateTime _fromProtoTimestamp(timestamp_pb.Timestamp timestamp) {
    final milliseconds = timestamp.seconds.toInt() * 1000 +
                        (timestamp.nanos ~/ 1000000);
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  // Helper: Convert Invoice to TaggedInvoice
  TaggedInvoice _invoiceToTaggedInvoice(invoice_entity.Invoice invoice) {
    // Calculate overdue status and days until due
    final now = DateTime.now();
    final bool isOverdue = invoice.dueDate != null &&
        invoice.status != invoice_entity.InvoiceStatus.paid &&
        invoice.dueDate!.isBefore(now);

    final int daysUntilDue = invoice.dueDate != null
        ? invoice.dueDate!.difference(now).inDays
        : 0;

    // Determine priority based on due date and amount
    final priority = _calculatePriority(invoice, daysUntilDue, isOverdue);

    // Convert payment status
    final paymentStatus = _fromInvoiceStatus(invoice.status);

    // Convert invoice items to tagged invoice items
    final items = invoice.items.map((item) => InvoiceItem(
      id: item.id,
      name: item.name,
      description: item.description,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      totalPrice: item.totalPrice,
      category: item.category,
    )).toList();

    return TaggedInvoice(
      id: invoice.id,
      invoiceNumber: invoice.id.substring(0, 8).toUpperCase(),
      title: invoice.title,
      description: invoice.description,
      amount: invoice.amount,
      currency: invoice.currency,
      createdAt: invoice.createdAt,
      dueDate: invoice.dueDate,
      paidAt: invoice.paidAt,
      paymentStatus: paymentStatus,
      priority: priority,
      fromUserId: invoice.fromUserId,
      fromUserName: invoice.recipientDetails?.contactName ?? invoice.toName ?? 'Unknown',
      fromUserEmail: invoice.recipientDetails?.email ?? invoice.toEmail ?? '',
      fromCompanyName: invoice.recipientDetails?.companyName,
      toUserId: invoice.toUserId ?? currentUserId,
      toUserName: invoice.payerDetails?.contactName ?? 'Me',
      toUserEmail: invoice.payerDetails?.email ?? '',
      items: items,
      taxAmount: invoice.taxAmount,
      discountAmount: invoice.discountAmount,
      totalAmount: invoice.totalAmount,
      notes: invoice.notes,
      paymentReference: invoice.paymentReference,
      qrCodeData: invoice.qrCodeData,
      metadata: invoice.metadata,
      isOverdue: isOverdue,
      daysUntilDue: daysUntilDue,
    );
  }

  // Helper: Calculate invoice priority based on due date and amount
  InvoicePriority _calculatePriority(invoice_entity.Invoice invoice, int daysUntilDue, bool isOverdue) {
    if (isOverdue) {
      return InvoicePriority.urgent;
    }

    if (daysUntilDue <= 3) {
      return invoice.amount >= 1000 ? InvoicePriority.urgent : InvoicePriority.high;
    } else if (daysUntilDue <= 7) {
      return invoice.amount >= 1000 ? InvoicePriority.high : InvoicePriority.medium;
    } else {
      return invoice.amount >= 1000 ? InvoicePriority.medium : InvoicePriority.low;
    }
  }

  // Helper: Convert InvoiceStatus to PaymentStatus
  PaymentStatus _fromInvoiceStatus(invoice_entity.InvoiceStatus status) {
    switch (status) {
      case invoice_entity.InvoiceStatus.draft:
        return PaymentStatus.pending;
      case invoice_entity.InvoiceStatus.pending:
        return PaymentStatus.pending;
      case invoice_entity.InvoiceStatus.paid:
        return PaymentStatus.completed;
      case invoice_entity.InvoiceStatus.expired:
        return PaymentStatus.failed;
      case invoice_entity.InvoiceStatus.cancelled:
        return PaymentStatus.cancelled;
    }
  }

  // Helper: Convert PaymentStatus to InvoiceStatus
  invoice_entity.InvoiceStatus _toInvoiceStatus(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return invoice_entity.InvoiceStatus.pending;
      case PaymentStatus.processing:
        return invoice_entity.InvoiceStatus.pending;
      case PaymentStatus.completed:
        return invoice_entity.InvoiceStatus.paid;
      case PaymentStatus.failed:
        return invoice_entity.InvoiceStatus.expired;
      case PaymentStatus.cancelled:
        return invoice_entity.InvoiceStatus.cancelled;
    }
  }
}
