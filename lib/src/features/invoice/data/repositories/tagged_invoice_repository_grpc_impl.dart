import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/invoice.pb.dart' as pb;
import 'package:lazervault/src/generated/common.pbenum.dart';
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/features/invoice/domain/entities/invoice_entity.dart';
import 'package:lazervault/src/features/invoice/domain/repositories/tagged_invoice_repository.dart';

/// gRPC-based implementation of TaggedInvoiceRepository.
/// Uses the InvoiceServiceClient (invoice.InvoiceService) which is proxied
/// through the banking-gateway. This replaces the old TaggedInvoiceServiceClient
/// approach since the backend only implements InvoiceService.
class TaggedInvoiceRepositoryGrpcImpl implements TaggedInvoiceRepository {
  final GrpcClient grpcClient;

  TaggedInvoiceRepositoryGrpcImpl({required this.grpcClient});

  @override
  Future<List<TaggedInvoice>> getIncomingTaggedInvoices({
    int page = 1,
    int limit = 20,
    InvoicePaymentStatus? statusFilter,
    String? currency,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoicesTaggedToUserRequest()
          ..page = page
          ..pageSize = limit;

        if (statusFilter != null) {
          request.status = _paymentStatusToString(statusFilter);
        }

        if (currency != null && currency.isNotEmpty) {
          request.currency = currency;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoicesTaggedToUser(
          request,
          options: options,
        );

        return response.invoices.map((inv) => _invoiceToTaggedInvoice(inv, isIncoming: true)).toList();
      },
    );
  }

  /// Get incoming tagged invoices with full pagination metadata
  Future<TaggedInvoicePaginatedResult> getIncomingTaggedInvoicesPaginated({
    int page = 1,
    int pageSize = 20,
    InvoicePaymentStatus? statusFilter,
    String? currency,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoicesTaggedToUserRequest()
          ..page = page
          ..pageSize = pageSize;

        if (statusFilter != null) {
          request.status = _paymentStatusToString(statusFilter);
        }
        if (currency != null && currency.isNotEmpty) {
          request.currency = currency;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoicesTaggedToUser(
          request,
          options: options,
        );

        final invoices = response.invoices.map((inv) => _invoiceToTaggedInvoice(inv, isIncoming: true)).toList();
        final pagination = response.pagination;

        return TaggedInvoicePaginatedResult(
          invoices: invoices,
          currentPage: pagination.currentPage,
          pageSize: pagination.pageSize,
          totalCount: pagination.totalCount,
          totalPages: pagination.totalPages,
          hasNext: pagination.hasNext,
          hasPrevious: pagination.hasPrevious,
        );
      },
    );
  }

  @override
  Future<List<TaggedInvoice>> getOutgoingTaggedInvoices({
    int page = 1,
    int limit = 20,
    InvoicePaymentStatus? statusFilter,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetSentInvoicesRequest()
          ..limit = limit
          ..offset = (page - 1) * limit;

        if (statusFilter != null) {
          request.status = _paymentStatusToString(statusFilter);
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getSentInvoices(
          request,
          options: options,
        );

        return response.invoices.map((inv) => _invoiceToTaggedInvoice(inv, isIncoming: false)).toList();
      },
    );
  }

  @override
  Future<TaggedInvoiceStatistics> getIncomingStatistics() async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoiceStatisticsRequest();
        final options = await grpcClient.callOptions;

