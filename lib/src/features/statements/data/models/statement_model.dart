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
    };
  }

  // TODO: Add proto conversion when proto definitions are available
  // factory StatementModel.fromProto(StatementProto proto) {
  //   return StatementModel(
  //     accountId: proto.accountId,
  //     startDate: DateTime.fromMillisecondsSinceEpoch(proto.startDate.toInt() * 1000),
  //     endDate: DateTime.fromMillisecondsSinceEpoch(proto.endDate.toInt() * 1000),
  //     format: _parseProtoFormat(proto.format),
  //     filePath: proto.filePath,
  //     success: proto.success,
  //     message: proto.message,
  //   );
  // }

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
