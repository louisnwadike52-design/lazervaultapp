import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/tagged_invoice.pb.dart' as pb_tagged;
import 'package:lazervault/src/generated/invoice_payment.pb.dart' as pb_payment;
import 'package:lazervault/src/generated/common.pb.dart' as pb_common;
import 'package:lazervault/src/generated/common.pbenum.dart';
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/features/invoice/domain/entities/invoice_entity.dart';
import 'package:lazervault/src/features/invoice/domain/repositories/tagged_invoice_repository.dart';
import 'package:fixnum/fixnum.dart' as fixnum;

class TaggedInvoiceRepositoryGrpcImpl implements TaggedInvoiceRepository {
  final GrpcClient grpcClient;

  TaggedInvoiceRepositoryGrpcImpl({required this.grpcClient});

  @override
  Future<List<TaggedInvoice>> getIncomingTaggedInvoices({
    int page = 1,
    int limit = 20,
    InvoicePaymentStatus? statusFilter,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb_tagged.GetTaggedInvoicesRequest()
          ..pageSize = limit;

        if (statusFilter != null) {
          request.statusFilter = statusFilter;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.getTaggedInvoices(
          request,
          options: options,
        );

        return response.invoices.map((invoice) => _taggedInvoiceFromProto(invoice)).toList();
      },
    );
  }

