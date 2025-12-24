import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/domain/repositories/i_statement_repository.dart';
import 'package:lazervault/src/features/statements/data/models/statement_model.dart';

class StatementRepositoryImpl implements IStatementRepository {
  // TODO: Add gRPC client and call options helper when proto is available
  // final StatementServiceClient statementServiceClient;
  // final GrpcCallOptionsHelper callOptionsHelper;

  // const StatementRepositoryImpl({
  //   required this.statementServiceClient,
  //   required this.callOptionsHelper,
  // });

  @override
  Future<Either<Failure, StatementEntity>> downloadStatement({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    required StatementFormat format,
  }) async {
    try {
      // TODO: Replace with actual gRPC call
      // final request = DownloadStatementRequest()
      //   ..accountId = accountId
      //   ..startDate = Int64(startDate.millisecondsSinceEpoch ~/ 1000)
      //   ..endDate = Int64(endDate.millisecondsSinceEpoch ~/ 1000)
      //   ..format = _formatToProto(format);
      //
      // final response = await statementServiceClient.downloadStatement(
      //   request,
      //   options: callOptionsHelper.getCallOptions(),
      // );
      //
      // return Right(StatementModel.fromProto(response));

      // Mock implementation
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful download
      final mockFilePath = '/downloads/statement_${accountId}_${startDate.millisecondsSinceEpoch}.${_formatExtension(format)}';

      return Right(StatementModel(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
        format: format,
        filePath: mockFilePath,
        success: true,
        message: 'Statement downloaded successfully',
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Failed to download statement: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<StatementEntity>>> getStatementHistory({
    required String accountId,
    int? limit,
  }) async {
    try {
      // TODO: Replace with actual gRPC call
      // final request = GetStatementHistoryRequest()
      //   ..accountId = accountId
      //   ..limit = limit ?? 10;
      //
      // final response = await statementServiceClient.getStatementHistory(
      //   request,
      //   options: callOptionsHelper.getCallOptions(),
      // );
      //
      // return Right(response.statements.map((s) => StatementModel.fromProto(s)).toList());

      // Mock implementation
      await Future.delayed(const Duration(seconds: 1));

      final now = DateTime.now();
      final mockStatements = List.generate(
        limit ?? 5,
        (index) {
          final monthsAgo = index;
          final endDate = DateTime(now.year, now.month - monthsAgo, 0);
          final startDate = DateTime(endDate.year, endDate.month, 1);

          return StatementModel(
            accountId: accountId,
            startDate: startDate,
            endDate: endDate,
            format: StatementFormat.pdf,
            filePath: '/downloads/statement_${accountId}_${startDate.millisecondsSinceEpoch}.pdf',
            success: true,
            message: 'Statement for ${_monthName(startDate.month)} ${startDate.year}',
          );
        },
      );

      return Right(mockStatements);
    } catch (e) {
      return Left(ServerFailure(
        message: 'Failed to get statement history: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  String _formatExtension(StatementFormat format) {
    switch (format) {
      case StatementFormat.pdf:
        return 'pdf';
      case StatementFormat.csv:
        return 'csv';
      case StatementFormat.excel:
        return 'xlsx';
    }
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  // TODO: Add proto format conversion when proto is available
  // StatementFormatProto _formatToProto(StatementFormat format) {
  //   switch (format) {
  //     case StatementFormat.pdf:
  //       return StatementFormatProto.PDF;
  //     case StatementFormat.csv:
  //       return StatementFormatProto.CSV;
  //     case StatementFormat.excel:
  //       return StatementFormatProto.EXCEL;
  //   }
  // }
}
