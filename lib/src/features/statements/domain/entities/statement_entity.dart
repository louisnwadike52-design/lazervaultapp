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

  /// For a freshly downloaded statement this carries the backend
  /// `downloadUrl` (a signed URL to fetch the rendered file from). Once the
  /// file has been pulled to disk it may be replaced with the local path.
  final String? filePath;
  final bool success;
  final String message;

  /// SHA-256 checksum returned by the backend for the rendered file, used to
  /// verify the bytes we download match what the service generated. Null when
  /// the backend did not provide one.
  final String? sha256;

  const StatementEntity({
    required this.accountId,
    required this.startDate,
    required this.endDate,
    required this.format,
    this.filePath,
    required this.success,
    required this.message,
    this.sha256,
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
        sha256,
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
