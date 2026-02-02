import 'dart:typed_data';
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
          ..description = invoice.description
          ..amount = invoice.amount
          ..dueDate = invoice.dueDate?.toUtc().toIso8601String() ?? DateTime.now().add(Duration(days: 30)).toUtc().toIso8601String()
          ..tax = invoice.taxAmount ?? 0.0
          ..discount = invoice.discountAmount ?? 0.0
          ..notes = invoice.notes ?? ''
          ..payerEmail = invoice.payerDetails?.email ?? ''
          ..currency = invoice.currency
          ..payerLogoUrl = invoice.payerLogoUrl ?? ''
          ..recipientLogoUrl = invoice.recipientLogoUrl ?? '';

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
    return retryWithBackoff(
      operation: () async {
        final request = pb.UpdateInvoiceStatusRequest()
          ..invoiceId = invoiceId
          ..status = 'pending';
        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.updateInvoiceStatus(
          request,
          options: options,
        );
        return _fromProto(response.invoice);
      },
    );
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
    return retryWithBackoff(
      operation: () async {
        final request = pb.UpdateInvoiceRequest()
          ..invoiceId = invoice.id
          ..description = invoice.description
          ..amount = invoice.amount
          ..notes = invoice.notes ?? '';

        if (invoice.dueDate != null) {
          request.dueDate = invoice.dueDate!.toUtc().toIso8601String();
        }
        if (invoice.items.isNotEmpty) {
          request.items.addAll(invoice.items.map((item) => pb.InvoiceItem()
            ..description = '${item.name}: ${item.description ?? ''}'
            ..quantity = item.quantity.toInt()
            ..unitPrice = item.unitPrice
            ..total = item.totalPrice));
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.updateInvoice(
          request,
          options: options,
        );
        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<void> deleteInvoice(String id) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.DeleteInvoiceRequest()..invoiceId = id;
        final options = await grpcClient.callOptions;
        await grpcClient.invoiceClient.deleteInvoice(
          request,
          options: options,
        );
      },
    );
  }

  @override
  Future<List<Invoice>> getInvoicesTaggedToUser(String userId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoicesTaggedToUserRequest()
          ..limit = 100
          ..offset = 0;
        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoicesTaggedToUser(
          request,
          options: options,
        );
        return response.invoices.map((inv) => _fromProto(inv)).toList();
      },
    );
  }

  @override
  Future<Invoice> markInvoiceAsPaid(String invoiceId, PaymentMethod paymentMethod, String? paymentReference, {String? pin, String? verificationToken}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.PayInvoiceRequest()
          ..invoiceId = invoiceId
          ..accountId = currentUserId;

        if (pin != null && pin.isNotEmpty) {
          request.pin = pin;
        }
        if (verificationToken != null && verificationToken.isNotEmpty) {
          request.verificationToken = verificationToken;
        }
        if (paymentReference != null && paymentReference.isNotEmpty) {
          request.idempotencyKey = paymentReference;
        }

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
  Future<Invoice> unlockInvoice(String invoiceId, {String? accountId, String? pin, String? verificationToken, String? transactionId, String? idempotencyKey}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.UnlockInvoiceRequest()
          ..invoiceId = invoiceId
          ..accountId = accountId ?? currentUserId;

        if (pin != null && pin.isNotEmpty) {
          request.pin = pin;
        }
        if (verificationToken != null && verificationToken.isNotEmpty) {
          request.verificationToken = verificationToken;
        }
        if (transactionId != null && transactionId.isNotEmpty) {
          request.transactionId = transactionId;
        }
        if (idempotencyKey != null && idempotencyKey.isNotEmpty) {
          request.idempotencyKey = idempotencyKey;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.unlockInvoice(
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
             inv.description.toLowerCase().contains(lowerQuery) ||
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
          return {
            'total_invoices': stats.totalSent + stats.totalReceived,
            'paid_invoices': stats.totalPaid,
            'pending_invoices': stats.totalPending,
            'overdue_invoices': stats.totalOverdue,
            'unpaid_invoices': stats.totalPending,
            'total_amount': stats.totalAmountSent + stats.totalAmountReceived,
            'total_paid': stats.totalAmountPaid,
            'total_unpaid': stats.totalAmountPending,
            'collection_rate': stats.collectionRate,
          };
        } catch (_) {
          // Fallback to client-side calculation if backend RPC not available
          final invoices = await getInvoicesByUserId(userId);
          final paidInvoices = invoices.where((inv) => inv.status == InvoiceStatus.paid).toList();
          final unpaidInvoices = invoices.where((inv) => inv.status != InvoiceStatus.paid).toList();
          final totalAmount = invoices.fold<double>(0, (sum, inv) => sum + inv.amount);
          final totalPaid = paidInvoices.fold<double>(0, (sum, inv) => sum + inv.amount);
          final totalUnpaid = unpaidInvoices.fold<double>(0, (sum, inv) => sum + inv.amount);

          return {
            'total_invoices': invoices.length,
            'paid_invoices': paidInvoices.length,
            'pending_invoices': invoices.where((inv) => inv.status == InvoiceStatus.pending).length,
            'overdue_invoices': invoices.where((inv) => inv.isOverdue && inv.status != InvoiceStatus.paid).length,
            'unpaid_invoices': unpaidInvoices.length,
            'total_amount': totalAmount,
            'total_paid': totalPaid,
            'total_unpaid': totalUnpaid,
            'collection_rate': totalAmount > 0 ? (totalPaid / totalAmount) * 100 : 0.0,
          };
        }
      },
    );
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
    return retryWithBackoff(
      operation: () async {
        final request = pb.TagUsersToInvoiceRequest()
          ..invoiceId = invoiceId;
        request.userIds.addAll(userIds);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.tagUsersToInvoice(
          request,
          options: options,
        );

        return TagUsersResponse(
          success: response.usersTagged > 0,
          taggedUserIds: userIds,
          invitedEmails: emails,
          invitedPhones: phoneNumbers,
          message: response.message,
        );
      },
    );
  }

  @override
  Future<List<InvoiceUser>> searchUsers(String query, {int limit = 20}) async {
    // User search is handled via auth-service through the invoice-service backend
    // The backend's TagUsersToInvoice validates user IDs via auth-service
    // For user search UI, use the profile cubit's searchUsers which calls auth-service directly
    throw UnimplementedError('Use ProfileCubit.searchUsers for user search');
  }

  /// Upload an image for invoice logos and return the URL
  @override
  Future<PaginatedInvoiceResult> getSentInvoicesPaginated({
    int page = 1,
    int pageSize = 20,
    String? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetSentInvoicesRequest()
          ..page = page
          ..pageSize = pageSize;
        if (status != null && status.isNotEmpty) {
          request.status = status;
        }
        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getSentInvoices(
          request,
          options: options,
        );

        final invoices = response.invoices.map((inv) => _fromProto(inv)).toList();
        final pagination = response.pagination;

        return PaginatedInvoiceResult(
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

  Future<String> uploadInvoiceImage(Uint8List data, String fileName, String contentType) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.UploadInvoiceImageRequest()
          ..imageData = data
          ..fileName = fileName
          ..contentType = contentType;
        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.uploadInvoiceImage(
          request,
          options: options,
        );
        return response.imageUrl;
      },
    );
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
    final InvoiceStatus status;
    if (statusStr == 'paid' || statusStr == 'completed') {
      status = InvoiceStatus.paid;
    } else if (statusStr == 'partially_paid' || statusStr == 'partiallypaid') {
      status = InvoiceStatus.partiallyPaid;
    } else if (statusStr == 'cancelled' || statusStr == 'canceled') {
      status = InvoiceStatus.cancelled;
    } else if (statusStr == 'expired') {
      status = InvoiceStatus.expired;
    } else if (statusStr == 'draft') {
      status = InvoiceStatus.draft;
    } else {
      status = InvoiceStatus.pending;
    }

    // Calculate total amount from proto fields
    final totalAmount = proto.totalAmount > 0 ? proto.totalAmount : proto.amount;

    return Invoice(
      id: proto.id,
      title: proto.description.isNotEmpty ? proto.description : 'Invoice',
      description: proto.description.isNotEmpty ? proto.description : '',
      amount: proto.amount,
      currency: proto.currency.isNotEmpty ? proto.currency : 'USD',
      status: _deriveStatusWithPartiallyPaid(status, proto.taggedUsers),
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
      paymentMethod: null,
      recipientDetails: (proto.recipientName.isNotEmpty || proto.recipientEmail.isNotEmpty)
          ? AddressDetails(
              contactName: proto.recipientName.isNotEmpty ? proto.recipientName : null,
              email: proto.recipientEmail.isNotEmpty ? proto.recipientEmail : null,
            )
          : null,
      payerDetails: proto.payerEmail.isNotEmpty
          ? AddressDetails(
              email: proto.payerEmail,
            )
          : null,
      payerLogoUrl: proto.payerLogoUrl.isNotEmpty ? proto.payerLogoUrl : null,
      recipientLogoUrl: proto.recipientLogoUrl.isNotEmpty ? proto.recipientLogoUrl : null,
      isUnlocked: proto.isUnlocked,
      unlockPaymentRef: proto.unlockPaymentRef.isNotEmpty ? proto.unlockPaymentRef : null,
      taggedUsers: proto.taggedUsers.isNotEmpty
          ? proto.taggedUsers.map((tu) => TaggedUserInfo(
              userId: tu.userId,
              username: tu.username,
              firstName: tu.firstName,
              lastName: tu.lastName,
              profilePicture: tu.profilePicture.isNotEmpty ? tu.profilePicture : null,
              status: tu.status.isNotEmpty ? tu.status : 'pending',
              taggedAt: tu.taggedAt.isNotEmpty ? DateTime.tryParse(tu.taggedAt) : null,
              viewedAt: tu.viewedAt.isNotEmpty ? DateTime.tryParse(tu.viewedAt) : null,
              paidAt: tu.paidAt.isNotEmpty ? DateTime.tryParse(tu.paidAt) : null,
            )).toList()
          : null,
    );
  }

  // Derive partiallyPaid status from tagged users when backend reports pending
  // but some (not all) tagged users have paid
  InvoiceStatus _deriveStatusWithPartiallyPaid(
      InvoiceStatus backendStatus, List<pb.TaggedUser> taggedUsers) {
    if (taggedUsers.isEmpty) return backendStatus;
    // Only derive from pending invoices - if backend says paid, trust it
    if (backendStatus != InvoiceStatus.pending) return backendStatus;
    final paidCount = taggedUsers.where((u) => u.status.toLowerCase() == 'paid').length;
    if (paidCount > 0 && paidCount < taggedUsers.length) {
      return InvoiceStatus.partiallyPaid;
    }
    return backendStatus;
  }

  // Helper: Extract name from description
  String _extractNameFromDescription(String description) {
    if (description.contains(':')) {
      return description.split(':').first.trim();
    }
    if (description.length > 30) {
      return '${description.substring(0, 30)}...';
    }
    return description.isNotEmpty ? description : 'Item';
  }
}
