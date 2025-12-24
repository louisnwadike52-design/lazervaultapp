import 'package:equatable/equatable.dart';

enum TicketCategory {
  generalInquiry,
  transactionIssue,
  accountProblem,
  technicalSupport,
  securityConcern,
  other,
}

enum TicketStatus {
  open,
  inProgress,
  waitingForCustomer,
  resolved,
  closed,
}

enum TicketPriority {
  low,
  medium,
  high,
  urgent,
}

class SupportTicket extends Equatable {
  final String id;
  final int userId;
  final String ticketNumber;
  final TicketCategory category;
  final String subject;
  final String description;
  final TicketStatus status;
  final TicketPriority priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;
  final List<TicketReply> replies;

  const SupportTicket({
    required this.id,
    required this.userId,
    required this.ticketNumber,
    required this.category,
    required this.subject,
    required this.description,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
    this.replies = const [],
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        ticketNumber,
        category,
        subject,
        description,
        status,
        priority,
        createdAt,
        updatedAt,
        resolvedAt,
        replies,
      ];
}

class TicketReply extends Equatable {
  final String id;
  final String ticketId;
  final int userId;
  final String message;
  final bool isStaff;
  final DateTime createdAt;

  const TicketReply({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.message,
    required this.isStaff,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        ticketId,
        userId,
        message,
        isStaff,
        createdAt,
      ];
}

class ContactMessage extends Equatable {
  final String id;
  final String name;
  final String email;
  final String topic;
  final String subject;
  final String message;
  final int? userId;
  final DateTime createdAt;
  final bool isRead;

  const ContactMessage({
    required this.id,
    required this.name,
    required this.email,
    required this.topic,
    required this.subject,
    required this.message,
    this.userId,
    required this.createdAt,
    required this.isRead,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        topic,
        subject,
        message,
        userId,
        createdAt,
        isRead,
      ];
}
