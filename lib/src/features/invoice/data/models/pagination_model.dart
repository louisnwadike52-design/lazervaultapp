import 'invoice_model.dart';

class PaginationModel {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  const PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory PaginationModel.fromData({
    required int page,
    required int limit,
    required int total,
  }) {
    final totalPages = (total / limit).ceil();
    return PaginationModel(
      page: page,
      limit: limit,
      total: total,
      totalPages: totalPages,
      hasNext: page < totalPages,
      hasPrevious: page > 1,
    );
  }

  PaginationModel copyWith({
    int? page,
    int? limit,
    int? total,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  }) {
    return PaginationModel(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      hasNext: hasNext ?? this.hasNext,
      hasPrevious: hasPrevious ?? this.hasPrevious,
    );
  }
}

class InvoiceSearchFilter {
  final String? query;
  final List<String>? statuses;
  final List<String>? types;
  final DateTime? fromDate;
  final DateTime? toDate;
  final double? minAmount;
  final double? maxAmount;
  final String? currency;
  final bool? isOverdue;
  final String? sortBy;
  final SortOrder sortOrder;

  const InvoiceSearchFilter({
    this.query,
    this.statuses,
    this.types,
    this.fromDate,
    this.toDate,
    this.minAmount,
    this.maxAmount,
    this.currency,
    this.isOverdue,
    this.sortBy,
    this.sortOrder = SortOrder.desc,
  });

  InvoiceSearchFilter copyWith({
    String? query,
    List<String>? statuses,
    List<String>? types,
    DateTime? fromDate,
    DateTime? toDate,
    double? minAmount,
    double? maxAmount,
    String? currency,
    bool? isOverdue,
    String? sortBy,
    SortOrder? sortOrder,
  }) {
    return InvoiceSearchFilter(
      query: query ?? this.query,
      statuses: statuses ?? this.statuses,
      types: types ?? this.types,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      currency: currency ?? this.currency,
      isOverdue: isOverdue ?? this.isOverdue,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  bool get hasFilters {
    return query?.isNotEmpty == true ||
        statuses?.isNotEmpty == true ||
        types?.isNotEmpty == true ||
        fromDate != null ||
        toDate != null ||
        minAmount != null ||
        maxAmount != null ||
        currency?.isNotEmpty == true ||
        isOverdue != null;
  }

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'statuses': statuses,
      'types': types,
      'from_date': fromDate?.toIso8601String(),
      'to_date': toDate?.toIso8601String(),
      'min_amount': minAmount,
      'max_amount': maxAmount,
      'currency': currency,
      'is_overdue': isOverdue,
      'sort_by': sortBy,
      'sort_order': sortOrder.name,
    };
  }
}

enum SortOrder {
  asc,
  desc,
}

class PaginatedInvoiceResult {
  final List<InvoiceModel> invoices;
  final PaginationModel pagination;
  final InvoiceSearchFilter? filter;

  const PaginatedInvoiceResult({
    required this.invoices,
    required this.pagination,
    this.filter,
  });

  PaginatedInvoiceResult copyWith({
    List<InvoiceModel>? invoices,
    PaginationModel? pagination,
    InvoiceSearchFilter? filter,
  }) {
    return PaginatedInvoiceResult(
      invoices: invoices ?? this.invoices,
      pagination: pagination ?? this.pagination,
      filter: filter ?? this.filter,
    );
  }
} 