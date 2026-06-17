import 'package:equatable/equatable.dart';

enum SupplierStatus { active, inactive }

class SupplierEntity extends Equatable {
  final String id;
  final String businessId;
  final String name;
  final String contactName;
  final String email;
  final String phone;
  final String address;
  final SupplierStatus status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SupplierEntity({
    required this.id,
    required this.businessId,
    required this.name,
    required this.contactName,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  String get statusDisplay =>
      status == SupplierStatus.active ? 'Active' : 'Inactive';

  String get initials => name.isNotEmpty
      ? name
          .split(' ')
          .where((w) => w.isNotEmpty)
          .map((w) => w[0])
          .take(2)
          .join()
          .toUpperCase()
      : '?';

  @override
  List<Object?> get props => [id, name, status];
}
