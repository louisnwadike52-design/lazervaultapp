import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/support/domain/entities/support_ticket.dart';

abstract class ISupportRepository {
  // Support Tickets
  Future<Either<Failure, SupportTicket>> createSupportTicket({
    required TicketCategory category,
    required String subject,
    required String description,
  });

  Future<Either<Failure, List<SupportTicket>>> getSupportTickets({
    int page = 1,
    int pageSize = 20,
    TicketStatus? statusFilter,
  });

  Future<Either<Failure, SupportTicket>> getSupportTicket(String ticketId);

  Future<Either<Failure, SupportTicket>> updateTicketStatus({
    required String ticketId,
    required TicketStatus status,
  });

  Future<Either<Failure, TicketReply>> addTicketReply({
    required String ticketId,
    required String message,
  });

  // Contact Form
  Future<Either<Failure, ContactMessage>> submitContactForm({
    required String name,
    required String email,
    required String topic,
    required String subject,
    required String message,
  });
}
