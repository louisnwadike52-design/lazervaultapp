import 'dart:typed_data';
import '../../../../core/network/grpc_client.dart';
import '../../../../core/network/retry_helper.dart';
import '../../../../generated/invoice.pb.dart' as pb;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';

import '../../domain/entities/invoice_entity.dart';
import '../../domain/entities/invoice_fee_quote.dart';
import '../../domain/repositories/invoice_repository.dart';

/// gRPC-based implementation of InvoiceRepository
/// This implementation communicates with the backend gRPC service for invoice operations.
/// For methods not yet supported by the backend, UnimplementedError is thrown.
class InvoiceRepositoryGrpcImpl implements InvoiceRepository {
  final GrpcClient grpcClient;
  final String currentUserId; // Current authenticated user ID

  /// yyyy-MM-dd (the backend's primary due-date layout).
  static String _dateOnly(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  InvoiceRepositoryGrpcImpl({
    required this.grpcClient,
    required this.currentUserId,
  });

  @override
  Future<List<Invoice>> getAllInvoices() async {
    if (!serviceLocator<AccountManager>().hasActiveAccount) {
      throw Exception('Select a business account first');
    }
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoicesRequest()
          ..accountId = serviceLocator<AccountManager>().activeAccountId ?? ''
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
  Future<Invoice> createInvoice(Invoice invoice, {String? serviceFeeRef}) async {
    if (!serviceLocator<AccountManager>().hasActiveAccount) {
      throw Exception('Select a business account first');
    }
    return retryWithBackoff(
      operation: () async {
        // Default the invoice currency to the active locale's currency when the
        // entity didn't carry one, so an invoice always has an explicit currency.
        final resolvedCurrency = invoice.currency.isNotEmpty
            ? invoice.currency
            : serviceLocator<LocaleManager>().currentCurrency;
        // Canonical party blocks. In this entity `recipientDetails` is the
        // creator/issuer ("Invoice From") and `payerDetails` is the customer
        // ("Bill To"); map them to the proto's sender/receiver so the details
        // page reflects exactly what was entered. Legacy flat fields are kept
        // populated for back-compat (recipient_* = the customer the backend
        // sends to). recipientLogoUrl = sender logo, payerLogoUrl = customer.
        final sender = _toParty(invoice.recipientDetails,
            logoUrl: invoice.recipientLogoUrl);
        final receiver = _toParty(invoice.payerDetails,
            logoUrl: invoice.payerLogoUrl,
            fallbackName: invoice.toName,
            fallbackEmail: invoice.toEmail);

        final request = pb.CreateInvoiceRequest()
          ..accountId = serviceLocator<AccountManager>().activeAccountId ?? ''
          ..recipientEmail = invoice.toEmail ?? invoice.payerDetails?.email ?? ''
          ..recipientName = invoice.toName ?? invoice.payerDetails?.contactName ?? ''
          ..description = invoice.description
          ..amount = invoice.amount
          // Date-only, matching the backend's primary layout (it also accepts
          // RFC3339 now, but full ISO used to fail its parse and silently
          // replace every user-chosen due date with +30d).
          ..dueDate = _dateOnly(invoice.dueDate ?? DateTime.now().add(const Duration(days: 30)))
          ..tax = invoice.taxAmount ?? 0.0
          ..discount = invoice.discountAmount ?? 0.0
          ..notes = invoice.notes ?? ''
          ..payerEmail = invoice.payerDetails?.email ?? invoice.toEmail ?? ''
          ..currency = resolvedCurrency
          ..payerLogoUrl = invoice.payerLogoUrl ?? ''
          ..recipientLogoUrl = invoice.recipientLogoUrl ?? ''
          // Persist the chosen document type + title so the details page
          // reflects them on reload (enum name == backend string).
          ..invoiceType = invoice.type.name
          ..title = invoice.title;
        if (sender != null) request.sender = sender;
        if (receiver != null) request.receiver = receiver;

        // Split payment: tag the payers and (for a custom split) send each one's
        // amount. Tagged users with shareAmount <= 0 are split equally by the
        // backend, so an equal split sends ids only and the shares are exact.
        final taggedPayers = invoice.taggedUsers ?? const <TaggedUserInfo>[];
        if (taggedPayers.isNotEmpty) {
          request.taggedUserIds.addAll(taggedPayers.map((t) => t.userId));
          request.taggedShares.addAll(taggedPayers
              .where((t) => t.shareAmount > 0)
              .map((t) => pb.TaggedShare()
                ..userId = t.userId
                ..amount = t.shareAmount));
        }

        // Add invoice items. The proto has ONE description field: encode
        // "name: description", or just the name when there's no description —
        // never a dangling "name: ". _fromProto splits on the first colon.
        if (invoice.items.isNotEmpty) {
          request.items.addAll(invoice.items.map((item) {
            final desc = item.description?.trim() ?? '';
            return pb.InvoiceItem()
              ..description =
                  desc.isNotEmpty ? '${item.name}: $desc' : item.name
              ..quantity = item.quantity.toInt()
              ..unitPrice = item.unitPrice
              ..total = item.totalPrice;
          }));
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
  Future<void> sendInvoiceToEmail(String invoiceId, String email) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.SendInvoiceToEmailRequest()
          ..invoiceId = invoiceId
          ..email = email
          ..locale = 'en-US';
        final options = await grpcClient.callOptions;
        await grpcClient.invoiceClient.sendInvoiceToEmail(
          request,
          options: options,
        );
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
    if (!serviceLocator<AccountManager>().hasActiveAccount) {
      throw Exception('Select a business account first');
    }
    return retryWithBackoff(
      operation: () async {
        // Get invoices and filter by status (using status string field)
        final request = pb.GetInvoicesRequest()
          ..accountId = serviceLocator<AccountManager>().activeAccountId ?? ''
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
        // UpdateInvoice is a PARTIAL update: the backend only overwrites a
        // field when it arrives non-empty, so anything omitted here silently
        // keeps its old value. That is why recipient, tax, discount and the
        // logos are all sent — leaving them out was why an edit could only
        // ever change the description, amount and notes.
        final request = pb.UpdateInvoiceRequest()
          ..invoiceId = invoice.id
          ..description = invoice.description
          ..amount = invoice.amount
          ..tax = invoice.taxAmount ?? 0
          ..discount = invoice.discountAmount ?? 0
          ..notes = invoice.notes ?? ''
          ..recipientEmail = invoice.toEmail ?? ''
          ..recipientName = invoice.toName ?? ''
          // Empty means "leave as is", so a user who edits without touching
          // the logos keeps the ones already on the invoice.
          ..payerLogoUrl = invoice.payerLogoUrl ?? ''
          ..recipientLogoUrl = invoice.recipientLogoUrl ?? '';

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
          ..accountId = serviceLocator<AccountManager>().activeAccountId ?? '';

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
          ..accountId = accountId ?? serviceLocator<AccountManager>().activeAccountId ?? '';

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
  Future<InvoiceFeeQuote> getServiceFeeQuote({String? accountId}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvoiceServiceFeeRequest()
          ..accountId = accountId ?? serviceLocator<AccountManager>().activeAccountId ?? '';

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.getInvoiceServiceFee(
          request,
          options: options,
        );

        return InvoiceFeeQuote(
          amount: response.feeAmount,
          currency: response.currency,
          enabled: response.enabled,
        );
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
  Future<void> sendInvoiceReminder(String invoiceId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.SendInvoiceReminderRequest()..invoiceId = invoiceId;
        final options = await grpcClient.callOptions;
        await grpcClient.invoiceClient.sendInvoiceReminder(
          request,
          options: options,
        );
      },
    );
  }

  @override
  Future<Invoice> respondToQuote(String invoiceId, String action) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.RespondToQuoteRequest()
          ..invoiceId = invoiceId
          ..action = action;
        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.respondToQuote(
          request,
          options: options,
        );
        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<Invoice> convertQuoteToInvoice(String invoiceId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.ConvertQuoteToInvoiceRequest()..invoiceId = invoiceId;
        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.convertQuoteToInvoice(
          request,
          options: options,
        );
        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<TagUsersResponse> tagUsersToInvoice(String invoiceId, List<String> userIds, List<String> emails, List<String> phoneNumbers) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.TagUsersToInvoiceRequest()
          ..invoiceId = invoiceId;
        request.userIds.addAll(userIds);
        request.emails.addAll(emails);
        request.phones.addAll(phoneNumbers);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.invoiceClient.tagUsersToInvoice(
          request,
          options: options,
        );

        // Report what the backend actually did — never echo the request back
        // as if it succeeded.
        return TagUsersResponse(
          success: response.usersTagged > 0 || response.invitesSent > 0,
          taggedUserIds: userIds,
          usersTagged: response.usersTagged,
          invitedEmails: response.invitedEmails.toList(),
          invitedPhones: response.invitedPhones.toList(),
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
      // The proto carries ONE description string; creation encodes it as
      // "name: description" (or just the name). Split it back so the UI never
      // renders "Widget A" / "Widget A: a blue widget" twice.
      items = proto.items.map((item) {
        final raw = item.description;
        final colon = raw.indexOf(':');
        final name = colon > 0
            ? raw.substring(0, colon).trim()
            : _extractNameFromDescription(raw);
        final desc = colon > 0 ? raw.substring(colon + 1).trim() : '';
        return InvoiceItem(
          id: 'item_${DateTime.now().millisecondsSinceEpoch}',
          name: name,
          description: desc.isNotEmpty ? desc : null,
          quantity: item.quantity.toDouble(),
          unitPrice: item.unitPrice,
          totalPrice: item.total,
          category: null,
        );
      }).toList();
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
      // The human-facing INV-xxxxx — matches emails/notifications/receipts.
      invoiceNumber: proto.invoiceNumber,
      // Preserve the title chosen at creation; fall back to description, then a
      // generic label, so the details page no longer shows a defaulted title.
      title: proto.title.isNotEmpty
          ? proto.title
          : (proto.description.isNotEmpty ? proto.description : 'Invoice'),
      description: proto.description.isNotEmpty ? proto.description : '',
      amount: proto.amount,
      currency: proto.currency.isNotEmpty ? proto.currency : 'USD',
      status: _deriveStatusWithPartiallyPaid(status, proto.taggedUsers),
      // Preserve the chosen document type (invoice/request/quote) on reload.
      type: _invoiceTypeFromString(proto.invoiceType),
      quoteStatus: proto.quoteStatus,
      quoteAcceptedAt: proto.quoteAcceptedAt.isNotEmpty ? DateTime.tryParse(proto.quoteAcceptedAt) : null,
      quoteDeclinedAt: proto.quoteDeclinedAt.isNotEmpty ? DateTime.tryParse(proto.quoteDeclinedAt) : null,
      convertedAt: proto.convertedAt.isNotEmpty ? DateTime.tryParse(proto.convertedAt) : null,
      createdAt: (proto.createdAt.isNotEmpty ? DateTime.tryParse(proto.createdAt) : null) ?? DateTime.now(),
      dueDate: proto.dueDate.isNotEmpty ? DateTime.tryParse(proto.dueDate) : null,
      paidAt: proto.paidAt.isNotEmpty ? DateTime.tryParse(proto.paidAt) : null,
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
      // recipientDetails = the SENDER/issuer ("Invoice From"). Prefer the
      // structured sender block; fall back to the creator's resolved name so a
      // received invoice still shows who sent it.
      recipientDetails: proto.hasSender()
          ? _partyToAddress(proto.sender)
          : ((proto.creatorFirstName.isNotEmpty || proto.creatorLastName.isNotEmpty)
              ? AddressDetails(
                  contactName:
                      '${proto.creatorFirstName} ${proto.creatorLastName}'.trim(),
                )
              : null),
      // payerDetails = the RECEIVER/customer ("Bill To"). Prefer the structured
      // receiver block; fall back to the legacy recipient_* (customer) fields.
      payerDetails: proto.hasReceiver()
          ? _partyToAddress(proto.receiver)
          : ((proto.recipientName.isNotEmpty || proto.recipientEmail.isNotEmpty)
              ? AddressDetails(
                  contactName: proto.recipientName.isNotEmpty ? proto.recipientName : null,
                  email: proto.recipientEmail.isNotEmpty
                      ? proto.recipientEmail
                      : (proto.payerEmail.isNotEmpty ? proto.payerEmail : null),
                )
              : null),
      // Logos: sender block's logo for "From", receiver block's for "Bill To",
      // each falling back to the legacy column.
      payerLogoUrl: (proto.hasReceiver() && proto.receiver.logoUrl.isNotEmpty)
          ? proto.receiver.logoUrl
          : (proto.payerLogoUrl.isNotEmpty ? proto.payerLogoUrl : null),
      recipientLogoUrl: (proto.hasSender() && proto.sender.logoUrl.isNotEmpty)
          ? proto.sender.logoUrl
          : (proto.recipientLogoUrl.isNotEmpty ? proto.recipientLogoUrl : null),
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
              shareAmount: tu.shareAmount,
              amountPaid: tu.amountPaid,
            )).toList()
          : null,
    );
  }

  // Build a proto InvoiceParty from an AddressDetails block + logo. Returns
  // null when there's nothing meaningful to send (so the request omits it).
  pb.InvoiceParty? _toParty(
    AddressDetails? d, {
    String? logoUrl,
    String? fallbackName,
    String? fallbackEmail,
  }) {
    final businessName = d?.companyName ?? '';
    final contactName = d?.contactName ?? fallbackName ?? '';
    final email = d?.email ?? fallbackEmail ?? '';
    final phone = d?.phone ?? '';
    final logo = logoUrl ?? '';
    final hasAny = [
      businessName, contactName, email, phone, logo,
      d?.addressLine1 ?? '', d?.city ?? '', d?.country ?? '',
    ].any((v) => v.trim().isNotEmpty);
    if (!hasAny) return null;
    return pb.InvoiceParty()
      ..businessName = businessName
      ..contactName = contactName
      ..email = email
      ..phone = phone
      ..addressLine1 = d?.addressLine1 ?? ''
      ..addressLine2 = d?.addressLine2 ?? ''
      ..city = d?.city ?? ''
      ..state = d?.state ?? ''
      ..postcode = d?.postcode ?? ''
      ..country = d?.country ?? ''
      ..logoUrl = logo;
  }

  // Map the backend document-type string back to the enum (default: invoice).
  InvoiceType _invoiceTypeFromString(String t) {
    switch (t.toLowerCase().trim()) {
      case 'request':
        return InvoiceType.request;
      case 'quote':
        return InvoiceType.quote;
      default:
        return InvoiceType.invoice;
    }
  }

  // Map a proto InvoiceParty back to an AddressDetails for the UI.
  AddressDetails _partyToAddress(pb.InvoiceParty p) {
    String? nz(String s) => s.isNotEmpty ? s : null;
    return AddressDetails(
      companyName: nz(p.businessName),
      contactName: nz(p.contactName),
      email: nz(p.email),
      phone: nz(p.phone),
      addressLine1: nz(p.addressLine1),
      addressLine2: nz(p.addressLine2),
      city: nz(p.city),
      state: nz(p.state),
      postcode: nz(p.postcode),
      country: nz(p.country),
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
