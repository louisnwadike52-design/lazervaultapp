import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';

class StatementModel extends StatementEntity {
  const StatementModel({
    required super.accountId,
    required super.startDate,
    required super.endDate,
    required super.format,
    super.filePath,
    required super.success,
    required super.message,
    super.sha256,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) {
    return StatementModel(
      accountId: json['accountId'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      format: _parseFormat(json['format']),
      filePath: json['filePath'],
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      sha256: (json['sha256'] as String?)?.isEmpty ?? true ? null : json['sha256'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'format': _formatToString(format),
      'filePath': filePath,
      'success': success,
      'message': message,
      'sha256': sha256,
    };
  }

  /// Return a copy carrying the local on-disk [filePath] once the file has
  /// been pulled down from the backend [downloadUrl].
  StatementModel withLocalPath(String localPath) {
    return StatementModel(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
      format: format,
      filePath: localPath,
      success: success,
      message: message,
      sha256: sha256,
    );
  }

  static StatementFormat _parseFormat(String? format) {
    switch (format?.toLowerCase()) {
      case 'pdf':
        return StatementFormat.pdf;
      case 'csv':
        return StatementFormat.csv;
      case 'excel':
      case 'xlsx':
        return StatementFormat.excel;
      default:
        return StatementFormat.pdf;
    }
  }

  static String _formatToString(StatementFormat format) {
    switch (format) {
      case StatementFormat.pdf:
        return 'pdf';
      case StatementFormat.csv:
        return 'csv';
      case StatementFormat.excel:
        return 'excel';
    }
  }
}
