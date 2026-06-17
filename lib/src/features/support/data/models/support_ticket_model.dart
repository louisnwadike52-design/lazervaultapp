import 'package:lazervault/src/features/support/domain/entities/support_ticket.dart';
import 'package:lazervault/src/generated/support.pb.dart' as support_pb;

class SupportTicketModel extends SupportTicket {
  const SupportTicketModel({
    required super.id,
    required super.userId,
    required super.ticketNumber,
    required super.category,
    required super.subject,
    required super.description,
    required super.status,
    required super.priority,
    required super.createdAt,
    required super.updatedAt,
    super.resolvedAt,
    super.replies,
  });

  factory SupportTicketModel.fromProto(support_pb.SupportTicket proto) {
    return SupportTicketModel(
      id: proto.id,
      userId: proto.userId,
      ticketNumber: proto.ticketNumber,
      category: _mapProtoToCategory(proto.category),
      subject: proto.subject,
      description: proto.description,
      status: _mapProtoToStatus(proto.status),
      priority: _mapProtoToPriority(proto.priority),
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
      resolvedAt: proto.hasResolvedAt() ? proto.resolvedAt.toDateTime() : null,
      replies: proto.replies.map((r) => TicketReplyModel.fromProto(r)).toList(),
    );
  }

  static TicketCategory _mapProtoToCategory(support_pb.TicketCategory category) {
    switch (category) {
      case support_pb.TicketCategory.GENERAL_INQUIRY:
        return TicketCategory.generalInquiry;
      case support_pb.TicketCategory.TRANSACTION_ISSUE:
        return TicketCategory.transactionIssue;
      case support_pb.TicketCategory.ACCOUNT_PROBLEM:
        return TicketCategory.accountProblem;
      case support_pb.TicketCategory.TECHNICAL_SUPPORT:
        return TicketCategory.technicalSupport;
      case support_pb.TicketCategory.SECURITY_CONCERN:
        return TicketCategory.securityConcern;
      case support_pb.TicketCategory.OTHER:
      default:
        return TicketCategory.other;
    }
  }

  static support_pb.TicketCategory _mapCategoryToProto(TicketCategory category) {
    switch (category) {
      case TicketCategory.generalInquiry:
        return support_pb.TicketCategory.GENERAL_INQUIRY;
      case TicketCategory.transactionIssue:
        return support_pb.TicketCategory.TRANSACTION_ISSUE;
      case TicketCategory.accountProblem:
        return support_pb.TicketCategory.ACCOUNT_PROBLEM;
      case TicketCategory.technicalSupport:
        return support_pb.TicketCategory.TECHNICAL_SUPPORT;
      case TicketCategory.securityConcern:
        return support_pb.TicketCategory.SECURITY_CONCERN;
      case TicketCategory.other:
        return support_pb.TicketCategory.OTHER;
    }
  }

  static TicketStatus _mapProtoToStatus(support_pb.TicketStatus status) {
    switch (status) {
      case support_pb.TicketStatus.OPEN:
        return TicketStatus.open;
      case support_pb.TicketStatus.IN_PROGRESS:
        return TicketStatus.inProgress;
      case support_pb.TicketStatus.WAITING_FOR_CUSTOMER:
        return TicketStatus.waitingForCustomer;
      case support_pb.TicketStatus.RESOLVED:
        return TicketStatus.resolved;
      case support_pb.TicketStatus.CLOSED:
        return TicketStatus.closed;
      default:
        return TicketStatus.open;
    }
  }

  static support_pb.TicketStatus _mapStatusToProto(TicketStatus status) {
    switch (status) {
      case TicketStatus.open:
        return support_pb.TicketStatus.OPEN;
      case TicketStatus.inProgress:
        return support_pb.TicketStatus.IN_PROGRESS;
      case TicketStatus.waitingForCustomer:
        return support_pb.TicketStatus.WAITING_FOR_CUSTOMER;
      case TicketStatus.resolved:
        return support_pb.TicketStatus.RESOLVED;
      case TicketStatus.closed:
        return support_pb.TicketStatus.CLOSED;
    }
  }

  static TicketPriority _mapProtoToPriority(support_pb.TicketPriority priority) {
    switch (priority) {
      case support_pb.TicketPriority.LOW:
        return TicketPriority.low;
      case support_pb.TicketPriority.MEDIUM:
        return TicketPriority.medium;
      case support_pb.TicketPriority.HIGH:
        return TicketPriority.high;
      case support_pb.TicketPriority.URGENT:
        return TicketPriority.urgent;
      default:
        return TicketPriority.medium;
    }
  }

}

class TicketReplyModel extends TicketReply {
  const TicketReplyModel({
    required super.id,
    required super.ticketId,
    required super.userId,
    required super.message,
    required super.isStaff,
    required super.createdAt,
  });

  factory TicketReplyModel.fromProto(support_pb.TicketReply proto) {
    return TicketReplyModel(
      id: proto.id,
      ticketId: proto.ticketId,
      userId: proto.userId,
      message: proto.message,
      isStaff: proto.isStaff,
      createdAt: proto.createdAt.toDateTime(),
    );
  }
}

class ContactMessageModel extends ContactMessage {
  const ContactMessageModel({
    required super.id,
    required super.name,
    required super.email,
    required super.topic,
    required super.subject,
    required super.message,
    super.userId,
    required super.createdAt,
    required super.isRead,
  });

  factory ContactMessageModel.fromProto(support_pb.ContactMessage proto) {
    return ContactMessageModel(
      id: proto.id,
      name: proto.name,
      email: proto.email,
      topic: proto.topic,
      subject: proto.subject,
      message: proto.message,
      userId: proto.userId != 0 ? proto.userId : null,
      createdAt: proto.createdAt.toDateTime(),
      isRead: proto.isRead,
    );
  }
}

// Export helper functions for use in repository
support_pb.TicketCategory mapCategoryToProto(TicketCategory category) {
  return SupportTicketModel._mapCategoryToProto(category);
}

support_pb.TicketStatus mapStatusToProto(TicketStatus status) {
  return SupportTicketModel._mapStatusToProto(status);
}
