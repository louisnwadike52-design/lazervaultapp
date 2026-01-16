import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';
import 'package:lazervault/src/generated/recipient.pbgrpc.dart' as grpc;

class RecipientRepositoryImpl implements IRecipientRepository {
  final grpc.RecipientServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  RecipientRepositoryImpl(
    this._client,
    this._callOptionsHelper,
  );

  @override
  Future<Either<Failure, List<RecipientModel>>> getRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
  }) async {
    try {
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
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

        return await _client.listRecipients(
          request,
          options: callOptions,
        );
      });

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
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = grpc.CreateRecipientRequest()
          ..name = recipient.name
          ..accountNumber = recipient.accountNumber
          ..bankName = recipient.bankName
          ..sortCode = recipient.sortCode
          ..isFavorite = recipient.isFavorite
          ..type = 'external'; // Default to external recipient

        if (recipient.countryCode != null) {
          request.countryCode = recipient.countryCode!;
        }
        if (recipient.email != null) {
          request.email = recipient.email!;
        }
        if (recipient.phoneNumber != null) {
          request.phoneNumber = recipient.phoneNumber!;
        }
        if (recipient.currency != null) {
          request.currency = recipient.currency!;
        }
        if (recipient.swiftCode != null) {
          request.swiftCode = recipient.swiftCode!;
        }
        if (recipient.iban != null) {
          request.iban = recipient.iban!;
        }

        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.createRecipient(
          request,
          options: callOptions,
        );
      });

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
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = grpc.UpdateRecipientRequest()
          ..recipientId = Int64.parseInt(recipientId);

        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.updateRecipient(
          request,
          options: callOptions,
        );
      });

      return Right(null);
    } catch (e) {
      return Left(
          Failure(message: 'Failed to toggle favorite: $e', statusCode: 500));
    }
  }
} 