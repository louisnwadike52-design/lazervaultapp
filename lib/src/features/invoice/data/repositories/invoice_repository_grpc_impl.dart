import '../../../../core/network/grpc_client.dart';
import '../../../../core/network/retry_helper.dart';
import '../../../../generated/invoice.pb.dart' as pb;
import '../../../../generated/invoice_payment.pb.dart' as payment_pb;
import '../../../../generated/common.pbenum.dart' as common_pb;
import '../../../../generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;

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
          ..page = 1
          ..limit = 100;
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
        final request = pb.GetInvoiceByIdRequest()..invoiceId = id;
        final options = await grpcClient.callOptions;

        final response = await grpcClient.invoiceClient.getInvoiceById(
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
          ..recipientId = invoice.toUserId ?? ''
          ..title = invoice.title
          ..description = invoice.description ?? ''
          ..amount = invoice.amount
          ..currency = invoice.currency
          ..dueDate = invoice.dueDate?.toUtc().toIso8601String() ?? DateTime.now().add(Duration(days: 30)).toUtc().toIso8601String()
          ..toEmail = invoice.toEmail ?? ''
          ..toName = invoice.toName ?? ''
          ..notes = invoice.notes ?? ''
          ..taxAmount = invoice.taxAmount ?? 0.0
          ..discountAmount = invoice.discountAmount ?? 0.0
          ..totalAmount = invoice.totalAmount;

        // Add invoice items
        if (invoice.items.isNotEmpty) {
          request.items.addAll(invoice.items.map((item) => pb.InvoiceItem()
            ..id = item.id
            ..name = item.name
            ..description = item.description ?? ''
            ..quantity = item.quantity
            ..unitPrice = item.unitPrice
            ..totalPrice = item.totalPrice
            ..category = item.category ?? ''));
        }

        // Add recipient details if available
        if (invoice.recipientDetails != null && !invoice.recipientDetails!.isEmpty) {
          request.recipientDetails = _addressDetailsToProto(invoice.recipientDetails!);
        }

        // Add payer details if available
        if (invoice.payerDetails != null && !invoice.payerDetails!.isEmpty) {
          request.payerDetails = _addressDetailsToProto(invoice.payerDetails!);
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
        final request = pb.SendInvoiceRequest()..invoiceId = invoiceId;
        final options = await grpcClient.callOptions;

        final response = await grpcClient.invoiceClient.sendInvoice(
          request,
          options: options,
        );

        if (response.success) {
          // Fetch and return the updated invoice
          final updatedInvoice = await getInvoiceById(invoiceId);
          if (updatedInvoice == null) {
            throw Exception('Failed to fetch updated invoice');
          }
          return updatedInvoice;
        } else {
          throw Exception('Failed to send invoice');
        }
      },
    );
  }

  @override
  Future<List<Invoice>> getInvoicesByUserId(String userId) async {
    // Filter on client side for now
    final allInvoices = await getAllInvoices();
    return allInvoices.where((inv) => inv.fromUserId == userId).toList();
  }

  @override
  Future<List<Invoice>> getInvoicesByStatus(InvoiceStatus status) async {
    return retryWithBackoff(
      operation: () async {
        final isPaid = status == InvoiceStatus.paid;
        final request = pb.GetInvoicesByStatusRequest()
          ..isPaid = isPaid
          ..page = 1
          ..limit = 100;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoicesByStatus(
          request,
          options: options,
        );

        return response.invoices.map((inv) => _fromProto(inv)).toList();
      },
    );
  }

  // Methods not yet supported by backend - throwing UnimplementedError
  // These can be implemented as the backend APIs are added

  @override
  Future<Invoice> updateInvoice(Invoice invoice) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.UpdateInvoiceRequest()
          ..invoiceId = invoice.id
          ..recipientId = invoice.toUserId ?? ''
          ..title = invoice.title
          ..description = invoice.description ?? ''
          ..amount = invoice.amount
          ..currency = invoice.currency
          ..dueDate = invoice.dueDate?.toUtc().toIso8601String() ?? ''
          ..toEmail = invoice.toEmail ?? ''
          ..toName = invoice.toName ?? ''
          ..notes = invoice.notes ?? ''
          ..taxAmount = invoice.taxAmount ?? 0.0
          ..discountAmount = invoice.discountAmount ?? 0.0
          ..totalAmount = invoice.totalAmount;

        // Add invoice items
        if (invoice.items.isNotEmpty) {
          request.items.addAll(invoice.items.map((item) => pb.InvoiceItem()
            ..id = item.id
            ..name = item.name
            ..description = item.description ?? ''
            ..quantity = item.quantity
            ..unitPrice = item.unitPrice
            ..totalPrice = item.totalPrice
            ..category = item.category ?? ''));
        }

        // Add recipient details if available
        if (invoice.recipientDetails != null && !invoice.recipientDetails!.isEmpty) {
          request.recipientDetails = _addressDetailsToProto(invoice.recipientDetails!);
        }

        // Add payer details if available
        if (invoice.payerDetails != null && !invoice.payerDetails!.isEmpty) {
          request.payerDetails = _addressDetailsToProto(invoice.payerDetails!);
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

        final response = await grpcClient.invoiceClient.deleteInvoice(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception('Failed to delete invoice');
        }
      },
    );
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
        final request = pb.MarkInvoiceAsPaidRequest()
          ..invoiceId = invoiceId
          ..paymentMethod = _paymentMethodToProto(paymentMethod)
          ..paymentReference = paymentReference ?? '';

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.markInvoiceAsPaid(
          request,
          options: options,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<Invoice> cancelInvoice(String invoiceId) async {
    throw UnimplementedError('CancelInvoice not yet available in backend API');
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
    return retryWithBackoff(
      operation: () async {
        final request = pb.TagUsersToInvoiceRequest()
          ..invoiceId = invoiceId
          ..userIds.addAll(userIds)
          ..emails.addAll(emails)
          ..phoneNumbers.addAll(phoneNumbers);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.tagUsersToInvoice(
          request,
          options: options,
        );

        return TagUsersResponse(
          success: response.success,
          taggedUserIds: response.taggedUserIds,
          invitedEmails: response.invitedEmails,
          invitedPhones: response.invitedPhones,
          message: response.message,
        );
      },
    );
  }

  @override
  Future<List<InvoiceUser>> searchUsers(String query, {int limit = 20}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.SearchInvoiceUsersRequest()
          ..query = query
          ..limit = limit;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.searchInvoiceUsers(
          request,
          options: options,
        );

        return response.users.map((user) => InvoiceUser(
          id: user.id,
          name: user.name,
          email: user.email,
          username: user.username,
          phone: user.phone,
          isOnline: user.isOnline,
        )).toList();
      },
    );
  }

  // Helper: Convert protobuf to entity
  Invoice _fromProto(pb.Invoice proto) {
    // Parse invoice items or create a default item
    List<InvoiceItem> items;
    if (proto.items.isNotEmpty) {
      items = proto.items.map((item) => InvoiceItem(
        id: item.id,
        name: item.name,
        description: item.description.isNotEmpty ? item.description : null,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        totalPrice: item.totalPrice,
        category: item.category.isNotEmpty ? item.category : null,
      )).toList();
    } else {
      // Create a default invoice item from the invoice amount
      items = [InvoiceItem(
        id: 'item_default',
        name: proto.title,
        description: proto.description.isNotEmpty ? proto.description : 'Invoice item',
        quantity: 1,
        unitPrice: proto.amount,
        totalPrice: proto.amount,
      )];
    }

    return Invoice(
      id: proto.id,
      title: proto.title,
      description: proto.description,
      amount: proto.amount,
      currency: proto.currency,
      status: proto.isPaid ? InvoiceStatus.paid : InvoiceStatus.pending,
      type: InvoiceType.invoice,
      createdAt: _fromProtoTimestamp(proto.createdAt),
      dueDate: proto.dueDate.isNotEmpty ? DateTime.parse(proto.dueDate) : null,
      fromUserId: proto.userId,
      toUserId: proto.recipientId.isNotEmpty ? proto.recipientId : null,
      toEmail: proto.toEmail.isNotEmpty ? proto.toEmail : null,
      toName: proto.toName.isNotEmpty ? proto.toName : null,
      paymentReference: proto.paymentReference.isNotEmpty ? proto.paymentReference : null,
      items: items,
      notes: proto.notes.isNotEmpty ? proto.notes : null,
      taxAmount: proto.taxAmount > 0 ? proto.taxAmount : null,
      discountAmount: proto.discountAmount > 0 ? proto.discountAmount : null,
      totalAmount: proto.totalAmount > 0 ? proto.totalAmount : proto.amount,
      paymentMethod: proto.paymentMethodId.isNotEmpty ? PaymentMethod.bank_transfer : null,
      recipientDetails: proto.hasRecipientDetails() ? _addressDetailsFromProto(proto.recipientDetails) : null,
      payerDetails: proto.hasPayerDetails() ? _addressDetailsFromProto(proto.payerDetails) : null,
    );
  }

  // Helper: Convert protobuf timestamp to DateTime
  DateTime _fromProtoTimestamp(timestamp_pb.Timestamp timestamp) {
    final milliseconds = timestamp.seconds.toInt() * 1000 +
                        (timestamp.nanos ~/ 1000000);
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  // Helper: Convert domain PaymentMethod enum to proto PaymentMethod message
  payment_pb.PaymentMethod _paymentMethodToProto(PaymentMethod method) {
    // Map domain enum to proto PaymentMethodType
    common_pb.PaymentMethodType protoType;
    switch (method) {
      case PaymentMethod.bank_transfer:
        protoType = common_pb.PaymentMethodType.PAYMENT_METHOD_TYPE_BANK_TRANSFER;
        break;
      case PaymentMethod.crypto:
        // Default to Bitcoin for crypto - could be enhanced to support specific crypto types
        protoType = common_pb.PaymentMethodType.PAYMENT_METHOD_TYPE_BITCOIN;
        break;
      case PaymentMethod.paypal:
        protoType = common_pb.PaymentMethodType.PAYMENT_METHOD_TYPE_PAYPAL;
        break;
      case PaymentMethod.card:
        // Default to credit card - could be enhanced to differentiate credit/debit
        protoType = common_pb.PaymentMethodType.PAYMENT_METHOD_TYPE_CREDIT_CARD;
        break;
      case PaymentMethod.cash:
        // Map cash to account balance (closest proto equivalent)
        protoType = common_pb.PaymentMethodType.PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE;
        break;
    }

    // Create and return PaymentMethod message with the appropriate type
    return payment_pb.PaymentMethod(type: protoType);
  }

  // Helper: Convert domain AddressDetails to proto AddressDetails
  pb.AddressDetails _addressDetailsToProto(AddressDetails details) {
    final proto = pb.AddressDetails();

    // Only set fields that have non-empty values
    if (details.companyName?.isNotEmpty == true) {
      proto.companyName = details.companyName!;
    }
    if (details.contactName?.isNotEmpty == true) {
      proto.contactName = details.contactName!;
    }
    if (details.email?.isNotEmpty == true) {
      proto.email = details.email!;
    }
    if (details.phone?.isNotEmpty == true) {
      proto.phone = details.phone!;
    }
    if (details.addressLine1?.isNotEmpty == true) {
      proto.addressLine1 = details.addressLine1!;
    }
    if (details.addressLine2?.isNotEmpty == true) {
      proto.addressLine2 = details.addressLine2!;
    }
    if (details.city?.isNotEmpty == true) {
      proto.city = details.city!;
    }
    if (details.state?.isNotEmpty == true) {
      proto.state = details.state!;
    }
    if (details.postcode?.isNotEmpty == true) {
      proto.postcode = details.postcode!;
    }
    if (details.country?.isNotEmpty == true) {
      proto.country = details.country!;
    }

    return proto;
  }

  // Helper: Convert proto AddressDetails to domain AddressDetails
  AddressDetails _addressDetailsFromProto(pb.AddressDetails proto) {
    return AddressDetails(
      companyName: proto.companyName.isNotEmpty ? proto.companyName : null,
      contactName: proto.contactName.isNotEmpty ? proto.contactName : null,
      email: proto.email.isNotEmpty ? proto.email : null,
      phone: proto.phone.isNotEmpty ? proto.phone : null,
      addressLine1: proto.addressLine1.isNotEmpty ? proto.addressLine1 : null,
      addressLine2: proto.addressLine2.isNotEmpty ? proto.addressLine2 : null,
      city: proto.city.isNotEmpty ? proto.city : null,
      state: proto.state.isNotEmpty ? proto.state : null,
      postcode: proto.postcode.isNotEmpty ? proto.postcode : null,
      country: proto.country.isNotEmpty ? proto.country : null,
    );
  }
}
