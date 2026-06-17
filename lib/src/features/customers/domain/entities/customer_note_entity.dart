import 'package:equatable/equatable.dart';

class CustomerNoteEntity extends Equatable {
  final String id;
  final String customerId;
  final String businessId;
  final String content;
  final String createdBy;
  final DateTime createdAt;

  const CustomerNoteEntity({
    required this.id,
    required this.customerId,
    required this.businessId,
    required this.content,
    required this.createdBy,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, customerId, content, createdBy];
}
