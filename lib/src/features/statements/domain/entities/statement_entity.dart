import 'package:equatable/equatable.dart';

enum StatementFormat {
  pdf,
  csv,
  excel,
}

class StatementEntity extends Equatable {
  final String accountId;
  final DateTime startDate;
  final DateTime endDate;
  final StatementFormat format;
  final String? filePath;
  final bool success;
  final String message;

  const StatementEntity({
    required this.accountId,
    required this.startDate,
    required this.endDate,
    required this.format,
    this.filePath,
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => [
        accountId,
        startDate,
        endDate,
        format,
        filePath,
        success,
        message,
      ];
}

class StatementDownloadRequest extends Equatable {
  final String accountId;
  final DateTime startDate;
  final DateTime endDate;
  final StatementFormat format;

  const StatementDownloadRequest({
    required this.accountId,
    required this.startDate,
    required this.endDate,
    required this.format,
  });

  @override
  List<Object?> get props => [accountId, startDate, endDate, format];
}
