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
      {required String accessToken, String? countryCode, String? currency, bool? favoritesOnly}) async {
    try {
      final request = grpc.ListRecipientsRequest();
      if (countryCode != null) {
        request.countryCode = countryCode;
      }
      if (currency != null) {
        request.currency = currency;
      }
      if (favoritesOnly != null) {
        request.favoritesOnly = favoritesOnly;
      }

      final response = await _client.listRecipients(
        request,
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
      {required String recipientId, required bool isFavorite, required String accessToken}) async {
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

  @override
  Future<Either<Failure, RecipientModel>> updateAlias(
      {required String recipientId, required String? alias, required String accessToken}) async {
    try {
      final request = grpc.UpdateRecipientRequest()
        ..recipientId = Int64.parseInt(recipientId);

      final response = await _client.updateRecipient(
        request,
        options: _getAuthOptions(accessToken),
      );
      return Right(RecipientModel.fromProto(response.recipient));
    } catch (e) {
      return Left(
          Failure(message: 'Failed to update alias: $e', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecipient(
      {required String recipientId, required String accessToken}) async {
    try {
      final request = grpc.DeleteRecipientRequest()
        ..recipientId = Int64.parseInt(recipientId);

      await _client.deleteRecipient(
        request,
        options: _getAuthOptions(accessToken),
      );
      return Right(null);
    } catch (e) {
      return Left(
          Failure(message: 'Failed to delete recipient: $e', statusCode: 500));
    }
  }
} 