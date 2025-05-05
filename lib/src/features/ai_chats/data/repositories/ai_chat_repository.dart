import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';
import 'package:lazervault/src/generated/recipient.pbgrpc.dart' as grpc;

class RecipientRepositoryImpl implements IRecipientRepository {
  final grpc.RecipientServiceClient _client;

  RecipientRepositoryImpl(this._client);

  CallOptions _getAuthOptions(String accessToken) =>
      CallOptions(metadata: {'authorization': 'Bearer $accessToken'});

  @override
  Future<Either<Failure, List<RecipientModel>>> getRecipients(
      {required String accessToken}) async {
    try {
      final response = await _client.listRecipients(
        grpc.ListRecipientsRequest(),
        options: _getAuthOptions(accessToken),
      );
      return Right(response.recipients.map(RecipientModel.fromProto).toList());
    } catch (e) {
      return Left(
          Failure(message: 'Failed to get recipients: $e', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, RecipientModel>> addRecipient(
      {required RecipientModel recipient, required String accessToken}) async {
    try {
      final request = grpc.CreateRecipientRequest()
        ..name = recipient.name
        ..accountNumber = recipient.accountNumber
        ..bankName = recipient.bankName
        ..sortCode = recipient.sortCode
        ..isFavorite = recipient.isFavorite;

      final response = await _client.createRecipient(
        request,
        options: _getAuthOptions(accessToken),
      );
      return Right(RecipientModel.fromProto(response.recipient));
    } catch (e) {
      return Left(
          Failure(message: 'Failed to add recipient: $e', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(
      {required String recipientId, required String accessToken}) async {
    try {
      final request = grpc.UpdateRecipientRequest()
        ..recipientId = Int64.parseInt(recipientId);

      await _client.updateRecipient(
        request,
        options: _getAuthOptions(accessToken),
      );
      return Right(null);
    } catch (e) {
      return Left(
          Failure(message: 'Failed to toggle favorite: $e', statusCode: 500));
    }
  }
} 