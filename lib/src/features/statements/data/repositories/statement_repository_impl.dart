import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart' show CallOptions;
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/domain/repositories/i_statement_repository.dart';
import 'package:lazervault/src/features/statements/data/models/statement_model.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;

/// gRPC implementation of [IStatementRepository].
///
/// Mirrors the working `AccountActionsRepositoryImpl.downloadAccountStatement`
/// pattern: calls accounts-service `GenerateStatement` (via Core Gateway) and
/// returns the real `downloadUrl` (carried in [StatementEntity.filePath]) plus
/// the backend `sha256` so the file can be fetched and integrity-checked.
class StatementRepositoryImpl implements IStatementRepository {
  final accounts_pb.AccountsServiceClient _accountsClient;
  final SecureStorageService _secureStorage;

  StatementRepositoryImpl({
    required accounts_pb.AccountsServiceClient accountsClient,
    required SecureStorageService secureStorage,
  })  : _accountsClient = accountsClient,
        _secureStorage = secureStorage;

  @override
  Future<Either<Failure, StatementEntity>> downloadStatement({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    required StatementFormat format,
  }) async {
    try {
      final token = await _secureStorage.getAccessToken();

      final request = accounts_pb.GenerateStatementRequest(
        accountId: accountId,
        startDate: Int64(startDate.millisecondsSinceEpoch ~/ 1000),
        endDate: Int64(endDate.millisecondsSinceEpoch ~/ 1000),
        // Backend renders PDF or CSV; anything that isn't PDF falls back to CSV
        // (the only non-PDF format the service produces).
        format: format == StatementFormat.pdf ? 'PDF' : 'CSV',
      );

      final response = await _accountsClient.generateStatement(
        request,
        options: _getCallOptions(token),
      );

      // Honour what the backend actually rendered — never lie about the
      // extension; the user may have asked for PDF and received CSV.
      final renderedFormat = _formatFromBackend(response.format, format);

      return Right(StatementModel(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
        format: renderedFormat,
        // The downloadUrl lives in filePath until the file is pulled to disk.
        filePath: response.downloadUrl,
        success: true,
        message: response.message.isNotEmpty
            ? response.message
            : 'Statement generated successfully',
        sha256: response.sha256.isEmpty ? null : response.sha256,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: friendlyError(e, context: 'generate your statement'),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<StatementEntity>>> getStatementHistory({
    required String accountId,
    int? limit,
  }) async {
    // No statement-history RPC exists yet. Return an empty list so the UI
    // shows "No previous statements" rather than fabricating mock rows.
    return const Right(<StatementEntity>[]);
  }

  StatementFormat _formatFromBackend(
    String backendFormat,
    StatementFormat requested,
  ) {
    switch (backendFormat.toUpperCase()) {
      case 'PDF':
        return StatementFormat.pdf;
      case 'CSV':
        return StatementFormat.csv;
      case 'EXCEL':
      case 'XLSX':
        return StatementFormat.excel;
      default:
        return requested;
    }
  }

  /// Get call options with authorization metadata.
  CallOptions _getCallOptions(String? token) {
    if (token != null && token.isNotEmpty) {
      return CallOptions(metadata: {
        'authorization': 'Bearer $token',
      });
    }
    return CallOptions();
  }
}
