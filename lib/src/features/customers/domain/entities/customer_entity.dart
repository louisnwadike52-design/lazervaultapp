import 'dart:ui';

import 'package:equatable/equatable.dart';

class CustomersPageResult {
  final List<CustomerEntity> items;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  const CustomersPageResult({
    required this.items,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });
}

enum CustomerSegment { none, vip, retail, wholesale, government, overdue }

enum CustomerStatus { active, inactive, blocked }

class CustomerEntity extends Equatable {
  final String id;
  final String businessId;
  final String name;
  final String businessName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String country;
  final String tin;
  final String bankAccountNumber;
  final String bankCode;
  final String bankName;
  final CustomerSegment segment;
  final CustomerStatus status;
  final List<String> tags;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CustomerEntity({
    required this.id,
    required this.businessId,
    required this.name,
    required this.businessName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.tin,
    required this.bankAccountNumber,
    required this.bankCode,
    required this.bankName,
    required this.segment,
    required this.status,
    required this.tags,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  String get segmentDisplay {
    switch (segment) {
      case CustomerSegment.none:
        return 'None';
      case CustomerSegment.vip:
        return 'VIP';
      case CustomerSegment.retail:
        return 'Retail';
      case CustomerSegment.wholesale:
        return 'Wholesale';
      case CustomerSegment.government:
        return 'Government';
      case CustomerSegment.overdue:
        return 'Overdue';
    }
  }

  String get statusDisplay {
    switch (status) {
      case CustomerStatus.active:
        return 'Active';
      case CustomerStatus.inactive:
        return 'Inactive';
      case CustomerStatus.blocked:
        return 'Blocked';
    }
  }

  Color get statusColor {
    switch (status) {
      case CustomerStatus.active:
        return const Color(0xFF10B981);
      case CustomerStatus.inactive:
        return const Color(0xFF9CA3AF);
      case CustomerStatus.blocked:
        return const Color(0xFFEF4444);
    }
  }

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  List<Object?> get props => [id, name, email, segment, status];
}