  @override
  Future<List<TaggedInvoice>> getOutgoingTaggedInvoices({
    int page = 1,
    int limit = 20,
    InvoicePaymentStatus? statusFilter,
  }) async {
    // For outgoing, we'll use the same endpoint but the backend should filter
    // by invoices where the current user is the creator
    // This may need a separate backend endpoint, but for now using the same
    return retryWithBackoff(
      operation: () async {
        final request = pb_tagged.GetTaggedInvoicesRequest()
          ..pageSize = limit;

        if (statusFilter != null) {
          request.statusFilter = statusFilter;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.getTaggedInvoices(
          request,
          options: options,
        );

        return response.invoices.map((invoice) => _taggedInvoiceFromProto(invoice)).toList();
      },
    );
  }

  @override
  Future<TaggedInvoiceStatistics> getIncomingStatistics() async {
    return retryWithBackoff(
      operation: () async {
        final request = pb_tagged.GetTaggedInvoiceStatisticsRequest();
        final options = await grpcClient.callOptions;

        final response = await grpcClient.taggedInvoiceClient.getTaggedInvoiceStatistics(
          request,
          options: options,
        );

        return _statisticsFromProto(response.statistics);
      },
    );
  }

  @override
  Future<TaggedInvoiceStatistics> getOutgoingStatistics() async {
    // For now, using the same endpoint
    // May need separate backend endpoint for outgoing statistics
    return getIncomingStatistics();
  }

  @override
  Future<TaggedInvoice> getTaggedInvoiceById(String taggedInvoiceId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb_tagged.GetTaggedInvoiceByIdRequest()
          ..invoiceId = taggedInvoiceId;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.getTaggedInvoiceById(
          request,
          options: options,
        );

        return _taggedInvoiceFromProto(response.invoice);
      },
    );
  }

  @override
  Future<void> markAsViewed(String invoiceId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb_tagged.MarkTaggedInvoiceAsViewedRequest()
          ..invoiceId = invoiceId;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.markTaggedInvoiceAsViewed(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }
      },
    );
  }

  @override
  Future<Map<String, dynamic>> payTaggedInvoice({
    required String invoiceId,
    required String sourceAccountId,
    String currency = 'USD',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb_payment.ProcessInvoicePaymentRequest()
          ..invoiceId = invoiceId
          ..paymentMethodId = sourceAccountId;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoicePaymentClient.processInvoicePayment(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return {
          'transaction_id': response.result.transactionId,
          'confirmation_code': response.result.confirmationCode,
          'amount': response.result.amountProcessed,
          'currency': currency,
          'fee_amount': response.result.feeAmount,
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
        final request = pb_tagged.GetOverdueTaggedInvoicesRequest()
          ..pageSize = limit
          ..daysOverdue = 1; // Any invoice past due date

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.getOverdueTaggedInvoices(
          request,
          options: options,
        );

        return response.invoices.map((invoice) => _taggedInvoiceFromProto(invoice)).toList();
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
        final request = pb_tagged.GetUpcomingTaggedInvoicesRequest()
          ..pageSize = limit
          ..daysAhead = daysAhead;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.getUpcomingTaggedInvoices(
          request,
          options: options,
        );

        return response.invoices.map((invoice) => _taggedInvoiceFromProto(invoice)).toList();
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
    return retryWithBackoff(
      operation: () async {
        final request = pb_tagged.SearchTaggedInvoicesRequest()
          ..query = query
          ..pageSize = limit;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.searchTaggedInvoices(
          request,
          options: options,
        );

        return response.invoices.map((invoice) => _taggedInvoiceFromProto(invoice)).toList();
      },
    );
  }

  @override
  Future<void> setPaymentReminder({
    required String invoiceId,
    required DateTime reminderDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb_tagged.SetInvoicePaymentReminderRequest()
          ..invoiceId = invoiceId
          ..reminderDate = _dateTimeToTimestamp(reminderDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.taggedInvoiceClient.setInvoicePaymentReminder(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }
      },
    );
  }

  @override
  Future<void> updateNotes({
    required String taggedInvoiceId,
    required String notes,
  }) async {
    return retryWithBackoff(
      operation: () async {
        // This would require a backend endpoint for updating notes
        // For now, throwing unimplemented
        throw UnimplementedError('Update notes not yet implemented in backend');
      },
    );
  }

  @override
  Future<void> updatePriority({
    required String taggedInvoiceId,
    required InvoicePriority priority,
  }) async {
    return retryWithBackoff(
      operation: () async {
        // This would require a backend endpoint for updating priority
        // For now, throwing unimplemented
        throw UnimplementedError('Update priority not yet implemented in backend');
      },
    );
  }

  // Helper methods for proto conversion
  TaggedInvoice _taggedInvoiceFromProto(pb_tagged.TaggedInvoice proto) {
    return TaggedInvoice(
      id: proto.id,
      invoiceId: proto.invoiceId,
      userId: proto.userId,
      paymentStatus: proto.paymentStatus,
      priority: _priorityFromString(proto.priority.name),
      isViewed: proto.isViewed,
      taggedAt: proto.taggedAt.toDateTime(),
      viewedAt: proto.hasViewedAt() ? proto.viewedAt.toDateTime() : null,
      reminderDate: proto.hasReminderDate() ? proto.reminderDate.toDateTime() : null,
      reminderSent: proto.reminderSent,
      notes: proto.notes.isNotEmpty ? proto.notes : null,
      // Note: Invoice details would need to be joined from invoice table
      // This may require a separate API call or backend to include invoice data
    );
  }

  TaggedInvoiceStatistics _statisticsFromProto(pb_tagged.TaggedInvoiceStatistics proto) {
    return TaggedInvoiceStatistics(
      totalInvoices: proto.totalInvoices.toInt(),
      pendingInvoices: proto.pendingInvoices.toInt(),
      overdueInvoices: proto.overdueInvoices.toInt(),
      paidInvoices: proto.completedInvoices.toInt(),
      totalAmount: proto.totalAmount,
      pendingAmount: proto.pendingAmount,
      overdueAmount: proto.overdueAmount,
      paidAmount: proto.completedAmount,
    );
  }

  InvoicePriority _priorityFromString(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
      case 'invoice_priority_low':
        return InvoicePriority.INVOICE_PRIORITY_LOW;
      case 'high':
      case 'invoice_priority_high':
        return InvoicePriority.INVOICE_PRIORITY_HIGH;
      case 'urgent':
      case 'invoice_priority_urgent':
        return InvoicePriority.INVOICE_PRIORITY_URGENT;
      case 'medium':
      case 'invoice_priority_medium':
      default:
        return InvoicePriority.INVOICE_PRIORITY_MEDIUM;
    }
  }

  timestamp_pb.Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    final timestamp = timestamp_pb.Timestamp()
      ..seconds = fixnum.Int64(dateTime.millisecondsSinceEpoch ~/ 1000)
      ..nanos = (dateTime.millisecondsSinceEpoch % 1000) * 1000000;
    return timestamp;
  }
}
