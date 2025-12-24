import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/support/data/models/support_ticket_model.dart';
import 'package:lazervault/src/features/support/domain/entities/support_ticket.dart';
import 'package:lazervault/src/features/support/domain/repositories/i_support_repository.dart';
import 'package:lazervault/src/generated/support.pbgrpc.dart' as support_grpc;
import 'package:lazervault/src/generated/support.pb.dart' as support_pb;

class SupportRepositoryImpl implements ISupportRepository {
  final support_grpc.SupportServiceClient _supportServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  SupportRepositoryImpl({
    required support_grpc.SupportServiceClient supportServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _supportServiceClient = supportServiceClient,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, SupportTicket>> createSupportTicket({
    required TicketCategory category,
    required String subject,
    required String description,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = support_pb.CreateSupportTicketRequest(
        category: mapCategoryToProto(category),
        subject: subject,
        description: description,
      );

      final response = await _supportServiceClient.createSupportTicket(
        request,
        options: callOptions,
      );

      if (response.success && response.hasTicket()) {
        final ticketModel = SupportTicketModel.fromProto(response.ticket);
        return Right(ticketModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to create support ticket',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error creating support ticket: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to create support ticket',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error creating support ticket: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<SupportTicket>>> getSupportTickets({
    int page = 1,
    int pageSize = 20,
    TicketStatus? statusFilter,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = support_pb.GetSupportTicketsRequest(
        page: page,
        pageSize: pageSize,
      );

      if (statusFilter != null) {
        request.statusFilter = mapStatusToProto(statusFilter);
      }

      final response = await _supportServiceClient.getSupportTickets(
        request,
        options: callOptions,
      );

      if (response.success) {
        final tickets = response.tickets
            .map((t) => SupportTicketModel.fromProto(t))
            .toList();
        return Right(tickets);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to retrieve support tickets',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting support tickets: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to retrieve support tickets',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting support tickets: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, SupportTicket>> getSupportTicket(String ticketId) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = support_pb.GetSupportTicketRequest(
        ticketId: ticketId,
      );

      final response = await _supportServiceClient.getSupportTicket(
        request,
        options: callOptions,
      );

      if (response.success && response.hasTicket()) {
        final ticketModel = SupportTicketModel.fromProto(response.ticket);
        return Right(ticketModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to retrieve support ticket',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting support ticket: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to retrieve support ticket',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting support ticket: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, SupportTicket>> updateTicketStatus({
    required String ticketId,
    required TicketStatus status,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = support_pb.UpdateTicketStatusRequest(
        ticketId: ticketId,
        status: mapStatusToProto(status),
      );

      final response = await _supportServiceClient.updateTicketStatus(
        request,
        options: callOptions,
      );

      if (response.success && response.hasTicket()) {
        final ticketModel = SupportTicketModel.fromProto(response.ticket);
        return Right(ticketModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to update ticket status',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error updating ticket status: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update ticket status',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error updating ticket status: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, TicketReply>> addTicketReply({
    required String ticketId,
    required String message,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = support_pb.AddTicketReplyRequest(
        ticketId: ticketId,
        message: message,
      );

      final response = await _supportServiceClient.addTicketReply(
        request,
        options: callOptions,
      );

      if (response.success && response.hasReply()) {
        final replyModel = TicketReplyModel.fromProto(response.reply);
        return Right(replyModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to add ticket reply',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error adding ticket reply: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to add ticket reply',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error adding ticket reply: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ContactMessage>> submitContactForm({
    required String name,
    required String email,
    required String topic,
    required String subject,
    required String message,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = support_pb.SubmitContactFormRequest(
        name: name,
        email: email,
        topic: topic,
        subject: subject,
        message: message,
      );

      final response = await _supportServiceClient.submitContactForm(
        request,
        options: callOptions,
      );

      if (response.success && response.hasContactMessage()) {
        final messageModel = ContactMessageModel.fromProto(response.contactMessage);
        return Right(messageModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to submit contact form',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error submitting contact form: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to submit contact form',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error submitting contact form: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }
}