        try {
          final response = await grpcClient.invoiceClient.getInvoiceStatistics(
            request,
            options: options,
          );

          final stats = response.statistics;
          return TaggedInvoiceStatistics(
            totalInvoices: stats.totalReceived,
            pendingInvoices: stats.totalPending,
            overdueInvoices: stats.totalOverdue,
            paidInvoices: stats.totalPaid,
            totalAmount: stats.totalAmountReceived,
            pendingAmount: stats.totalAmountPending,
            overdueAmount: stats.totalAmountOverdue,
            paidAmount: stats.totalAmountPaid,
          );
        } catch (_) {
          return TaggedInvoiceStatistics.empty;
        }
      },
    );
  }

  @override
  Future<TaggedInvoiceStatistics> getOutgoingStatistics() async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoiceStatisticsRequest();
        final options = await grpcClient.callOptions;

        try {
          final response = await grpcClient.invoiceClient.getInvoiceStatistics(
            request,
            options: options,
          );

          final stats = response.statistics;
          return TaggedInvoiceStatistics(
            totalInvoices: stats.totalSent,
            pendingInvoices: stats.totalPending,
            overdueInvoices: stats.totalOverdue,
            paidInvoices: stats.totalPaid,
            totalAmount: stats.totalAmountSent,
            pendingAmount: stats.totalAmountPending,
            overdueAmount: stats.totalAmountOverdue,
            paidAmount: stats.totalAmountPaid,
          );
        } catch (_) {
          return TaggedInvoiceStatistics.empty;
        }
      },
    );
  }

  @override
  Future<TaggedInvoice> getTaggedInvoiceById(String taggedInvoiceId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoiceRequest()
          ..invoiceId = taggedInvoiceId;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoice(
          request,
          options: options,
        );

        return _invoiceToTaggedInvoice(response.invoice, isIncoming: true);
      },
    );
  }

  @override
  Future<void> markAsViewed(String invoiceId) async {
    // No direct RPC for this in InvoiceService - silently succeed
    // The backend can track views via the GetInvoice call itself
  }

  @override
  Future<Map<String, dynamic>> payTaggedInvoice({
    required String invoiceId,
    required String sourceAccountId,
    required String pin,
    required String verificationToken,
    required String transactionId,
    required String idempotencyKey,
    String currency = 'USD',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.PayInvoiceRequest()
          ..invoiceId = invoiceId
          ..accountId = sourceAccountId
          ..pin = pin
          ..verificationToken = verificationToken
          ..transactionId = transactionId
          ..idempotencyKey = idempotencyKey;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.payInvoice(
          request,
          options: options,
        );

        return {
          'transaction_id': response.paymentReference,
          'invoice_id': response.invoice.id,
          'amount': response.invoice.totalAmount,
          'currency': currency,
          'new_balance': response.newBalance,
          'message': response.message,
        };
      },
    );
  }

  @override
  Future<List<TaggedInvoice>> getOverdueTaggedInvoices({
    int page = 1,
    int limit = 20,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoicesTaggedToUserRequest()
          ..limit = limit
          ..offset = (page - 1) * limit
          ..status = 'overdue';

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoicesTaggedToUser(
          request,
          options: options,
        );

        return response.invoices.map((inv) => _invoiceToTaggedInvoice(inv, isIncoming: true)).toList();
      },
    );
  }

  @override
  Future<List<TaggedInvoice>> getUpcomingTaggedInvoices({
    int page = 1,
    int limit = 20,
    int daysAhead = 7,
  }) async {
    return retryWithBackoff(
      operation: () async {
        // Use getInvoicesTaggedToUser with pending status - filter client-side for upcoming
        final request = pb.GetInvoicesTaggedToUserRequest()
          ..limit = limit
          ..offset = (page - 1) * limit
          ..status = 'pending';

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoicesTaggedToUser(
          request,
          options: options,
        );

        final now = DateTime.now();
        final cutoff = now.add(Duration(days: daysAhead));

        return response.invoices
            .where((inv) {
              if (inv.dueDate.isEmpty) return false;
              try {
                final dueDate = DateTime.parse(inv.dueDate);
                return dueDate.isAfter(now) && dueDate.isBefore(cutoff);
              } catch (_) {
                return false;
              }
            })
            .map((inv) => _invoiceToTaggedInvoice(inv, isIncoming: true))
            .toList();
      },
    );
  }

  @override
  Future<List<TaggedInvoice>> searchTaggedInvoices({
    required String query,
    bool incoming = true,
    int page = 1,
    int limit = 20,
  }) async {
    // Use the appropriate list endpoint and filter client-side
    if (incoming) {
      final all = await getIncomingTaggedInvoices(page: page, limit: limit);
      final lowerQuery = query.toLowerCase();
      return all.where((inv) =>
          inv.title.toLowerCase().contains(lowerQuery) ||
          inv.description.toLowerCase().contains(lowerQuery) ||
          inv.displayName.toLowerCase().contains(lowerQuery)).toList();
    } else {
      final all = await getOutgoingTaggedInvoices(page: page, limit: limit);
      final lowerQuery = query.toLowerCase();
      return all.where((inv) =>
          inv.title.toLowerCase().contains(lowerQuery) ||
          inv.description.toLowerCase().contains(lowerQuery) ||
          inv.displayName.toLowerCase().contains(lowerQuery)).toList();
    }
  }

  @override
  Future<void> setPaymentReminder({
    required String invoiceId,
    required DateTime reminderDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.SendInvoiceReminderRequest()
          ..invoiceId = invoiceId;

        final options = await grpcClient.callOptions;
        await grpcClient.invoiceClient.sendInvoiceReminder(
          request,
          options: options,
        );
      },
    );
  }

  @override
  Future<void> updateNotes({
    required String taggedInvoiceId,
    required String notes,
  }) async {
    throw UnimplementedError('Update notes not yet supported');
  }

  @override
  Future<void> updatePriority({
    required String taggedInvoiceId,
    required InvoicePriority priority,
  }) async {
    throw UnimplementedError('Update priority not yet supported');
  }

  // Convert backend Invoice proto to TaggedInvoice entity
  TaggedInvoice _invoiceToTaggedInvoice(pb.Invoice proto, {required bool isIncoming}) {
    final statusStr = proto.status.toLowerCase();
    final InvoiceStatus invoiceStatus;
    if (statusStr == 'paid' || statusStr == 'completed') {
      invoiceStatus = InvoiceStatus.paid;
    } else if (statusStr == 'partially_paid' || statusStr == 'partiallypaid') {
      invoiceStatus = InvoiceStatus.partiallyPaid;
    } else if (statusStr == 'cancelled' || statusStr == 'canceled') {
      invoiceStatus = InvoiceStatus.cancelled;
    } else if (statusStr == 'expired') {
      invoiceStatus = InvoiceStatus.expired;
    } else if (statusStr == 'draft') {
      invoiceStatus = InvoiceStatus.draft;
    } else {
      invoiceStatus = InvoiceStatus.pending;
    }

    final totalAmount = proto.totalAmount > 0 ? proto.totalAmount : proto.amount;

    final invoice = Invoice(
      id: proto.id,
      title: proto.description.isNotEmpty ? proto.description : 'Invoice',
      description: proto.description.isNotEmpty ? proto.description : '',
      amount: proto.amount,
      currency: proto.currency.isNotEmpty ? proto.currency : 'NGN',
      status: invoiceStatus,
      type: InvoiceType.invoice,
      createdAt: proto.createdAt.isNotEmpty ? DateTime.parse(proto.createdAt) : DateTime.now(),
      dueDate: proto.dueDate.isNotEmpty ? DateTime.parse(proto.dueDate) : null,
      fromUserId: proto.userId,
      toUserId: proto.accountId.isNotEmpty ? proto.accountId : null,
      toEmail: proto.recipientEmail.isNotEmpty ? proto.recipientEmail : null,
      toName: proto.recipientName.isNotEmpty ? proto.recipientName : null,
      paymentReference: proto.paymentReference.isNotEmpty ? proto.paymentReference : null,
      items: proto.items.isNotEmpty
          ? proto.items.map((item) => InvoiceItem(
              id: 'item_${DateTime.now().millisecondsSinceEpoch}',
              name: item.description.contains(':') ? item.description.split(':').first.trim() : item.description,
              description: item.description.isNotEmpty ? item.description : null,
              quantity: item.quantity.toDouble(),
              unitPrice: item.unitPrice,
              totalPrice: item.total,
            )).toList()
          : [InvoiceItem(
              id: 'item_default',
              name: 'Invoice Item',
              description: proto.description,
              quantity: 1,
              unitPrice: proto.amount,
              totalPrice: proto.amount,
            )],
      notes: proto.notes.isNotEmpty ? proto.notes : null,
      taxAmount: proto.tax > 0 ? proto.tax : null,
      discountAmount: proto.discount > 0 ? proto.discount : null,
      totalAmount: totalAmount,
    );

    // Determine payment status from invoice status
    InvoicePaymentStatus paymentStatus;
    switch (statusStr) {
      case 'paid':
      case 'completed':
        paymentStatus = InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_COMPLETED;
        break;
      case 'cancelled':
        paymentStatus = InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_CANCELLED;
        break;
      case 'overdue':
        paymentStatus = InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_OVERDUE;
        break;
      default:
        // Check if overdue based on due date
        if (proto.dueDate.isNotEmpty) {
          try {
            final dueDate = DateTime.parse(proto.dueDate);
            if (dueDate.isBefore(DateTime.now())) {
              paymentStatus = InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_OVERDUE;
              break;
            }
          } catch (_) {}
        }
        paymentStatus = InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING;
    }

    return TaggedInvoice(
      id: proto.id,
      invoiceId: proto.id,
      userId: isIncoming ? proto.userId : proto.accountId,
      paymentStatus: paymentStatus,
      priority: InvoicePriority.INVOICE_PRIORITY_MEDIUM,
      isViewed: true,
      taggedAt: proto.createdAt.isNotEmpty ? DateTime.parse(proto.createdAt) : DateTime.now(),
      invoice: invoice,
      taggerName: isIncoming ? null : null,
      taggerUsername: null,
      taggedUserName: !isIncoming ? proto.recipientName : proto.recipientName,
      taggedUserUsername: null,
    );
  }

  String _paymentStatusToString(InvoicePaymentStatus status) {
    switch (status) {
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING:
        return 'pending';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_COMPLETED:
        return 'paid';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_OVERDUE:
        return 'overdue';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_CANCELLED:
        return 'cancelled';
      default:
        return '';
    }
  }
}
