///
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use expenseCategoryDescriptor instead')
const ExpenseCategory$json = const {
  '1': 'ExpenseCategory',
  '2': const [
    const {'1': 'EXPENSE_CATEGORY_UNSPECIFIED', '2': 0},
    const {'1': 'EXPENSE_CATEGORY_FOOD_DINING', '2': 1},
    const {'1': 'EXPENSE_CATEGORY_TRANSPORTATION', '2': 2},
    const {'1': 'EXPENSE_CATEGORY_SHOPPING', '2': 3},
    const {'1': 'EXPENSE_CATEGORY_ENTERTAINMENT', '2': 4},
    const {'1': 'EXPENSE_CATEGORY_BILLS_UTILITIES', '2': 5},
    const {'1': 'EXPENSE_CATEGORY_HEALTHCARE', '2': 6},
    const {'1': 'EXPENSE_CATEGORY_EDUCATION', '2': 7},
    const {'1': 'EXPENSE_CATEGORY_TRAVEL', '2': 8},
    const {'1': 'EXPENSE_CATEGORY_GROCERIES', '2': 9},
    const {'1': 'EXPENSE_CATEGORY_RENT_MORTGAGE', '2': 10},
    const {'1': 'EXPENSE_CATEGORY_INSURANCE', '2': 11},
    const {'1': 'EXPENSE_CATEGORY_INVESTMENTS', '2': 12},
    const {'1': 'EXPENSE_CATEGORY_GIFTS_DONATIONS', '2': 13},
    const {'1': 'EXPENSE_CATEGORY_PERSONAL_CARE', '2': 14},
    const {'1': 'EXPENSE_CATEGORY_SUBSCRIPTIONS', '2': 15},
    const {'1': 'EXPENSE_CATEGORY_OTHER', '2': 16},
  ],
};

/// Descriptor for `ExpenseCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List expenseCategoryDescriptor = $convert.base64Decode('Cg9FeHBlbnNlQ2F0ZWdvcnkSIAocRVhQRU5TRV9DQVRFR09SWV9VTlNQRUNJRklFRBAAEiAKHEVYUEVOU0VfQ0FURUdPUllfRk9PRF9ESU5JTkcQARIjCh9FWFBFTlNFX0NBVEVHT1JZX1RSQU5TUE9SVEFUSU9OEAISHQoZRVhQRU5TRV9DQVRFR09SWV9TSE9QUElORxADEiIKHkVYUEVOU0VfQ0FURUdPUllfRU5URVJUQUlOTUVOVBAEEiQKIEVYUEVOU0VfQ0FURUdPUllfQklMTFNfVVRJTElUSUVTEAUSHwobRVhQRU5TRV9DQVRFR09SWV9IRUFMVEhDQVJFEAYSHgoaRVhQRU5TRV9DQVRFR09SWV9FRFVDQVRJT04QBxIbChdFWFBFTlNFX0NBVEVHT1JZX1RSQVZFTBAIEh4KGkVYUEVOU0VfQ0FURUdPUllfR1JPQ0VSSUVTEAkSIgoeRVhQRU5TRV9DQVRFR09SWV9SRU5UX01PUlRHQUdFEAoSHgoaRVhQRU5TRV9DQVRFR09SWV9JTlNVUkFOQ0UQCxIgChxFWFBFTlNFX0NBVEVHT1JZX0lOVkVTVE1FTlRTEAwSJAogRVhQRU5TRV9DQVRFR09SWV9HSUZUU19ET05BVElPTlMQDRIiCh5FWFBFTlNFX0NBVEVHT1JZX1BFUlNPTkFMX0NBUkUQDhIiCh5FWFBFTlNFX0NBVEVHT1JZX1NVQlNDUklQVElPTlMQDxIaChZFWFBFTlNFX0NBVEVHT1JZX09USEVSEBA=');
@$core.Deprecated('Use budgetPeriodDescriptor instead')
const BudgetPeriod$json = const {
  '1': 'BudgetPeriod',
  '2': const [
    const {'1': 'BUDGET_PERIOD_UNSPECIFIED', '2': 0},
    const {'1': 'BUDGET_PERIOD_DAILY', '2': 1},
    const {'1': 'BUDGET_PERIOD_WEEKLY', '2': 2},
    const {'1': 'BUDGET_PERIOD_MONTHLY', '2': 3},
    const {'1': 'BUDGET_PERIOD_QUARTERLY', '2': 4},
    const {'1': 'BUDGET_PERIOD_YEARLY', '2': 5},
    const {'1': 'BUDGET_PERIOD_CUSTOM', '2': 6},
  ],
};

/// Descriptor for `BudgetPeriod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List budgetPeriodDescriptor = $convert.base64Decode('CgxCdWRnZXRQZXJpb2QSHQoZQlVER0VUX1BFUklPRF9VTlNQRUNJRklFRBAAEhcKE0JVREdFVF9QRVJJT0RfREFJTFkQARIYChRCVURHRVRfUEVSSU9EX1dFRUtMWRACEhkKFUJVREdFVF9QRVJJT0RfTU9OVEhMWRADEhsKF0JVREdFVF9QRVJJT0RfUVVBUlRFUkxZEAQSGAoUQlVER0VUX1BFUklPRF9ZRUFSTFkQBRIYChRCVURHRVRfUEVSSU9EX0NVU1RPTRAG');
@$core.Deprecated('Use budgetStatusDescriptor instead')
const BudgetStatus$json = const {
  '1': 'BudgetStatus',
  '2': const [
    const {'1': 'BUDGET_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'BUDGET_STATUS_ACTIVE', '2': 1},
    const {'1': 'BUDGET_STATUS_EXCEEDED', '2': 2},
    const {'1': 'BUDGET_STATUS_NEAR_LIMIT', '2': 3},
    const {'1': 'BUDGET_STATUS_INACTIVE', '2': 4},
    const {'1': 'BUDGET_STATUS_COMPLETED', '2': 5},
  ],
};

/// Descriptor for `BudgetStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List budgetStatusDescriptor = $convert.base64Decode('CgxCdWRnZXRTdGF0dXMSHQoZQlVER0VUX1NUQVRVU19VTlNQRUNJRklFRBAAEhgKFEJVREdFVF9TVEFUVVNfQUNUSVZFEAESGgoWQlVER0VUX1NUQVRVU19FWENFRURFRBACEhwKGEJVREdFVF9TVEFUVVNfTkVBUl9MSU1JVBADEhoKFkJVREdFVF9TVEFUVVNfSU5BQ1RJVkUQBBIbChdCVURHRVRfU1RBVFVTX0NPTVBMRVRFRBAF');
@$core.Deprecated('Use alertTypeDescriptor instead')
const AlertType$json = const {
  '1': 'AlertType',
  '2': const [
    const {'1': 'ALERT_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'ALERT_TYPE_THRESHOLD_REACHED', '2': 1},
    const {'1': 'ALERT_TYPE_BUDGET_EXCEEDED', '2': 2},
    const {'1': 'ALERT_TYPE_APPROACHING_LIMIT', '2': 3},
    const {'1': 'ALERT_TYPE_RECURRING_EXPENSE_DUE', '2': 4},
  ],
};

/// Descriptor for `AlertType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List alertTypeDescriptor = $convert.base64Decode('CglBbGVydFR5cGUSGgoWQUxFUlRfVFlQRV9VTlNQRUNJRklFRBAAEiAKHEFMRVJUX1RZUEVfVEhSRVNIT0xEX1JFQUNIRUQQARIeChpBTEVSVF9UWVBFX0JVREdFVF9FWENFRURFRBACEiAKHEFMRVJUX1RZUEVfQVBQUk9BQ0hJTkdfTElNSVQQAxIkCiBBTEVSVF9UWVBFX1JFQ1VSUklOR19FWFBFTlNFX0RVRRAE');
@$core.Deprecated('Use incomeCategoryDescriptor instead')
const IncomeCategory$json = const {
  '1': 'IncomeCategory',
  '2': const [
    const {'1': 'INCOME_CATEGORY_UNSPECIFIED', '2': 0},
    const {'1': 'INCOME_CATEGORY_SALARY', '2': 1},
    const {'1': 'INCOME_CATEGORY_FREELANCE', '2': 2},
    const {'1': 'INCOME_CATEGORY_INVESTMENTS', '2': 3},
    const {'1': 'INCOME_CATEGORY_RENTAL', '2': 4},
    const {'1': 'INCOME_CATEGORY_BUSINESS', '2': 5},
    const {'1': 'INCOME_CATEGORY_DIVIDEND', '2': 6},
    const {'1': 'INCOME_CATEGORY_INTEREST', '2': 7},
    const {'1': 'INCOME_CATEGORY_GIFT', '2': 8},
    const {'1': 'INCOME_CATEGORY_OTHER', '2': 9},
  ],
};

/// Descriptor for `IncomeCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List incomeCategoryDescriptor = $convert.base64Decode('Cg5JbmNvbWVDYXRlZ29yeRIfChtJTkNPTUVfQ0FURUdPUllfVU5TUEVDSUZJRUQQABIaChZJTkNPTUVfQ0FURUdPUllfU0FMQVJZEAESHQoZSU5DT01FX0NBVEVHT1JZX0ZSRUVMQU5DRRACEh8KG0lOQ09NRV9DQVRFR09SWV9JTlZFU1RNRU5UUxADEhoKFklOQ09NRV9DQVRFR09SWV9SRU5UQUwQBBIcChhJTkNPTUVfQ0FURUdPUllfQlVTSU5FU1MQBRIcChhJTkNPTUVfQ0FURUdPUllfRElWSURFTkQQBhIcChhJTkNPTUVfQ0FURUdPUllfSU5URVJFU1QQBxIYChRJTkNPTUVfQ0FURUdPUllfR0lGVBAIEhkKFUlOQ09NRV9DQVRFR09SWV9PVEhFUhAJ');
@$core.Deprecated('Use investmentTypeDescriptor instead')
const InvestmentType$json = const {
  '1': 'InvestmentType',
  '2': const [
    const {'1': 'INVESTMENT_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'INVESTMENT_TYPE_STOCKS', '2': 1},
    const {'1': 'INVESTMENT_TYPE_CRYPTO', '2': 2},
    const {'1': 'INVESTMENT_TYPE_MUTUAL_FUNDS', '2': 3},
    const {'1': 'INVESTMENT_TYPE_BONDS', '2': 4},
    const {'1': 'INVESTMENT_TYPE_ETF', '2': 5},
    const {'1': 'INVESTMENT_TYPE_REAL_ESTATE', '2': 6},
    const {'1': 'INVESTMENT_TYPE_COMMODITIES', '2': 7},
    const {'1': 'INVESTMENT_TYPE_OTHER', '2': 8},
  ],
};

/// Descriptor for `InvestmentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List investmentTypeDescriptor = $convert.base64Decode('Cg5JbnZlc3RtZW50VHlwZRIfChtJTlZFU1RNRU5UX1RZUEVfVU5TUEVDSUZJRUQQABIaChZJTlZFU1RNRU5UX1RZUEVfU1RPQ0tTEAESGgoWSU5WRVNUTUVOVF9UWVBFX0NSWVBUTxACEiAKHElOVkVTVE1FTlRfVFlQRV9NVVRVQUxfRlVORFMQAxIZChVJTlZFU1RNRU5UX1RZUEVfQk9ORFMQBBIXChNJTlZFU1RNRU5UX1RZUEVfRVRGEAUSHwobSU5WRVNUTUVOVF9UWVBFX1JFQUxfRVNUQVRFEAYSHwobSU5WRVNUTUVOVF9UWVBFX0NPTU1PRElUSUVTEAcSGQoVSU5WRVNUTUVOVF9UWVBFX09USEVSEAg=');
@$core.Deprecated('Use goalStatusDescriptor instead')
const GoalStatus$json = const {
  '1': 'GoalStatus',
  '2': const [
    const {'1': 'GOAL_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'GOAL_STATUS_IN_PROGRESS', '2': 1},
    const {'1': 'GOAL_STATUS_COMPLETED', '2': 2},
    const {'1': 'GOAL_STATUS_CANCELLED', '2': 3},
    const {'1': 'GOAL_STATUS_PAUSED', '2': 4},
  ],
};

/// Descriptor for `GoalStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List goalStatusDescriptor = $convert.base64Decode('CgpHb2FsU3RhdHVzEhsKF0dPQUxfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGwoXR09BTF9TVEFUVVNfSU5fUFJPR1JFU1MQARIZChVHT0FMX1NUQVRVU19DT01QTEVURUQQAhIZChVHT0FMX1NUQVRVU19DQU5DRUxMRUQQAxIWChJHT0FMX1NUQVRVU19QQVVTRUQQBA==');
@$core.Deprecated('Use goalTypeDescriptor instead')
const GoalType$json = const {
  '1': 'GoalType',
  '2': const [
    const {'1': 'GOAL_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'GOAL_TYPE_EMERGENCY_FUND', '2': 1},
    const {'1': 'GOAL_TYPE_VACATION', '2': 2},
    const {'1': 'GOAL_TYPE_CAR', '2': 3},
    const {'1': 'GOAL_TYPE_HOUSE', '2': 4},
    const {'1': 'GOAL_TYPE_EDUCATION', '2': 5},
    const {'1': 'GOAL_TYPE_RETIREMENT', '2': 6},
    const {'1': 'GOAL_TYPE_WEDDING', '2': 7},
    const {'1': 'GOAL_TYPE_DEBT_PAYOFF', '2': 8},
    const {'1': 'GOAL_TYPE_CUSTOM', '2': 9},
  ],
};

/// Descriptor for `GoalType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List goalTypeDescriptor = $convert.base64Decode('CghHb2FsVHlwZRIZChVHT0FMX1RZUEVfVU5TUEVDSUZJRUQQABIcChhHT0FMX1RZUEVfRU1FUkdFTkNZX0ZVTkQQARIWChJHT0FMX1RZUEVfVkFDQVRJT04QAhIRCg1HT0FMX1RZUEVfQ0FSEAMSEwoPR09BTF9UWVBFX0hPVVNFEAQSFwoTR09BTF9UWVBFX0VEVUNBVElPThAFEhgKFEdPQUxfVFlQRV9SRVRJUkVNRU5UEAYSFQoRR09BTF9UWVBFX1dFRERJTkcQBxIZChVHT0FMX1RZUEVfREVCVF9QQVlPRkYQCBIUChBHT0FMX1RZUEVfQ1VTVE9NEAk=');
@$core.Deprecated('Use billStatusDescriptor instead')
const BillStatus$json = const {
  '1': 'BillStatus',
  '2': const [
    const {'1': 'BILL_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'BILL_STATUS_UPCOMING', '2': 1},
    const {'1': 'BILL_STATUS_PAID', '2': 2},
    const {'1': 'BILL_STATUS_OVERDUE', '2': 3},
    const {'1': 'BILL_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `BillStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List billStatusDescriptor = $convert.base64Decode('CgpCaWxsU3RhdHVzEhsKF0JJTExfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGAoUQklMTF9TVEFUVVNfVVBDT01JTkcQARIUChBCSUxMX1NUQVRVU19QQUlEEAISFwoTQklMTF9TVEFUVVNfT1ZFUkRVRRADEhkKFUJJTExfU1RBVFVTX0NBTkNFTExFRBAE');
@$core.Deprecated('Use expenseMessageDescriptor instead')
const ExpenseMessage$json = const {
  '1': 'ExpenseMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'subcategory', '3': 7, '4': 1, '5': 9, '10': 'subcategory'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'merchant', '3': 9, '4': 1, '5': 9, '10': 'merchant'},
    const {'1': 'transaction_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'payment_method', '3': 11, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'receipt_url', '3': 12, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'tags', '3': 13, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'notes', '3': 14, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'is_recurring', '3': 15, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_pattern', '3': 16, '4': 1, '5': 9, '10': 'recurrencePattern'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `ExpenseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expenseMessageDescriptor = $convert.base64Decode('Cg5FeHBlbnNlTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoBFIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSLwoIY2F0ZWdvcnkYBiABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5EiAKC3N1YmNhdGVnb3J5GAcgASgJUgtzdWJjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgIIAEoCVILZGVzY3JpcHRpb24SGgoIbWVyY2hhbnQYCSABKAlSCG1lcmNoYW50EkUKEHRyYW5zYWN0aW9uX2RhdGUYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg90cmFuc2FjdGlvbkRhdGUSJQoOcGF5bWVudF9tZXRob2QYCyABKAlSDXBheW1lbnRNZXRob2QSHwoLcmVjZWlwdF91cmwYDCABKAlSCnJlY2VpcHRVcmwSEgoEdGFncxgNIAMoCVIEdGFncxIUCgVub3RlcxgOIAEoCVIFbm90ZXMSIQoMaXNfcmVjdXJyaW5nGA8gASgIUgtpc1JlY3VycmluZxItChJyZWN1cnJlbmNlX3BhdHRlcm4YECABKAlSEXJlY3VycmVuY2VQYXR0ZXJuEjkKCmNyZWF0ZWRfYXQYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use budgetMessageDescriptor instead')
const BudgetMessage$json = const {
  '1': 'BudgetMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'period', '3': 7, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
    const {'1': 'start_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'spent_amount', '3': 10, '4': 1, '5': 1, '10': 'spentAmount'},
    const {'1': 'remaining_amount', '3': 11, '4': 1, '5': 1, '10': 'remainingAmount'},
    const {'1': 'percentage_used', '3': 12, '4': 1, '5': 1, '10': 'percentageUsed'},
    const {'1': 'status', '3': 13, '4': 1, '5': 14, '6': '.pb.BudgetStatus', '10': 'status'},
    const {'1': 'enable_alerts', '3': 14, '4': 1, '5': 8, '10': 'enableAlerts'},
    const {'1': 'alert_threshold', '3': 15, '4': 1, '5': 1, '10': 'alertThreshold'},
    const {'1': 'created_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `BudgetMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetMessageDescriptor = $convert.base64Decode('Cg1CdWRnZXRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSLwoIY2F0ZWdvcnkYBiABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5EigKBnBlcmlvZBgHIAEoDjIQLnBiLkJ1ZGdldFBlcmlvZFIGcGVyaW9kEjkKCnN0YXJ0X2RhdGUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRlEiEKDHNwZW50X2Ftb3VudBgKIAEoAVILc3BlbnRBbW91bnQSKQoQcmVtYWluaW5nX2Ftb3VudBgLIAEoAVIPcmVtYWluaW5nQW1vdW50EicKD3BlcmNlbnRhZ2VfdXNlZBgMIAEoAVIOcGVyY2VudGFnZVVzZWQSKAoGc3RhdHVzGA0gASgOMhAucGIuQnVkZ2V0U3RhdHVzUgZzdGF0dXMSIwoNZW5hYmxlX2FsZXJ0cxgOIAEoCFIMZW5hYmxlQWxlcnRzEicKD2FsZXJ0X3RocmVzaG9sZBgPIAEoAVIOYWxlcnRUaHJlc2hvbGQSOQoKY3JlYXRlZF9hdBgQIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use budgetAlertMessageDescriptor instead')
const BudgetAlertMessage$json = const {
  '1': 'BudgetAlertMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'budget_id', '3': 3, '4': 1, '5': 9, '10': 'budgetId'},
    const {'1': 'budget_name', '3': 4, '4': 1, '5': 9, '10': 'budgetName'},
    const {'1': 'alert_type', '3': 5, '4': 1, '5': 14, '6': '.pb.AlertType', '10': 'alertType'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'current_spent', '3': 7, '4': 1, '5': 1, '10': 'currentSpent'},
    const {'1': 'budget_limit', '3': 8, '4': 1, '5': 1, '10': 'budgetLimit'},
    const {'1': 'percentage_used', '3': 9, '4': 1, '5': 1, '10': 'percentageUsed'},
    const {'1': 'is_read', '3': 10, '4': 1, '5': 8, '10': 'isRead'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `BudgetAlertMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetAlertMessageDescriptor = $convert.base64Decode('ChJCdWRnZXRBbGVydE1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKARSBnVzZXJJZBIbCglidWRnZXRfaWQYAyABKAlSCGJ1ZGdldElkEh8KC2J1ZGdldF9uYW1lGAQgASgJUgpidWRnZXROYW1lEiwKCmFsZXJ0X3R5cGUYBSABKA4yDS5wYi5BbGVydFR5cGVSCWFsZXJ0VHlwZRIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdlEiMKDWN1cnJlbnRfc3BlbnQYByABKAFSDGN1cnJlbnRTcGVudBIhCgxidWRnZXRfbGltaXQYCCABKAFSC2J1ZGdldExpbWl0EicKD3BlcmNlbnRhZ2VfdXNlZBgJIAEoAVIOcGVyY2VudGFnZVVzZWQSFwoHaXNfcmVhZBgKIAEoCFIGaXNSZWFkEjkKCmNyZWF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use spendingAnalyticsDescriptor instead')
const SpendingAnalytics$json = const {
  '1': 'SpendingAnalytics',
  '2': const [
    const {'1': 'period', '3': 1, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'total_spent', '3': 2, '4': 1, '5': 1, '10': 'totalSpent'},
    const {'1': 'total_budget', '3': 3, '4': 1, '5': 1, '10': 'totalBudget'},
    const {'1': 'remaining_budget', '3': 4, '4': 1, '5': 1, '10': 'remainingBudget'},
    const {'1': 'transaction_count', '3': 5, '4': 1, '5': 5, '10': 'transactionCount'},
    const {'1': 'average_transaction', '3': 6, '4': 1, '5': 1, '10': 'averageTransaction'},
    const {'1': 'category_breakdown', '3': 7, '4': 3, '5': 11, '6': '.pb.CategorySpending', '10': 'categoryBreakdown'},
    const {'1': 'daily_trend', '3': 8, '4': 3, '5': 11, '6': '.pb.DailySpending', '10': 'dailyTrend'},
    const {'1': 'top_category', '3': 9, '4': 1, '5': 9, '10': 'topCategory'},
    const {'1': 'top_category_amount', '3': 10, '4': 1, '5': 1, '10': 'topCategoryAmount'},
    const {'1': 'savings_rate', '3': 11, '4': 1, '5': 1, '10': 'savingsRate'},
  ],
};

/// Descriptor for `SpendingAnalytics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spendingAnalyticsDescriptor = $convert.base64Decode('ChFTcGVuZGluZ0FuYWx5dGljcxIWCgZwZXJpb2QYASABKAlSBnBlcmlvZBIfCgt0b3RhbF9zcGVudBgCIAEoAVIKdG90YWxTcGVudBIhCgx0b3RhbF9idWRnZXQYAyABKAFSC3RvdGFsQnVkZ2V0EikKEHJlbWFpbmluZ19idWRnZXQYBCABKAFSD3JlbWFpbmluZ0J1ZGdldBIrChF0cmFuc2FjdGlvbl9jb3VudBgFIAEoBVIQdHJhbnNhY3Rpb25Db3VudBIvChNhdmVyYWdlX3RyYW5zYWN0aW9uGAYgASgBUhJhdmVyYWdlVHJhbnNhY3Rpb24SQwoSY2F0ZWdvcnlfYnJlYWtkb3duGAcgAygLMhQucGIuQ2F0ZWdvcnlTcGVuZGluZ1IRY2F0ZWdvcnlCcmVha2Rvd24SMgoLZGFpbHlfdHJlbmQYCCADKAsyES5wYi5EYWlseVNwZW5kaW5nUgpkYWlseVRyZW5kEiEKDHRvcF9jYXRlZ29yeRgJIAEoCVILdG9wQ2F0ZWdvcnkSLgoTdG9wX2NhdGVnb3J5X2Ftb3VudBgKIAEoAVIRdG9wQ2F0ZWdvcnlBbW91bnQSIQoMc2F2aW5nc19yYXRlGAsgASgBUgtzYXZpbmdzUmF0ZQ==');
@$core.Deprecated('Use categorySpendingDescriptor instead')
const CategorySpending$json = const {
  '1': 'CategorySpending',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
    const {'1': 'transaction_count', '3': 5, '4': 1, '5': 5, '10': 'transactionCount'},
    const {'1': 'budget_allocated', '3': 6, '4': 1, '5': 1, '10': 'budgetAllocated'},
    const {'1': 'budget_remaining', '3': 7, '4': 1, '5': 1, '10': 'budgetRemaining'},
  ],
};

/// Descriptor for `CategorySpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categorySpendingDescriptor = $convert.base64Decode('ChBDYXRlZ29yeVNwZW5kaW5nEi8KCGNhdGVnb3J5GAEgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UghjYXRlZ29yeRIjCg1jYXRlZ29yeV9uYW1lGAIgASgJUgxjYXRlZ29yeU5hbWUSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSHgoKcGVyY2VudGFnZRgEIAEoAVIKcGVyY2VudGFnZRIrChF0cmFuc2FjdGlvbl9jb3VudBgFIAEoBVIQdHJhbnNhY3Rpb25Db3VudBIpChBidWRnZXRfYWxsb2NhdGVkGAYgASgBUg9idWRnZXRBbGxvY2F0ZWQSKQoQYnVkZ2V0X3JlbWFpbmluZxgHIAEoAVIPYnVkZ2V0UmVtYWluaW5n');
@$core.Deprecated('Use dailySpendingDescriptor instead')
const DailySpending$json = const {
  '1': 'DailySpending',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_count', '3': 3, '4': 1, '5': 5, '10': 'transactionCount'},
  ],
};

/// Descriptor for `DailySpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailySpendingDescriptor = $convert.base64Decode('Cg1EYWlseVNwZW5kaW5nEi4KBGRhdGUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgRkYXRlEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EisKEXRyYW5zYWN0aW9uX2NvdW50GAMgASgFUhB0cmFuc2FjdGlvbkNvdW50');
@$core.Deprecated('Use budgetProgressItemDescriptor instead')
const BudgetProgressItem$json = const {
  '1': 'BudgetProgressItem',
  '2': const [
    const {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
    const {'1': 'budget_name', '3': 2, '4': 1, '5': 9, '10': 'budgetName'},
    const {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'budget_amount', '3': 4, '4': 1, '5': 1, '10': 'budgetAmount'},
    const {'1': 'spent_amount', '3': 5, '4': 1, '5': 1, '10': 'spentAmount'},
    const {'1': 'remaining_amount', '3': 6, '4': 1, '5': 1, '10': 'remainingAmount'},
    const {'1': 'percentage_used', '3': 7, '4': 1, '5': 1, '10': 'percentageUsed'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.BudgetStatus', '10': 'status'},
    const {'1': 'days_remaining', '3': 9, '4': 1, '5': 5, '10': 'daysRemaining'},
    const {'1': 'daily_average_spend', '3': 10, '4': 1, '5': 1, '10': 'dailyAverageSpend'},
    const {'1': 'projected_spend', '3': 11, '4': 1, '5': 1, '10': 'projectedSpend'},
    const {'1': 'will_exceed', '3': 12, '4': 1, '5': 8, '10': 'willExceed'},
  ],
};

/// Descriptor for `BudgetProgressItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetProgressItemDescriptor = $convert.base64Decode('ChJCdWRnZXRQcm9ncmVzc0l0ZW0SGwoJYnVkZ2V0X2lkGAEgASgJUghidWRnZXRJZBIfCgtidWRnZXRfbmFtZRgCIAEoCVIKYnVkZ2V0TmFtZRIvCghjYXRlZ29yeRgDIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVIIY2F0ZWdvcnkSIwoNYnVkZ2V0X2Ftb3VudBgEIAEoAVIMYnVkZ2V0QW1vdW50EiEKDHNwZW50X2Ftb3VudBgFIAEoAVILc3BlbnRBbW91bnQSKQoQcmVtYWluaW5nX2Ftb3VudBgGIAEoAVIPcmVtYWluaW5nQW1vdW50EicKD3BlcmNlbnRhZ2VfdXNlZBgHIAEoAVIOcGVyY2VudGFnZVVzZWQSKAoGc3RhdHVzGAggASgOMhAucGIuQnVkZ2V0U3RhdHVzUgZzdGF0dXMSJQoOZGF5c19yZW1haW5pbmcYCSABKAVSDWRheXNSZW1haW5pbmcSLgoTZGFpbHlfYXZlcmFnZV9zcGVuZBgKIAEoAVIRZGFpbHlBdmVyYWdlU3BlbmQSJwoPcHJvamVjdGVkX3NwZW5kGAsgASgBUg5wcm9qZWN0ZWRTcGVuZBIfCgt3aWxsX2V4Y2VlZBgMIAEoCFIKd2lsbEV4Y2VlZA==');
@$core.Deprecated('Use spendingTrendDescriptor instead')
const SpendingTrend$json = const {
  '1': 'SpendingTrend',
  '2': const [
    const {'1': 'period_label', '3': 1, '4': 1, '5': 9, '10': 'periodLabel'},
    const {'1': 'period_start', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'periodStart'},
    const {'1': 'period_end', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'periodEnd'},
    const {'1': 'total_spent', '3': 4, '4': 1, '5': 1, '10': 'totalSpent'},
    const {'1': 'budget_amount', '3': 5, '4': 1, '5': 1, '10': 'budgetAmount'},
    const {'1': 'variance', '3': 6, '4': 1, '5': 1, '10': 'variance'},
    const {'1': 'variance_percentage', '3': 7, '4': 1, '5': 1, '10': 'variancePercentage'},
    const {'1': 'categories', '3': 8, '4': 3, '5': 11, '6': '.pb.CategorySpending', '10': 'categories'},
  ],
};

/// Descriptor for `SpendingTrend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spendingTrendDescriptor = $convert.base64Decode('Cg1TcGVuZGluZ1RyZW5kEiEKDHBlcmlvZF9sYWJlbBgBIAEoCVILcGVyaW9kTGFiZWwSPQoMcGVyaW9kX3N0YXJ0GAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcGVyaW9kU3RhcnQSOQoKcGVyaW9kX2VuZBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXBlcmlvZEVuZBIfCgt0b3RhbF9zcGVudBgEIAEoAVIKdG90YWxTcGVudBIjCg1idWRnZXRfYW1vdW50GAUgASgBUgxidWRnZXRBbW91bnQSGgoIdmFyaWFuY2UYBiABKAFSCHZhcmlhbmNlEi8KE3ZhcmlhbmNlX3BlcmNlbnRhZ2UYByABKAFSEnZhcmlhbmNlUGVyY2VudGFnZRI0CgpjYXRlZ29yaWVzGAggAygLMhQucGIuQ2F0ZWdvcnlTcGVuZGluZ1IKY2F0ZWdvcmllcw==');
@$core.Deprecated('Use createExpenseRequestDescriptor instead')
const CreateExpenseRequest$json = const {
  '1': 'CreateExpenseRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'subcategory', '3': 5, '4': 1, '5': 9, '10': 'subcategory'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'merchant', '3': 7, '4': 1, '5': 9, '10': 'merchant'},
    const {'1': 'transaction_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'payment_method', '3': 9, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'receipt_url', '3': 10, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'tags', '3': 11, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'notes', '3': 12, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'is_recurring', '3': 13, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_pattern', '3': 14, '4': 1, '5': 9, '10': 'recurrencePattern'},
  ],
};

/// Descriptor for `CreateExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createExpenseRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVFeHBlbnNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5Ei8KCGNhdGVnb3J5GAQgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UghjYXRlZ29yeRIgCgtzdWJjYXRlZ29yeRgFIAEoCVILc3ViY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YBiABKAlSC2Rlc2NyaXB0aW9uEhoKCG1lcmNoYW50GAcgASgJUghtZXJjaGFudBJFChB0cmFuc2FjdGlvbl9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEiUKDnBheW1lbnRfbWV0aG9kGAkgASgJUg1wYXltZW50TWV0aG9kEh8KC3JlY2VpcHRfdXJsGAogASgJUgpyZWNlaXB0VXJsEhIKBHRhZ3MYCyADKAlSBHRhZ3MSFAoFbm90ZXMYDCABKAlSBW5vdGVzEiEKDGlzX3JlY3VycmluZxgNIAEoCFILaXNSZWN1cnJpbmcSLQoScmVjdXJyZW5jZV9wYXR0ZXJuGA4gASgJUhFyZWN1cnJlbmNlUGF0dGVybg==');
@$core.Deprecated('Use createExpenseResponseDescriptor instead')
const CreateExpenseResponse$json = const {
  '1': 'CreateExpenseResponse',
  '2': const [
    const {'1': 'expense', '3': 1, '4': 1, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expense'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createExpenseResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVFeHBlbnNlUmVzcG9uc2USLAoHZXhwZW5zZRgBIAEoCzISLnBiLkV4cGVuc2VNZXNzYWdlUgdleHBlbnNlEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getExpensesRequestDescriptor instead')
const GetExpensesRequest$json = const {
  '1': 'GetExpensesRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'category', '3': 5, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'min_amount', '3': 6, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 7, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'search_query', '3': 8, '4': 1, '5': 9, '10': 'searchQuery'},
    const {'1': 'tags', '3': 9, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `GetExpensesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpensesRequestDescriptor = $convert.base64Decode('ChJHZXRFeHBlbnNlc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgCIAEoBVIHcGVyUGFnZRI5CgpzdGFydF9kYXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIvCghjYXRlZ29yeRgFIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVIIY2F0ZWdvcnkSHQoKbWluX2Ftb3VudBgGIAEoAVIJbWluQW1vdW50Eh0KCm1heF9hbW91bnQYByABKAFSCW1heEFtb3VudBIhCgxzZWFyY2hfcXVlcnkYCCABKAlSC3NlYXJjaFF1ZXJ5EhIKBHRhZ3MYCSADKAlSBHRhZ3M=');
@$core.Deprecated('Use getExpensesResponseDescriptor instead')
const GetExpensesResponse$json = const {
  '1': 'GetExpensesResponse',
  '2': const [
    const {'1': 'expenses', '3': 1, '4': 3, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expenses'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationMetadata', '10': 'pagination'},
    const {'1': 'total_amount', '3': 3, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'total_count', '3': 4, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetExpensesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpensesResponseDescriptor = $convert.base64Decode('ChNHZXRFeHBlbnNlc1Jlc3BvbnNlEi4KCGV4cGVuc2VzGAEgAygLMhIucGIuRXhwZW5zZU1lc3NhZ2VSCGV4cGVuc2VzEjYKCnBhZ2luYXRpb24YAiABKAsyFi5wYi5QYWdpbmF0aW9uTWV0YWRhdGFSCnBhZ2luYXRpb24SIQoMdG90YWxfYW1vdW50GAMgASgBUgt0b3RhbEFtb3VudBIfCgt0b3RhbF9jb3VudBgEIAEoBVIKdG90YWxDb3VudA==');
@$core.Deprecated('Use getExpenseByIdRequestDescriptor instead')
const GetExpenseByIdRequest$json = const {
  '1': 'GetExpenseByIdRequest',
  '2': const [
    const {'1': 'expense_id', '3': 1, '4': 1, '5': 9, '10': 'expenseId'},
  ],
};

/// Descriptor for `GetExpenseByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseByIdRequestDescriptor = $convert.base64Decode('ChVHZXRFeHBlbnNlQnlJZFJlcXVlc3QSHQoKZXhwZW5zZV9pZBgBIAEoCVIJZXhwZW5zZUlk');
@$core.Deprecated('Use getExpenseByIdResponseDescriptor instead')
const GetExpenseByIdResponse$json = const {
  '1': 'GetExpenseByIdResponse',
  '2': const [
    const {'1': 'expense', '3': 1, '4': 1, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expense'},
  ],
};

/// Descriptor for `GetExpenseByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseByIdResponseDescriptor = $convert.base64Decode('ChZHZXRFeHBlbnNlQnlJZFJlc3BvbnNlEiwKB2V4cGVuc2UYASABKAsyEi5wYi5FeHBlbnNlTWVzc2FnZVIHZXhwZW5zZQ==');
@$core.Deprecated('Use updateExpenseRequestDescriptor instead')
const UpdateExpenseRequest$json = const {
  '1': 'UpdateExpenseRequest',
  '2': const [
    const {'1': 'expense_id', '3': 1, '4': 1, '5': 9, '10': 'expenseId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'subcategory', '3': 4, '4': 1, '5': 9, '10': 'subcategory'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'merchant', '3': 6, '4': 1, '5': 9, '10': 'merchant'},
    const {'1': 'transaction_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'payment_method', '3': 8, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'tags', '3': 9, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateExpenseRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVFeHBlbnNlUmVxdWVzdBIdCgpleHBlbnNlX2lkGAEgASgJUglleHBlbnNlSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSLwoIY2F0ZWdvcnkYAyABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5EiAKC3N1YmNhdGVnb3J5GAQgASgJUgtzdWJjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SGgoIbWVyY2hhbnQYBiABKAlSCG1lcmNoYW50EkUKEHRyYW5zYWN0aW9uX2RhdGUYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg90cmFuc2FjdGlvbkRhdGUSJQoOcGF5bWVudF9tZXRob2QYCCABKAlSDXBheW1lbnRNZXRob2QSEgoEdGFncxgJIAMoCVIEdGFncxIUCgVub3RlcxgKIAEoCVIFbm90ZXM=');
@$core.Deprecated('Use updateExpenseResponseDescriptor instead')
const UpdateExpenseResponse$json = const {
  '1': 'UpdateExpenseResponse',
  '2': const [
    const {'1': 'expense', '3': 1, '4': 1, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expense'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateExpenseResponseDescriptor = $convert.base64Decode('ChVVcGRhdGVFeHBlbnNlUmVzcG9uc2USLAoHZXhwZW5zZRgBIAEoCzISLnBiLkV4cGVuc2VNZXNzYWdlUgdleHBlbnNlEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteExpenseRequestDescriptor instead')
const DeleteExpenseRequest$json = const {
  '1': 'DeleteExpenseRequest',
  '2': const [
    const {'1': 'expense_id', '3': 1, '4': 1, '5': 9, '10': 'expenseId'},
  ],
};

/// Descriptor for `DeleteExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteExpenseRequestDescriptor = $convert.base64Decode('ChREZWxldGVFeHBlbnNlUmVxdWVzdBIdCgpleHBlbnNlX2lkGAEgASgJUglleHBlbnNlSWQ=');
@$core.Deprecated('Use deleteExpenseResponseDescriptor instead')
const DeleteExpenseResponse$json = const {
  '1': 'DeleteExpenseResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteExpenseResponseDescriptor = $convert.base64Decode('ChVEZWxldGVFeHBlbnNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use createBudgetRequestDescriptor instead')
const CreateBudgetRequest$json = const {
  '1': 'CreateBudgetRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'period', '3': 5, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
    const {'1': 'start_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'enable_alerts', '3': 8, '4': 1, '5': 8, '10': 'enableAlerts'},
    const {'1': 'alert_threshold', '3': 9, '4': 1, '5': 1, '10': 'alertThreshold'},
  ],
};

/// Descriptor for `CreateBudgetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBudgetRequestDescriptor = $convert.base64Decode('ChNDcmVhdGVCdWRnZXRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5Ei8KCGNhdGVnb3J5GAQgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UghjYXRlZ29yeRIoCgZwZXJpb2QYBSABKA4yEC5wYi5CdWRnZXRQZXJpb2RSBnBlcmlvZBI5CgpzdGFydF9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIjCg1lbmFibGVfYWxlcnRzGAggASgIUgxlbmFibGVBbGVydHMSJwoPYWxlcnRfdGhyZXNob2xkGAkgASgBUg5hbGVydFRocmVzaG9sZA==');
@$core.Deprecated('Use createBudgetResponseDescriptor instead')
const CreateBudgetResponse$json = const {
  '1': 'CreateBudgetResponse',
  '2': const [
    const {'1': 'budget', '3': 1, '4': 1, '5': 11, '6': '.pb.BudgetMessage', '10': 'budget'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateBudgetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBudgetResponseDescriptor = $convert.base64Decode('ChRDcmVhdGVCdWRnZXRSZXNwb25zZRIpCgZidWRnZXQYASABKAsyES5wYi5CdWRnZXRNZXNzYWdlUgZidWRnZXQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getBudgetsRequestDescriptor instead')
const GetBudgetsRequest$json = const {
  '1': 'GetBudgetsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.BudgetStatus', '10': 'status'},
    const {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
  ],
};

/// Descriptor for `GetBudgetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetsRequestDescriptor = $convert.base64Decode('ChFHZXRCdWRnZXRzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAIgASgFUgdwZXJQYWdlEigKBnN0YXR1cxgDIAEoDjIQLnBiLkJ1ZGdldFN0YXR1c1IGc3RhdHVzEi8KCGNhdGVnb3J5GAQgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UghjYXRlZ29yeQ==');
@$core.Deprecated('Use getBudgetsResponseDescriptor instead')
const GetBudgetsResponse$json = const {
  '1': 'GetBudgetsResponse',
  '2': const [
    const {'1': 'budgets', '3': 1, '4': 3, '5': 11, '6': '.pb.BudgetMessage', '10': 'budgets'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationMetadata', '10': 'pagination'},
    const {'1': 'total_budget_amount', '3': 3, '4': 1, '5': 1, '10': 'totalBudgetAmount'},
    const {'1': 'total_spent_amount', '3': 4, '4': 1, '5': 1, '10': 'totalSpentAmount'},
  ],
};

/// Descriptor for `GetBudgetsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetsResponseDescriptor = $convert.base64Decode('ChJHZXRCdWRnZXRzUmVzcG9uc2USKwoHYnVkZ2V0cxgBIAMoCzIRLnBiLkJ1ZGdldE1lc3NhZ2VSB2J1ZGdldHMSNgoKcGFnaW5hdGlvbhgCIAEoCzIWLnBiLlBhZ2luYXRpb25NZXRhZGF0YVIKcGFnaW5hdGlvbhIuChN0b3RhbF9idWRnZXRfYW1vdW50GAMgASgBUhF0b3RhbEJ1ZGdldEFtb3VudBIsChJ0b3RhbF9zcGVudF9hbW91bnQYBCABKAFSEHRvdGFsU3BlbnRBbW91bnQ=');
@$core.Deprecated('Use getBudgetByIdRequestDescriptor instead')
const GetBudgetByIdRequest$json = const {
  '1': 'GetBudgetByIdRequest',
  '2': const [
    const {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
  ],
};

/// Descriptor for `GetBudgetByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetByIdRequestDescriptor = $convert.base64Decode('ChRHZXRCdWRnZXRCeUlkUmVxdWVzdBIbCglidWRnZXRfaWQYASABKAlSCGJ1ZGdldElk');
@$core.Deprecated('Use getBudgetByIdResponseDescriptor instead')
const GetBudgetByIdResponse$json = const {
  '1': 'GetBudgetByIdResponse',
  '2': const [
    const {'1': 'budget', '3': 1, '4': 1, '5': 11, '6': '.pb.BudgetMessage', '10': 'budget'},
    const {'1': 'recent_expenses', '3': 2, '4': 3, '5': 11, '6': '.pb.ExpenseMessage', '10': 'recentExpenses'},
  ],
};

/// Descriptor for `GetBudgetByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetByIdResponseDescriptor = $convert.base64Decode('ChVHZXRCdWRnZXRCeUlkUmVzcG9uc2USKQoGYnVkZ2V0GAEgASgLMhEucGIuQnVkZ2V0TWVzc2FnZVIGYnVkZ2V0EjsKD3JlY2VudF9leHBlbnNlcxgCIAMoCzISLnBiLkV4cGVuc2VNZXNzYWdlUg5yZWNlbnRFeHBlbnNlcw==');
@$core.Deprecated('Use updateBudgetRequestDescriptor instead')
const UpdateBudgetRequest$json = const {
  '1': 'UpdateBudgetRequest',
  '2': const [
    const {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'period', '3': 4, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
    const {'1': 'start_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'enable_alerts', '3': 7, '4': 1, '5': 8, '10': 'enableAlerts'},
    const {'1': 'alert_threshold', '3': 8, '4': 1, '5': 1, '10': 'alertThreshold'},
  ],
};

/// Descriptor for `UpdateBudgetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBudgetRequestDescriptor = $convert.base64Decode('ChNVcGRhdGVCdWRnZXRSZXF1ZXN0EhsKCWJ1ZGdldF9pZBgBIAEoCVIIYnVkZ2V0SWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIoCgZwZXJpb2QYBCABKA4yEC5wYi5CdWRnZXRQZXJpb2RSBnBlcmlvZBI5CgpzdGFydF9kYXRlGAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIjCg1lbmFibGVfYWxlcnRzGAcgASgIUgxlbmFibGVBbGVydHMSJwoPYWxlcnRfdGhyZXNob2xkGAggASgBUg5hbGVydFRocmVzaG9sZA==');
@$core.Deprecated('Use updateBudgetResponseDescriptor instead')
const UpdateBudgetResponse$json = const {
  '1': 'UpdateBudgetResponse',
  '2': const [
    const {'1': 'budget', '3': 1, '4': 1, '5': 11, '6': '.pb.BudgetMessage', '10': 'budget'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateBudgetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBudgetResponseDescriptor = $convert.base64Decode('ChRVcGRhdGVCdWRnZXRSZXNwb25zZRIpCgZidWRnZXQYASABKAsyES5wYi5CdWRnZXRNZXNzYWdlUgZidWRnZXQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteBudgetRequestDescriptor instead')
const DeleteBudgetRequest$json = const {
  '1': 'DeleteBudgetRequest',
  '2': const [
    const {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
  ],
};

/// Descriptor for `DeleteBudgetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBudgetRequestDescriptor = $convert.base64Decode('ChNEZWxldGVCdWRnZXRSZXF1ZXN0EhsKCWJ1ZGdldF9pZBgBIAEoCVIIYnVkZ2V0SWQ=');
@$core.Deprecated('Use deleteBudgetResponseDescriptor instead')
const DeleteBudgetResponse$json = const {
  '1': 'DeleteBudgetResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteBudgetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBudgetResponseDescriptor = $convert.base64Decode('ChREZWxldGVCdWRnZXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getSpendingAnalyticsRequestDescriptor instead')
const GetSpendingAnalyticsRequest$json = const {
  '1': 'GetSpendingAnalyticsRequest',
  '2': const [
    const {'1': 'period', '3': 1, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
  ],
};

/// Descriptor for `GetSpendingAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingAnalyticsRequestDescriptor = $convert.base64Decode('ChtHZXRTcGVuZGluZ0FuYWx5dGljc1JlcXVlc3QSFgoGcGVyaW9kGAEgASgJUgZwZXJpb2QSOQoKc3RhcnRfZGF0ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0ZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGUSLwoIY2F0ZWdvcnkYBCABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5');
@$core.Deprecated('Use getSpendingAnalyticsResponseDescriptor instead')
const GetSpendingAnalyticsResponse$json = const {
  '1': 'GetSpendingAnalyticsResponse',
  '2': const [
    const {'1': 'analytics', '3': 1, '4': 1, '5': 11, '6': '.pb.SpendingAnalytics', '10': 'analytics'},
  ],
};

/// Descriptor for `GetSpendingAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingAnalyticsResponseDescriptor = $convert.base64Decode('ChxHZXRTcGVuZGluZ0FuYWx5dGljc1Jlc3BvbnNlEjMKCWFuYWx5dGljcxgBIAEoCzIVLnBiLlNwZW5kaW5nQW5hbHl0aWNzUglhbmFseXRpY3M=');
@$core.Deprecated('Use getCategoryBreakdownRequestDescriptor instead')
const GetCategoryBreakdownRequest$json = const {
  '1': 'GetCategoryBreakdownRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetCategoryBreakdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryBreakdownRequestDescriptor = $convert.base64Decode('ChtHZXRDYXRlZ29yeUJyZWFrZG93blJlcXVlc3QSOQoKc3RhcnRfZGF0ZRgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGU=');
@$core.Deprecated('Use getCategoryBreakdownResponseDescriptor instead')
const GetCategoryBreakdownResponse$json = const {
  '1': 'GetCategoryBreakdownResponse',
  '2': const [
    const {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.pb.CategorySpending', '10': 'categories'},
    const {'1': 'total_spent', '3': 2, '4': 1, '5': 1, '10': 'totalSpent'},
  ],
};

/// Descriptor for `GetCategoryBreakdownResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryBreakdownResponseDescriptor = $convert.base64Decode('ChxHZXRDYXRlZ29yeUJyZWFrZG93blJlc3BvbnNlEjQKCmNhdGVnb3JpZXMYASADKAsyFC5wYi5DYXRlZ29yeVNwZW5kaW5nUgpjYXRlZ29yaWVzEh8KC3RvdGFsX3NwZW50GAIgASgBUgp0b3RhbFNwZW50');
@$core.Deprecated('Use getBudgetProgressRequestDescriptor instead')
const GetBudgetProgressRequest$json = const {
  '1': 'GetBudgetProgressRequest',
  '2': const [
    const {'1': 'period', '3': 1, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
  ],
};

/// Descriptor for `GetBudgetProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetProgressRequestDescriptor = $convert.base64Decode('ChhHZXRCdWRnZXRQcm9ncmVzc1JlcXVlc3QSKAoGcGVyaW9kGAEgASgOMhAucGIuQnVkZ2V0UGVyaW9kUgZwZXJpb2Q=');
@$core.Deprecated('Use getBudgetProgressResponseDescriptor instead')
const GetBudgetProgressResponse$json = const {
  '1': 'GetBudgetProgressResponse',
  '2': const [
    const {'1': 'budgets', '3': 1, '4': 3, '5': 11, '6': '.pb.BudgetProgressItem', '10': 'budgets'},
    const {'1': 'total_budget', '3': 2, '4': 1, '5': 1, '10': 'totalBudget'},
    const {'1': 'total_spent', '3': 3, '4': 1, '5': 1, '10': 'totalSpent'},
    const {'1': 'overall_percentage', '3': 4, '4': 1, '5': 1, '10': 'overallPercentage'},
  ],
};

/// Descriptor for `GetBudgetProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetProgressResponseDescriptor = $convert.base64Decode('ChlHZXRCdWRnZXRQcm9ncmVzc1Jlc3BvbnNlEjAKB2J1ZGdldHMYASADKAsyFi5wYi5CdWRnZXRQcm9ncmVzc0l0ZW1SB2J1ZGdldHMSIQoMdG90YWxfYnVkZ2V0GAIgASgBUgt0b3RhbEJ1ZGdldBIfCgt0b3RhbF9zcGVudBgDIAEoAVIKdG90YWxTcGVudBItChJvdmVyYWxsX3BlcmNlbnRhZ2UYBCABKAFSEW92ZXJhbGxQZXJjZW50YWdl');
@$core.Deprecated('Use getSpendingTrendsRequestDescriptor instead')
const GetSpendingTrendsRequest$json = const {
  '1': 'GetSpendingTrendsRequest',
  '2': const [
    const {'1': 'period_type', '3': 1, '4': 1, '5': 9, '10': 'periodType'},
    const {'1': 'periods_count', '3': 2, '4': 1, '5': 5, '10': 'periodsCount'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetSpendingTrendsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingTrendsRequestDescriptor = $convert.base64Decode('ChhHZXRTcGVuZGluZ1RyZW5kc1JlcXVlc3QSHwoLcGVyaW9kX3R5cGUYASABKAlSCnBlcmlvZFR5cGUSIwoNcGVyaW9kc19jb3VudBgCIAEoBVIMcGVyaW9kc0NvdW50EjUKCGVuZF9kYXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZQ==');
@$core.Deprecated('Use getSpendingTrendsResponseDescriptor instead')
const GetSpendingTrendsResponse$json = const {
  '1': 'GetSpendingTrendsResponse',
  '2': const [
    const {'1': 'trends', '3': 1, '4': 3, '5': 11, '6': '.pb.SpendingTrend', '10': 'trends'},
  ],
};

/// Descriptor for `GetSpendingTrendsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingTrendsResponseDescriptor = $convert.base64Decode('ChlHZXRTcGVuZGluZ1RyZW5kc1Jlc3BvbnNlEikKBnRyZW5kcxgBIAMoCzIRLnBiLlNwZW5kaW5nVHJlbmRSBnRyZW5kcw==');
@$core.Deprecated('Use getBudgetAlertsRequestDescriptor instead')
const GetBudgetAlertsRequest$json = const {
  '1': 'GetBudgetAlertsRequest',
  '2': const [
    const {'1': 'unread_only', '3': 1, '4': 1, '5': 8, '10': 'unreadOnly'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetBudgetAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetAlertsRequestDescriptor = $convert.base64Decode('ChZHZXRCdWRnZXRBbGVydHNSZXF1ZXN0Eh8KC3VucmVhZF9vbmx5GAEgASgIUgp1bnJlYWRPbmx5EhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getBudgetAlertsResponseDescriptor instead')
const GetBudgetAlertsResponse$json = const {
  '1': 'GetBudgetAlertsResponse',
  '2': const [
    const {'1': 'alerts', '3': 1, '4': 3, '5': 11, '6': '.pb.BudgetAlertMessage', '10': 'alerts'},
    const {'1': 'unread_count', '3': 2, '4': 1, '5': 5, '10': 'unreadCount'},
  ],
};

/// Descriptor for `GetBudgetAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetAlertsResponseDescriptor = $convert.base64Decode('ChdHZXRCdWRnZXRBbGVydHNSZXNwb25zZRIuCgZhbGVydHMYASADKAsyFi5wYi5CdWRnZXRBbGVydE1lc3NhZ2VSBmFsZXJ0cxIhCgx1bnJlYWRfY291bnQYAiABKAVSC3VucmVhZENvdW50');
@$core.Deprecated('Use markAlertAsReadRequestDescriptor instead')
const MarkAlertAsReadRequest$json = const {
  '1': 'MarkAlertAsReadRequest',
  '2': const [
    const {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
  ],
};

/// Descriptor for `MarkAlertAsReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAlertAsReadRequestDescriptor = $convert.base64Decode('ChZNYXJrQWxlcnRBc1JlYWRSZXF1ZXN0EhkKCGFsZXJ0X2lkGAEgASgJUgdhbGVydElk');
@$core.Deprecated('Use markAlertAsReadResponseDescriptor instead')
const MarkAlertAsReadResponse$json = const {
  '1': 'MarkAlertAsReadResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `MarkAlertAsReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAlertAsReadResponseDescriptor = $convert.base64Decode('ChdNYXJrQWxlcnRBc1JlYWRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use paginationMetadataDescriptor instead')
const PaginationMetadata$json = const {
  '1': 'PaginationMetadata',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    const {'1': 'total_pages', '3': 3, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 4, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `PaginationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationMetadataDescriptor = $convert.base64Decode('ChJQYWdpbmF0aW9uTWV0YWRhdGESIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UGFnZRIZCghwZXJfcGFnZRgCIAEoBVIHcGVyUGFnZRIfCgt0b3RhbF9wYWdlcxgDIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgEIAEoBVIKdG90YWxJdGVtcxIZCghoYXNfbmV4dBgFIAEoCFIHaGFzTmV4dBIZCghoYXNfcHJldhgGIAEoCFIHaGFzUHJldg==');
@$core.Deprecated('Use getAISpendingInsightsRequestDescriptor instead')
const GetAISpendingInsightsRequest$json = const {
  '1': 'GetAISpendingInsightsRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'focus_area', '3': 3, '4': 1, '5': 9, '10': 'focusArea'},
  ],
};

/// Descriptor for `GetAISpendingInsightsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAISpendingInsightsRequestDescriptor = $convert.base64Decode('ChxHZXRBSVNwZW5kaW5nSW5zaWdodHNSZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRlEh0KCmZvY3VzX2FyZWEYAyABKAlSCWZvY3VzQXJlYQ==');
@$core.Deprecated('Use getAISpendingInsightsResponseDescriptor instead')
const GetAISpendingInsightsResponse$json = const {
  '1': 'GetAISpendingInsightsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'summary', '3': 2, '4': 1, '5': 9, '10': 'summary'},
    const {'1': 'insights', '3': 3, '4': 3, '5': 11, '6': '.pb.AIInsight', '10': 'insights'},
    const {'1': 'recommendations', '3': 4, '4': 3, '5': 11, '6': '.pb.AIRecommendation', '10': 'recommendations'},
    const {'1': 'anomalies', '3': 5, '4': 3, '5': 11, '6': '.pb.AnomalyDetection', '10': 'anomalies'},
  ],
};

/// Descriptor for `GetAISpendingInsightsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAISpendingInsightsResponseDescriptor = $convert.base64Decode('Ch1HZXRBSVNwZW5kaW5nSW5zaWdodHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB3N1bW1hcnkYAiABKAlSB3N1bW1hcnkSKQoIaW5zaWdodHMYAyADKAsyDS5wYi5BSUluc2lnaHRSCGluc2lnaHRzEj4KD3JlY29tbWVuZGF0aW9ucxgEIAMoCzIULnBiLkFJUmVjb21tZW5kYXRpb25SD3JlY29tbWVuZGF0aW9ucxIyCglhbm9tYWxpZXMYBSADKAsyFC5wYi5Bbm9tYWx5RGV0ZWN0aW9uUglhbm9tYWxpZXM=');
@$core.Deprecated('Use aIInsightDescriptor instead')
const AIInsight$json = const {
  '1': 'AIInsight',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'insight_type', '3': 3, '4': 1, '5': 9, '10': 'insightType'},
    const {'1': 'impact_amount', '3': 4, '4': 1, '5': 1, '10': 'impactAmount'},
    const {'1': 'supporting_data', '3': 5, '4': 3, '5': 9, '10': 'supportingData'},
  ],
};

/// Descriptor for `AIInsight`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aIInsightDescriptor = $convert.base64Decode('CglBSUluc2lnaHQSFAoFdGl0bGUYASABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhIhCgxpbnNpZ2h0X3R5cGUYAyABKAlSC2luc2lnaHRUeXBlEiMKDWltcGFjdF9hbW91bnQYBCABKAFSDGltcGFjdEFtb3VudBInCg9zdXBwb3J0aW5nX2RhdGEYBSADKAlSDnN1cHBvcnRpbmdEYXRh');
@$core.Deprecated('Use aIRecommendationDescriptor instead')
const AIRecommendation$json = const {
  '1': 'AIRecommendation',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'action', '3': 3, '4': 1, '5': 9, '10': 'action'},
    const {'1': 'potential_savings', '3': 4, '4': 1, '5': 1, '10': 'potentialSavings'},
    const {'1': 'priority', '3': 5, '4': 1, '5': 9, '10': 'priority'},
    const {'1': 'affected_category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'affectedCategory'},
  ],
};

/// Descriptor for `AIRecommendation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aIRecommendationDescriptor = $convert.base64Decode('ChBBSVJlY29tbWVuZGF0aW9uEhQKBXRpdGxlGAEgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgCIAEoCVILZGVzY3JpcHRpb24SFgoGYWN0aW9uGAMgASgJUgZhY3Rpb24SKwoRcG90ZW50aWFsX3NhdmluZ3MYBCABKAFSEHBvdGVudGlhbFNhdmluZ3MSGgoIcHJpb3JpdHkYBSABKAlSCHByaW9yaXR5EkAKEWFmZmVjdGVkX2NhdGVnb3J5GAYgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UhBhZmZlY3RlZENhdGVnb3J5');
@$core.Deprecated('Use anomalyDetectionDescriptor instead')
const AnomalyDetection$json = const {
  '1': 'AnomalyDetection',
  '2': const [
    const {'1': 'anomaly_type', '3': 1, '4': 1, '5': 9, '10': 'anomalyType'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'detected_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'detectedDate'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'category', '3': 5, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'severity', '3': 6, '4': 1, '5': 9, '10': 'severity'},
  ],
};

/// Descriptor for `AnomalyDetection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anomalyDetectionDescriptor = $convert.base64Decode('ChBBbm9tYWx5RGV0ZWN0aW9uEiEKDGFub21hbHlfdHlwZRgBIAEoCVILYW5vbWFseVR5cGUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEj8KDWRldGVjdGVkX2RhdGUYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxkZXRlY3RlZERhdGUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSLwoIY2F0ZWdvcnkYBSABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5EhoKCHNldmVyaXR5GAYgASgJUghzZXZlcml0eQ==');
@$core.Deprecated('Use getAIBudgetingRecommendationsRequestDescriptor instead')
const GetAIBudgetingRecommendationsRequest$json = const {
  '1': 'GetAIBudgetingRecommendationsRequest',
  '2': const [
    const {'1': 'monthly_income', '3': 1, '4': 1, '5': 1, '10': 'monthlyIncome'},
    const {'1': 'financial_goals', '3': 2, '4': 3, '5': 9, '10': 'financialGoals'},
    const {'1': 'risk_tolerance', '3': 3, '4': 1, '5': 9, '10': 'riskTolerance'},
  ],
};

/// Descriptor for `GetAIBudgetingRecommendationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIBudgetingRecommendationsRequestDescriptor = $convert.base64Decode('CiRHZXRBSUJ1ZGdldGluZ1JlY29tbWVuZGF0aW9uc1JlcXVlc3QSJQoObW9udGhseV9pbmNvbWUYASABKAFSDW1vbnRobHlJbmNvbWUSJwoPZmluYW5jaWFsX2dvYWxzGAIgAygJUg5maW5hbmNpYWxHb2FscxIlCg5yaXNrX3RvbGVyYW5jZRgDIAEoCVINcmlza1RvbGVyYW5jZQ==');
@$core.Deprecated('Use getAIBudgetingRecommendationsResponseDescriptor instead')
const GetAIBudgetingRecommendationsResponse$json = const {
  '1': 'GetAIBudgetingRecommendationsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'summary', '3': 2, '4': 1, '5': 9, '10': 'summary'},
    const {'1': 'budget_recommendations', '3': 3, '4': 3, '5': 11, '6': '.pb.BudgetRecommendation', '10': 'budgetRecommendations'},
    const {'1': 'recommended_savings_rate', '3': 4, '4': 1, '5': 1, '10': 'recommendedSavingsRate'},
    const {'1': 'rationale', '3': 5, '4': 1, '5': 9, '10': 'rationale'},
  ],
};

/// Descriptor for `GetAIBudgetingRecommendationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIBudgetingRecommendationsResponseDescriptor = $convert.base64Decode('CiVHZXRBSUJ1ZGdldGluZ1JlY29tbWVuZGF0aW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHc3VtbWFyeRgCIAEoCVIHc3VtbWFyeRJPChZidWRnZXRfcmVjb21tZW5kYXRpb25zGAMgAygLMhgucGIuQnVkZ2V0UmVjb21tZW5kYXRpb25SFWJ1ZGdldFJlY29tbWVuZGF0aW9ucxI4ChhyZWNvbW1lbmRlZF9zYXZpbmdzX3JhdGUYBCABKAFSFnJlY29tbWVuZGVkU2F2aW5nc1JhdGUSHAoJcmF0aW9uYWxlGAUgASgJUglyYXRpb25hbGU=');
@$core.Deprecated('Use budgetRecommendationDescriptor instead')
const BudgetRecommendation$json = const {
  '1': 'BudgetRecommendation',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    const {'1': 'recommended_amount', '3': 3, '4': 1, '5': 1, '10': 'recommendedAmount'},
    const {'1': 'current_amount', '3': 4, '4': 1, '5': 1, '10': 'currentAmount'},
    const {'1': 'difference', '3': 5, '4': 1, '5': 1, '10': 'difference'},
    const {'1': 'reasoning', '3': 6, '4': 1, '5': 9, '10': 'reasoning'},
    const {'1': 'recommended_period', '3': 7, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'recommendedPeriod'},
  ],
};

/// Descriptor for `BudgetRecommendation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetRecommendationDescriptor = $convert.base64Decode('ChRCdWRnZXRSZWNvbW1lbmRhdGlvbhIvCghjYXRlZ29yeRgBIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVIIY2F0ZWdvcnkSIwoNY2F0ZWdvcnlfbmFtZRgCIAEoCVIMY2F0ZWdvcnlOYW1lEi0KEnJlY29tbWVuZGVkX2Ftb3VudBgDIAEoAVIRcmVjb21tZW5kZWRBbW91bnQSJQoOY3VycmVudF9hbW91bnQYBCABKAFSDWN1cnJlbnRBbW91bnQSHgoKZGlmZmVyZW5jZRgFIAEoAVIKZGlmZmVyZW5jZRIcCglyZWFzb25pbmcYBiABKAlSCXJlYXNvbmluZxI/ChJyZWNvbW1lbmRlZF9wZXJpb2QYByABKA4yEC5wYi5CdWRnZXRQZXJpb2RSEXJlY29tbWVuZGVkUGVyaW9k');
@$core.Deprecated('Use autoCategorizeExpenseRequestDescriptor instead')
const AutoCategorizeExpenseRequest$json = const {
  '1': 'AutoCategorizeExpenseRequest',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'merchant', '3': 2, '4': 1, '5': 9, '10': 'merchant'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `AutoCategorizeExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoCategorizeExpenseRequestDescriptor = $convert.base64Decode('ChxBdXRvQ2F0ZWdvcml6ZUV4cGVuc2VSZXF1ZXN0EiAKC2Rlc2NyaXB0aW9uGAEgASgJUgtkZXNjcmlwdGlvbhIaCghtZXJjaGFudBgCIAEoCVIIbWVyY2hhbnQSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSFAoFbm90ZXMYBCABKAlSBW5vdGVz');
@$core.Deprecated('Use autoCategorizeExpenseResponseDescriptor instead')
const AutoCategorizeExpenseResponse$json = const {
  '1': 'AutoCategorizeExpenseResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'suggested_category', '3': 2, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'suggestedCategory'},
    const {'1': 'category_name', '3': 3, '4': 1, '5': 9, '10': 'categoryName'},
    const {'1': 'confidence_score', '3': 4, '4': 1, '5': 1, '10': 'confidenceScore'},
    const {'1': 'alternative_categories', '3': 5, '4': 3, '5': 11, '6': '.pb.CategorySuggestion', '10': 'alternativeCategories'},
    const {'1': 'reasoning', '3': 6, '4': 1, '5': 9, '10': 'reasoning'},
  ],
};

/// Descriptor for `AutoCategorizeExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoCategorizeExpenseResponseDescriptor = $convert.base64Decode('Ch1BdXRvQ2F0ZWdvcml6ZUV4cGVuc2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEkIKEnN1Z2dlc3RlZF9jYXRlZ29yeRgCIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVIRc3VnZ2VzdGVkQ2F0ZWdvcnkSIwoNY2F0ZWdvcnlfbmFtZRgDIAEoCVIMY2F0ZWdvcnlOYW1lEikKEGNvbmZpZGVuY2Vfc2NvcmUYBCABKAFSD2NvbmZpZGVuY2VTY29yZRJNChZhbHRlcm5hdGl2ZV9jYXRlZ29yaWVzGAUgAygLMhYucGIuQ2F0ZWdvcnlTdWdnZXN0aW9uUhVhbHRlcm5hdGl2ZUNhdGVnb3JpZXMSHAoJcmVhc29uaW5nGAYgASgJUglyZWFzb25pbmc=');
@$core.Deprecated('Use categorySuggestionDescriptor instead')
const CategorySuggestion$json = const {
  '1': 'CategorySuggestion',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    const {'1': 'confidence_score', '3': 3, '4': 1, '5': 1, '10': 'confidenceScore'},
  ],
};

/// Descriptor for `CategorySuggestion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categorySuggestionDescriptor = $convert.base64Decode('ChJDYXRlZ29yeVN1Z2dlc3Rpb24SLwoIY2F0ZWdvcnkYASABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5EiMKDWNhdGVnb3J5X25hbWUYAiABKAlSDGNhdGVnb3J5TmFtZRIpChBjb25maWRlbmNlX3Njb3JlGAMgASgBUg9jb25maWRlbmNlU2NvcmU=');
@$core.Deprecated('Use getAIFinancialAdviceRequestDescriptor instead')
const GetAIFinancialAdviceRequest$json = const {
  '1': 'GetAIFinancialAdviceRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'context_areas', '3': 2, '4': 3, '5': 9, '10': 'contextAreas'},
  ],
};

/// Descriptor for `GetAIFinancialAdviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIFinancialAdviceRequestDescriptor = $convert.base64Decode('ChtHZXRBSUZpbmFuY2lhbEFkdmljZVJlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EiMKDWNvbnRleHRfYXJlYXMYAiADKAlSDGNvbnRleHRBcmVhcw==');
@$core.Deprecated('Use getAIFinancialAdviceResponseDescriptor instead')
const GetAIFinancialAdviceResponse$json = const {
  '1': 'GetAIFinancialAdviceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'advice', '3': 3, '4': 1, '5': 9, '10': 'advice'},
    const {'1': 'action_steps', '3': 4, '4': 3, '5': 11, '6': '.pb.ActionStep', '10': 'actionSteps'},
    const {'1': 'relevant_resources', '3': 5, '4': 3, '5': 9, '10': 'relevantResources'},
    const {'1': 'disclaimer', '3': 6, '4': 1, '5': 9, '10': 'disclaimer'},
  ],
};

/// Descriptor for `GetAIFinancialAdviceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIFinancialAdviceResponseDescriptor = $convert.base64Decode('ChxHZXRBSUZpbmFuY2lhbEFkdmljZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSFAoFcXVlcnkYAiABKAlSBXF1ZXJ5EhYKBmFkdmljZRgDIAEoCVIGYWR2aWNlEjEKDGFjdGlvbl9zdGVwcxgEIAMoCzIOLnBiLkFjdGlvblN0ZXBSC2FjdGlvblN0ZXBzEi0KEnJlbGV2YW50X3Jlc291cmNlcxgFIAMoCVIRcmVsZXZhbnRSZXNvdXJjZXMSHgoKZGlzY2xhaW1lchgGIAEoCVIKZGlzY2xhaW1lcg==');
@$core.Deprecated('Use actionStepDescriptor instead')
const ActionStep$json = const {
  '1': 'ActionStep',
  '2': const [
    const {'1': 'step_number', '3': 1, '4': 1, '5': 5, '10': 'stepNumber'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'estimated_impact', '3': 4, '4': 1, '5': 9, '10': 'estimatedImpact'},
    const {'1': 'is_completed', '3': 5, '4': 1, '5': 8, '10': 'isCompleted'},
  ],
};

/// Descriptor for `ActionStep`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionStepDescriptor = $convert.base64Decode('CgpBY3Rpb25TdGVwEh8KC3N0ZXBfbnVtYmVyGAEgASgFUgpzdGVwTnVtYmVyEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SKQoQZXN0aW1hdGVkX2ltcGFjdBgEIAEoCVIPZXN0aW1hdGVkSW1wYWN0EiEKDGlzX2NvbXBsZXRlZBgFIAEoCFILaXNDb21wbGV0ZWQ=');
@$core.Deprecated('Use incomeSourceDescriptor instead')
const IncomeSource$json = const {
  '1': 'IncomeSource',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.IncomeCategory', '10': 'category'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_pattern', '3': 8, '4': 1, '5': 9, '10': 'recurrencePattern'},
    const {'1': 'last_received', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastReceived'},
    const {'1': 'next_expected', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextExpected'},
    const {'1': 'is_active', '3': 11, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `IncomeSource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomeSourceDescriptor = $convert.base64Decode('CgxJbmNvbWVTb3VyY2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKARSBnVzZXJJZBISCgRuYW1lGAMgASgJUgRuYW1lEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIuCghjYXRlZ29yeRgGIAEoDjISLnBiLkluY29tZUNhdGVnb3J5UghjYXRlZ29yeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEi0KEnJlY3VycmVuY2VfcGF0dGVybhgIIAEoCVIRcmVjdXJyZW5jZVBhdHRlcm4SPwoNbGFzdF9yZWNlaXZlZBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGxhc3RSZWNlaXZlZBI/Cg1uZXh0X2V4cGVjdGVkGAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMbmV4dEV4cGVjdGVkEhsKCWlzX2FjdGl2ZRgLIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use incomeBreakdownDescriptor instead')
const IncomeBreakdown$json = const {
  '1': 'IncomeBreakdown',
  '2': const [
    const {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.pb.IncomeCategoryData', '10': 'categories'},
    const {'1': 'total_income', '3': 2, '4': 1, '5': 1, '10': 'totalIncome'},
    const {'1': 'period', '3': 3, '4': 1, '5': 9, '10': 'period'},
  ],
};

/// Descriptor for `IncomeBreakdown`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomeBreakdownDescriptor = $convert.base64Decode('Cg9JbmNvbWVCcmVha2Rvd24SNgoKY2F0ZWdvcmllcxgBIAMoCzIWLnBiLkluY29tZUNhdGVnb3J5RGF0YVIKY2F0ZWdvcmllcxIhCgx0b3RhbF9pbmNvbWUYAiABKAFSC3RvdGFsSW5jb21lEhYKBnBlcmlvZBgDIAEoCVIGcGVyaW9k');
@$core.Deprecated('Use incomeCategoryDataDescriptor instead')
const IncomeCategoryData$json = const {
  '1': 'IncomeCategoryData',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.IncomeCategory', '10': 'category'},
    const {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
    const {'1': 'source_count', '3': 5, '4': 1, '5': 5, '10': 'sourceCount'},
  ],
};

/// Descriptor for `IncomeCategoryData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomeCategoryDataDescriptor = $convert.base64Decode('ChJJbmNvbWVDYXRlZ29yeURhdGESLgoIY2F0ZWdvcnkYASABKA4yEi5wYi5JbmNvbWVDYXRlZ29yeVIIY2F0ZWdvcnkSIwoNY2F0ZWdvcnlfbmFtZRgCIAEoCVIMY2F0ZWdvcnlOYW1lEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50Eh4KCnBlcmNlbnRhZ2UYBCABKAFSCnBlcmNlbnRhZ2USIQoMc291cmNlX2NvdW50GAUgASgFUgtzb3VyY2VDb3VudA==');
@$core.Deprecated('Use investmentDescriptor instead')
const Investment$json = const {
  '1': 'Investment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'investment_type', '3': 4, '4': 1, '5': 14, '6': '.pb.InvestmentType', '10': 'investmentType'},
    const {'1': 'current_value', '3': 5, '4': 1, '5': 1, '10': 'currentValue'},
    const {'1': 'initial_investment', '3': 6, '4': 1, '5': 1, '10': 'initialInvestment'},
    const {'1': 'gain_loss', '3': 7, '4': 1, '5': 1, '10': 'gainLoss'},
    const {'1': 'gain_loss_percentage', '3': 8, '4': 1, '5': 1, '10': 'gainLossPercentage'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'purchase_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'purchaseDate'},
    const {'1': 'last_updated', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    const {'1': 'ticker_symbol', '3': 12, '4': 1, '5': 9, '10': 'tickerSymbol'},
    const {'1': 'quantity', '3': 13, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'current_price', '3': 14, '4': 1, '5': 1, '10': 'currentPrice'},
  ],
};

/// Descriptor for `Investment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentDescriptor = $convert.base64Decode('CgpJbnZlc3RtZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRI7Cg9pbnZlc3RtZW50X3R5cGUYBCABKA4yEi5wYi5JbnZlc3RtZW50VHlwZVIOaW52ZXN0bWVudFR5cGUSIwoNY3VycmVudF92YWx1ZRgFIAEoAVIMY3VycmVudFZhbHVlEi0KEmluaXRpYWxfaW52ZXN0bWVudBgGIAEoAVIRaW5pdGlhbEludmVzdG1lbnQSGwoJZ2Fpbl9sb3NzGAcgASgBUghnYWluTG9zcxIwChRnYWluX2xvc3NfcGVyY2VudGFnZRgIIAEoAVISZ2Fpbkxvc3NQZXJjZW50YWdlEhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRI/Cg1wdXJjaGFzZV9kYXRlGAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcHVyY2hhc2VEYXRlEj0KDGxhc3RfdXBkYXRlZBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RVcGRhdGVkEiMKDXRpY2tlcl9zeW1ib2wYDCABKAlSDHRpY2tlclN5bWJvbBIaCghxdWFudGl0eRgNIAEoBVIIcXVhbnRpdHkSIwoNY3VycmVudF9wcmljZRgOIAEoAVIMY3VycmVudFByaWNl');
@$core.Deprecated('Use investmentPortfolioDescriptor instead')
const InvestmentPortfolio$json = const {
  '1': 'InvestmentPortfolio',
  '2': const [
    const {'1': 'investments', '3': 1, '4': 3, '5': 11, '6': '.pb.InvestmentTypeData', '10': 'investments'},
    const {'1': 'total_value', '3': 2, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    const {'1': 'total_gain_loss', '3': 4, '4': 1, '5': 1, '10': 'totalGainLoss'},
    const {'1': 'total_gain_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'totalGainLossPercentage'},
  ],
};

/// Descriptor for `InvestmentPortfolio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentPortfolioDescriptor = $convert.base64Decode('ChNJbnZlc3RtZW50UG9ydGZvbGlvEjgKC2ludmVzdG1lbnRzGAEgAygLMhYucGIuSW52ZXN0bWVudFR5cGVEYXRhUgtpbnZlc3RtZW50cxIfCgt0b3RhbF92YWx1ZRgCIAEoAVIKdG90YWxWYWx1ZRIlCg50b3RhbF9pbnZlc3RlZBgDIAEoAVINdG90YWxJbnZlc3RlZBImCg90b3RhbF9nYWluX2xvc3MYBCABKAFSDXRvdGFsR2Fpbkxvc3MSOwoadG90YWxfZ2Fpbl9sb3NzX3BlcmNlbnRhZ2UYBSABKAFSF3RvdGFsR2Fpbkxvc3NQZXJjZW50YWdl');
@$core.Deprecated('Use investmentTypeDataDescriptor instead')
const InvestmentTypeData$json = const {
  '1': 'InvestmentTypeData',
  '2': const [
    const {'1': 'investment_type', '3': 1, '4': 1, '5': 14, '6': '.pb.InvestmentType', '10': 'investmentType'},
    const {'1': 'type_name', '3': 2, '4': 1, '5': 9, '10': 'typeName'},
    const {'1': 'current_value', '3': 3, '4': 1, '5': 1, '10': 'currentValue'},
    const {'1': 'gain_loss', '3': 4, '4': 1, '5': 1, '10': 'gainLoss'},
    const {'1': 'gain_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'gainLossPercentage'},
    const {'1': 'asset_count', '3': 6, '4': 1, '5': 5, '10': 'assetCount'},
  ],
};

/// Descriptor for `InvestmentTypeData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentTypeDataDescriptor = $convert.base64Decode('ChJJbnZlc3RtZW50VHlwZURhdGESOwoPaW52ZXN0bWVudF90eXBlGAEgASgOMhIucGIuSW52ZXN0bWVudFR5cGVSDmludmVzdG1lbnRUeXBlEhsKCXR5cGVfbmFtZRgCIAEoCVIIdHlwZU5hbWUSIwoNY3VycmVudF92YWx1ZRgDIAEoAVIMY3VycmVudFZhbHVlEhsKCWdhaW5fbG9zcxgEIAEoAVIIZ2Fpbkxvc3MSMAoUZ2Fpbl9sb3NzX3BlcmNlbnRhZ2UYBSABKAFSEmdhaW5Mb3NzUGVyY2VudGFnZRIfCgthc3NldF9jb3VudBgGIAEoBVIKYXNzZXRDb3VudA==');
@$core.Deprecated('Use financialGoalDescriptor instead')
const FinancialGoal$json = const {
  '1': 'FinancialGoal',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'goal_type', '3': 4, '4': 1, '5': 14, '6': '.pb.GoalType', '10': 'goalType'},
    const {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 6, '4': 1, '5': 1, '10': 'currentAmount'},
    const {'1': 'monthly_contribution', '3': 7, '4': 1, '5': 1, '10': 'monthlyContribution'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'target_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.GoalStatus', '10': 'status'},
    const {'1': 'percentage_complete', '3': 11, '4': 1, '5': 1, '10': 'percentageComplete'},
    const {'1': 'months_remaining', '3': 12, '4': 1, '5': 5, '10': 'monthsRemaining'},
    const {'1': 'icon', '3': 13, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'color', '3': 14, '4': 1, '5': 9, '10': 'color'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `FinancialGoal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List financialGoalDescriptor = $convert.base64Decode('Cg1GaW5hbmNpYWxHb2FsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIpCglnb2FsX3R5cGUYBCABKA4yDC5wYi5Hb2FsVHlwZVIIZ29hbFR5cGUSIwoNdGFyZ2V0X2Ftb3VudBgFIAEoAVIMdGFyZ2V0QW1vdW50EiUKDmN1cnJlbnRfYW1vdW50GAYgASgBUg1jdXJyZW50QW1vdW50EjEKFG1vbnRobHlfY29udHJpYnV0aW9uGAcgASgBUhNtb250aGx5Q29udHJpYnV0aW9uEhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRI7Cgt0YXJnZXRfZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnRhcmdldERhdGUSJgoGc3RhdHVzGAogASgOMg4ucGIuR29hbFN0YXR1c1IGc3RhdHVzEi8KE3BlcmNlbnRhZ2VfY29tcGxldGUYCyABKAFSEnBlcmNlbnRhZ2VDb21wbGV0ZRIpChBtb250aHNfcmVtYWluaW5nGAwgASgFUg9tb250aHNSZW1haW5pbmcSEgoEaWNvbhgNIAEoCVIEaWNvbhIUCgVjb2xvchgOIAEoCVIFY29sb3ISOQoKY3JlYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use financialGoalsListDescriptor instead')
const FinancialGoalsList$json = const {
  '1': 'FinancialGoalsList',
  '2': const [
    const {'1': 'goals', '3': 1, '4': 3, '5': 11, '6': '.pb.FinancialGoal', '10': 'goals'},
    const {'1': 'total_target', '3': 2, '4': 1, '5': 1, '10': 'totalTarget'},
    const {'1': 'total_saved', '3': 3, '4': 1, '5': 1, '10': 'totalSaved'},
    const {'1': 'active_goals_count', '3': 4, '4': 1, '5': 5, '10': 'activeGoalsCount'},
  ],
};

/// Descriptor for `FinancialGoalsList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List financialGoalsListDescriptor = $convert.base64Decode('ChJGaW5hbmNpYWxHb2Fsc0xpc3QSJwoFZ29hbHMYASADKAsyES5wYi5GaW5hbmNpYWxHb2FsUgVnb2FscxIhCgx0b3RhbF90YXJnZXQYAiABKAFSC3RvdGFsVGFyZ2V0Eh8KC3RvdGFsX3NhdmVkGAMgASgBUgp0b3RhbFNhdmVkEiwKEmFjdGl2ZV9nb2Fsc19jb3VudBgEIAEoBVIQYWN0aXZlR29hbHNDb3VudA==');
@$core.Deprecated('Use savingsGoalDescriptor instead')
const SavingsGoal$json = const {
  '1': 'SavingsGoal',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'target_amount', '3': 4, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 5, '4': 1, '5': 1, '10': 'currentAmount'},
    const {'1': 'percentage_complete', '3': 6, '4': 1, '5': 1, '10': 'percentageComplete'},
    const {'1': 'target_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `SavingsGoal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List savingsGoalDescriptor = $convert.base64Decode('CgtTYXZpbmdzR29hbBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoBFIGdXNlcklkEhIKBG5hbWUYAyABKAlSBG5hbWUSIwoNdGFyZ2V0X2Ftb3VudBgEIAEoAVIMdGFyZ2V0QW1vdW50EiUKDmN1cnJlbnRfYW1vdW50GAUgASgBUg1jdXJyZW50QW1vdW50Ei8KE3BlcmNlbnRhZ2VfY29tcGxldGUYBiABKAFSEnBlcmNlbnRhZ2VDb21wbGV0ZRI7Cgt0YXJnZXRfZGF0ZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnRhcmdldERhdGUSOQoKY3JlYXRlZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use recurringBillDescriptor instead')
const RecurringBill$json = const {
  '1': 'RecurringBill',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'recurrence_pattern', '3': 7, '4': 1, '5': 9, '10': 'recurrencePattern'},
    const {'1': 'next_due_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextDueDate'},
    const {'1': 'last_paid_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastPaidDate'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.BillStatus', '10': 'status'},
    const {'1': 'days_until_due', '3': 11, '4': 1, '5': 5, '10': 'daysUntilDue'},
    const {'1': 'merchant', '3': 12, '4': 1, '5': 9, '10': 'merchant'},
    const {'1': 'icon', '3': 13, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'auto_pay_enabled', '3': 14, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `RecurringBill`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringBillDescriptor = $convert.base64Decode('Cg1SZWN1cnJpbmdCaWxsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSLwoIY2F0ZWdvcnkYBiABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5Ei0KEnJlY3VycmVuY2VfcGF0dGVybhgHIAEoCVIRcmVjdXJyZW5jZVBhdHRlcm4SPgoNbmV4dF9kdWVfZGF0ZRgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC25leHREdWVEYXRlEkAKDmxhc3RfcGFpZF9kYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMbGFzdFBhaWREYXRlEiYKBnN0YXR1cxgKIAEoDjIOLnBiLkJpbGxTdGF0dXNSBnN0YXR1cxIkCg5kYXlzX3VudGlsX2R1ZRgLIAEoBVIMZGF5c1VudGlsRHVlEhoKCG1lcmNoYW50GAwgASgJUghtZXJjaGFudBISCgRpY29uGA0gASgJUgRpY29uEigKEGF1dG9fcGF5X2VuYWJsZWQYDiABKAhSDmF1dG9QYXlFbmFibGVkEjkKCmNyZWF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgQIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use upcomingBillsListDescriptor instead')
const UpcomingBillsList$json = const {
  '1': 'UpcomingBillsList',
  '2': const [
    const {'1': 'bills', '3': 1, '4': 3, '5': 11, '6': '.pb.RecurringBill', '10': 'bills'},
    const {'1': 'total_upcoming', '3': 2, '4': 1, '5': 1, '10': 'totalUpcoming'},
    const {'1': 'bills_count', '3': 3, '4': 1, '5': 5, '10': 'billsCount'},
  ],
};

/// Descriptor for `UpcomingBillsList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upcomingBillsListDescriptor = $convert.base64Decode('ChFVcGNvbWluZ0JpbGxzTGlzdBInCgViaWxscxgBIAMoCzIRLnBiLlJlY3VycmluZ0JpbGxSBWJpbGxzEiUKDnRvdGFsX3VwY29taW5nGAIgASgBUg10b3RhbFVwY29taW5nEh8KC2JpbGxzX2NvdW50GAMgASgFUgpiaWxsc0NvdW50');
@$core.Deprecated('Use createIncomeSourceRequestDescriptor instead')
const CreateIncomeSourceRequest$json = const {
  '1': 'CreateIncomeSourceRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.IncomeCategory', '10': 'category'},
    const {'1': 'is_recurring', '3': 5, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_pattern', '3': 6, '4': 1, '5': 9, '10': 'recurrencePattern'},
    const {'1': 'last_received', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastReceived'},
    const {'1': 'next_expected', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextExpected'},
  ],
};

/// Descriptor for `CreateIncomeSourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIncomeSourceRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVJbmNvbWVTb3VyY2VSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5Ei4KCGNhdGVnb3J5GAQgASgOMhIucGIuSW5jb21lQ2F0ZWdvcnlSCGNhdGVnb3J5EiEKDGlzX3JlY3VycmluZxgFIAEoCFILaXNSZWN1cnJpbmcSLQoScmVjdXJyZW5jZV9wYXR0ZXJuGAYgASgJUhFyZWN1cnJlbmNlUGF0dGVybhI/Cg1sYXN0X3JlY2VpdmVkGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMbGFzdFJlY2VpdmVkEj8KDW5leHRfZXhwZWN0ZWQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxuZXh0RXhwZWN0ZWQ=');
@$core.Deprecated('Use createIncomeSourceResponseDescriptor instead')
const CreateIncomeSourceResponse$json = const {
  '1': 'CreateIncomeSourceResponse',
  '2': const [
    const {'1': 'income_source', '3': 1, '4': 1, '5': 11, '6': '.pb.IncomeSource', '10': 'incomeSource'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateIncomeSourceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIncomeSourceResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVJbmNvbWVTb3VyY2VSZXNwb25zZRI1Cg1pbmNvbWVfc291cmNlGAEgASgLMhAucGIuSW5jb21lU291cmNlUgxpbmNvbWVTb3VyY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getIncomeSourcesRequestDescriptor instead')
const GetIncomeSourcesRequest$json = const {
  '1': 'GetIncomeSourcesRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetIncomeSourcesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeSourcesRequestDescriptor = $convert.base64Decode('ChdHZXRJbmNvbWVTb3VyY2VzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aXZlT25seQ==');
@$core.Deprecated('Use getIncomeSourcesResponseDescriptor instead')
const GetIncomeSourcesResponse$json = const {
  '1': 'GetIncomeSourcesResponse',
  '2': const [
    const {'1': 'income_sources', '3': 1, '4': 3, '5': 11, '6': '.pb.IncomeSource', '10': 'incomeSources'},
    const {'1': 'total_monthly_income', '3': 2, '4': 1, '5': 1, '10': 'totalMonthlyIncome'},
  ],
};

/// Descriptor for `GetIncomeSourcesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeSourcesResponseDescriptor = $convert.base64Decode('ChhHZXRJbmNvbWVTb3VyY2VzUmVzcG9uc2USNwoOaW5jb21lX3NvdXJjZXMYASADKAsyEC5wYi5JbmNvbWVTb3VyY2VSDWluY29tZVNvdXJjZXMSMAoUdG90YWxfbW9udGhseV9pbmNvbWUYAiABKAFSEnRvdGFsTW9udGhseUluY29tZQ==');
@$core.Deprecated('Use getIncomeBreakdownRequestDescriptor instead')
const GetIncomeBreakdownRequest$json = const {
  '1': 'GetIncomeBreakdownRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetIncomeBreakdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeBreakdownRequestDescriptor = $convert.base64Decode('ChlHZXRJbmNvbWVCcmVha2Rvd25SZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl');
@$core.Deprecated('Use getIncomeBreakdownResponseDescriptor instead')
const GetIncomeBreakdownResponse$json = const {
  '1': 'GetIncomeBreakdownResponse',
  '2': const [
    const {'1': 'breakdown', '3': 1, '4': 1, '5': 11, '6': '.pb.IncomeBreakdown', '10': 'breakdown'},
  ],
};

/// Descriptor for `GetIncomeBreakdownResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeBreakdownResponseDescriptor = $convert.base64Decode('ChpHZXRJbmNvbWVCcmVha2Rvd25SZXNwb25zZRIxCglicmVha2Rvd24YASABKAsyEy5wYi5JbmNvbWVCcmVha2Rvd25SCWJyZWFrZG93bg==');
@$core.Deprecated('Use getInvestmentPortfolioRequestDescriptor instead')
const GetInvestmentPortfolioRequest$json = const {
  '1': 'GetInvestmentPortfolioRequest',
};

/// Descriptor for `GetInvestmentPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentPortfolioRequestDescriptor = $convert.base64Decode('Ch1HZXRJbnZlc3RtZW50UG9ydGZvbGlvUmVxdWVzdA==');
@$core.Deprecated('Use getInvestmentPortfolioResponseDescriptor instead')
const GetInvestmentPortfolioResponse$json = const {
  '1': 'GetInvestmentPortfolioResponse',
  '2': const [
    const {'1': 'portfolio', '3': 1, '4': 1, '5': 11, '6': '.pb.InvestmentPortfolio', '10': 'portfolio'},
    const {'1': 'individual_investments', '3': 2, '4': 3, '5': 11, '6': '.pb.Investment', '10': 'individualInvestments'},
  ],
};

/// Descriptor for `GetInvestmentPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentPortfolioResponseDescriptor = $convert.base64Decode('Ch5HZXRJbnZlc3RtZW50UG9ydGZvbGlvUmVzcG9uc2USNQoJcG9ydGZvbGlvGAEgASgLMhcucGIuSW52ZXN0bWVudFBvcnRmb2xpb1IJcG9ydGZvbGlvEkUKFmluZGl2aWR1YWxfaW52ZXN0bWVudHMYAiADKAsyDi5wYi5JbnZlc3RtZW50UhVpbmRpdmlkdWFsSW52ZXN0bWVudHM=');
@$core.Deprecated('Use createInvestmentRequestDescriptor instead')
const CreateInvestmentRequest$json = const {
  '1': 'CreateInvestmentRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'investment_type', '3': 2, '4': 1, '5': 14, '6': '.pb.InvestmentType', '10': 'investmentType'},
    const {'1': 'initial_investment', '3': 3, '4': 1, '5': 1, '10': 'initialInvestment'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'purchase_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'purchaseDate'},
    const {'1': 'ticker_symbol', '3': 6, '4': 1, '5': 9, '10': 'tickerSymbol'},
    const {'1': 'quantity', '3': 7, '4': 1, '5': 5, '10': 'quantity'},
  ],
};

/// Descriptor for `CreateInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentRequestDescriptor = $convert.base64Decode('ChdDcmVhdGVJbnZlc3RtZW50UmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEjsKD2ludmVzdG1lbnRfdHlwZRgCIAEoDjISLnBiLkludmVzdG1lbnRUeXBlUg5pbnZlc3RtZW50VHlwZRItChJpbml0aWFsX2ludmVzdG1lbnQYAyABKAFSEWluaXRpYWxJbnZlc3RtZW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRI/Cg1wdXJjaGFzZV9kYXRlGAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcHVyY2hhc2VEYXRlEiMKDXRpY2tlcl9zeW1ib2wYBiABKAlSDHRpY2tlclN5bWJvbBIaCghxdWFudGl0eRgHIAEoBVIIcXVhbnRpdHk=');
@$core.Deprecated('Use createInvestmentResponseDescriptor instead')
const CreateInvestmentResponse$json = const {
  '1': 'CreateInvestmentResponse',
  '2': const [
    const {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.pb.Investment', '10': 'investment'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentResponseDescriptor = $convert.base64Decode('ChhDcmVhdGVJbnZlc3RtZW50UmVzcG9uc2USLgoKaW52ZXN0bWVudBgBIAEoCzIOLnBiLkludmVzdG1lbnRSCmludmVzdG1lbnQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use createFinancialGoalRequestDescriptor instead')
const CreateFinancialGoalRequest$json = const {
  '1': 'CreateFinancialGoalRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'goal_type', '3': 2, '4': 1, '5': 14, '6': '.pb.GoalType', '10': 'goalType'},
    const {'1': 'target_amount', '3': 3, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 4, '4': 1, '5': 1, '10': 'currentAmount'},
    const {'1': 'monthly_contribution', '3': 5, '4': 1, '5': 1, '10': 'monthlyContribution'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'target_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
    const {'1': 'icon', '3': 8, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'color', '3': 9, '4': 1, '5': 9, '10': 'color'},
  ],
};

/// Descriptor for `CreateFinancialGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFinancialGoalRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVGaW5hbmNpYWxHb2FsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEikKCWdvYWxfdHlwZRgCIAEoDjIMLnBiLkdvYWxUeXBlUghnb2FsVHlwZRIjCg10YXJnZXRfYW1vdW50GAMgASgBUgx0YXJnZXRBbW91bnQSJQoOY3VycmVudF9hbW91bnQYBCABKAFSDWN1cnJlbnRBbW91bnQSMQoUbW9udGhseV9jb250cmlidXRpb24YBSABKAFSE21vbnRobHlDb250cmlidXRpb24SGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EjsKC3RhcmdldF9kYXRlGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdGFyZ2V0RGF0ZRISCgRpY29uGAggASgJUgRpY29uEhQKBWNvbG9yGAkgASgJUgVjb2xvcg==');
@$core.Deprecated('Use createFinancialGoalResponseDescriptor instead')
const CreateFinancialGoalResponse$json = const {
  '1': 'CreateFinancialGoalResponse',
  '2': const [
    const {'1': 'goal', '3': 1, '4': 1, '5': 11, '6': '.pb.FinancialGoal', '10': 'goal'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateFinancialGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFinancialGoalResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVGaW5hbmNpYWxHb2FsUmVzcG9uc2USJQoEZ29hbBgBIAEoCzIRLnBiLkZpbmFuY2lhbEdvYWxSBGdvYWwSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getFinancialGoalsRequestDescriptor instead')
const GetFinancialGoalsRequest$json = const {
  '1': 'GetFinancialGoalsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.pb.GoalStatus', '10': 'status'},
  ],
};

/// Descriptor for `GetFinancialGoalsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialGoalsRequestDescriptor = $convert.base64Decode('ChhHZXRGaW5hbmNpYWxHb2Fsc1JlcXVlc3QSJgoGc3RhdHVzGAEgASgOMg4ucGIuR29hbFN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use getFinancialGoalsResponseDescriptor instead')
const GetFinancialGoalsResponse$json = const {
  '1': 'GetFinancialGoalsResponse',
  '2': const [
    const {'1': 'goals_list', '3': 1, '4': 1, '5': 11, '6': '.pb.FinancialGoalsList', '10': 'goalsList'},
  ],
};

/// Descriptor for `GetFinancialGoalsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialGoalsResponseDescriptor = $convert.base64Decode('ChlHZXRGaW5hbmNpYWxHb2Fsc1Jlc3BvbnNlEjUKCmdvYWxzX2xpc3QYASABKAsyFi5wYi5GaW5hbmNpYWxHb2Fsc0xpc3RSCWdvYWxzTGlzdA==');
@$core.Deprecated('Use updateFinancialGoalProgressRequestDescriptor instead')
const UpdateFinancialGoalProgressRequest$json = const {
  '1': 'UpdateFinancialGoalProgressRequest',
  '2': const [
    const {'1': 'goal_id', '3': 1, '4': 1, '5': 9, '10': 'goalId'},
    const {'1': 'amount_to_add', '3': 2, '4': 1, '5': 1, '10': 'amountToAdd'},
  ],
};

/// Descriptor for `UpdateFinancialGoalProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFinancialGoalProgressRequestDescriptor = $convert.base64Decode('CiJVcGRhdGVGaW5hbmNpYWxHb2FsUHJvZ3Jlc3NSZXF1ZXN0EhcKB2dvYWxfaWQYASABKAlSBmdvYWxJZBIiCg1hbW91bnRfdG9fYWRkGAIgASgBUgthbW91bnRUb0FkZA==');
@$core.Deprecated('Use updateFinancialGoalProgressResponseDescriptor instead')
const UpdateFinancialGoalProgressResponse$json = const {
  '1': 'UpdateFinancialGoalProgressResponse',
  '2': const [
    const {'1': 'goal', '3': 1, '4': 1, '5': 11, '6': '.pb.FinancialGoal', '10': 'goal'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateFinancialGoalProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFinancialGoalProgressResponseDescriptor = $convert.base64Decode('CiNVcGRhdGVGaW5hbmNpYWxHb2FsUHJvZ3Jlc3NSZXNwb25zZRIlCgRnb2FsGAEgASgLMhEucGIuRmluYW5jaWFsR29hbFIEZ29hbBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getSavingsGoalRequestDescriptor instead')
const GetSavingsGoalRequest$json = const {
  '1': 'GetSavingsGoalRequest',
};

/// Descriptor for `GetSavingsGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSavingsGoalRequestDescriptor = $convert.base64Decode('ChVHZXRTYXZpbmdzR29hbFJlcXVlc3Q=');
@$core.Deprecated('Use getSavingsGoalResponseDescriptor instead')
const GetSavingsGoalResponse$json = const {
  '1': 'GetSavingsGoalResponse',
  '2': const [
    const {'1': 'savings_goal', '3': 1, '4': 1, '5': 11, '6': '.pb.SavingsGoal', '10': 'savingsGoal'},
    const {'1': 'has_goal', '3': 2, '4': 1, '5': 8, '10': 'hasGoal'},
  ],
};

/// Descriptor for `GetSavingsGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSavingsGoalResponseDescriptor = $convert.base64Decode('ChZHZXRTYXZpbmdzR29hbFJlc3BvbnNlEjIKDHNhdmluZ3NfZ29hbBgBIAEoCzIPLnBiLlNhdmluZ3NHb2FsUgtzYXZpbmdzR29hbBIZCghoYXNfZ29hbBgCIAEoCFIHaGFzR29hbA==');
@$core.Deprecated('Use createOrUpdateSavingsGoalRequestDescriptor instead')
const CreateOrUpdateSavingsGoalRequest$json = const {
  '1': 'CreateOrUpdateSavingsGoalRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'target_amount', '3': 2, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 3, '4': 1, '5': 1, '10': 'currentAmount'},
    const {'1': 'target_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
  ],
};

/// Descriptor for `CreateOrUpdateSavingsGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrUpdateSavingsGoalRequestDescriptor = $convert.base64Decode('CiBDcmVhdGVPclVwZGF0ZVNhdmluZ3NHb2FsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEiMKDXRhcmdldF9hbW91bnQYAiABKAFSDHRhcmdldEFtb3VudBIlCg5jdXJyZW50X2Ftb3VudBgDIAEoAVINY3VycmVudEFtb3VudBI7Cgt0YXJnZXRfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnRhcmdldERhdGU=');
@$core.Deprecated('Use createOrUpdateSavingsGoalResponseDescriptor instead')
const CreateOrUpdateSavingsGoalResponse$json = const {
  '1': 'CreateOrUpdateSavingsGoalResponse',
  '2': const [
    const {'1': 'savings_goal', '3': 1, '4': 1, '5': 11, '6': '.pb.SavingsGoal', '10': 'savingsGoal'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateOrUpdateSavingsGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrUpdateSavingsGoalResponseDescriptor = $convert.base64Decode('CiFDcmVhdGVPclVwZGF0ZVNhdmluZ3NHb2FsUmVzcG9uc2USMgoMc2F2aW5nc19nb2FsGAEgASgLMg8ucGIuU2F2aW5nc0dvYWxSC3NhdmluZ3NHb2FsEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use createRecurringBillRequestDescriptor instead')
const CreateRecurringBillRequest$json = const {
  '1': 'CreateRecurringBillRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    const {'1': 'recurrence_pattern', '3': 5, '4': 1, '5': 9, '10': 'recurrencePattern'},
    const {'1': 'next_due_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextDueDate'},
    const {'1': 'merchant', '3': 7, '4': 1, '5': 9, '10': 'merchant'},
    const {'1': 'icon', '3': 8, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'auto_pay_enabled', '3': 9, '4': 1, '5': 8, '10': 'autoPayEnabled'},
  ],
};

/// Descriptor for `CreateRecurringBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringBillRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVSZWN1cnJpbmdCaWxsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIvCghjYXRlZ29yeRgEIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVIIY2F0ZWdvcnkSLQoScmVjdXJyZW5jZV9wYXR0ZXJuGAUgASgJUhFyZWN1cnJlbmNlUGF0dGVybhI+Cg1uZXh0X2R1ZV9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbmV4dER1ZURhdGUSGgoIbWVyY2hhbnQYByABKAlSCG1lcmNoYW50EhIKBGljb24YCCABKAlSBGljb24SKAoQYXV0b19wYXlfZW5hYmxlZBgJIAEoCFIOYXV0b1BheUVuYWJsZWQ=');
@$core.Deprecated('Use createRecurringBillResponseDescriptor instead')
const CreateRecurringBillResponse$json = const {
  '1': 'CreateRecurringBillResponse',
  '2': const [
    const {'1': 'bill', '3': 1, '4': 1, '5': 11, '6': '.pb.RecurringBill', '10': 'bill'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateRecurringBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringBillResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVSZWN1cnJpbmdCaWxsUmVzcG9uc2USJQoEYmlsbBgBIAEoCzIRLnBiLlJlY3VycmluZ0JpbGxSBGJpbGwSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getUpcomingBillsRequestDescriptor instead')
const GetUpcomingBillsRequest$json = const {
  '1': 'GetUpcomingBillsRequest',
  '2': const [
    const {'1': 'days_ahead', '3': 1, '4': 1, '5': 5, '10': 'daysAhead'},
  ],
};

/// Descriptor for `GetUpcomingBillsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpcomingBillsRequestDescriptor = $convert.base64Decode('ChdHZXRVcGNvbWluZ0JpbGxzUmVxdWVzdBIdCgpkYXlzX2FoZWFkGAEgASgFUglkYXlzQWhlYWQ=');
@$core.Deprecated('Use getUpcomingBillsResponseDescriptor instead')
const GetUpcomingBillsResponse$json = const {
  '1': 'GetUpcomingBillsResponse',
  '2': const [
    const {'1': 'bills_list', '3': 1, '4': 1, '5': 11, '6': '.pb.UpcomingBillsList', '10': 'billsList'},
  ],
};

/// Descriptor for `GetUpcomingBillsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpcomingBillsResponseDescriptor = $convert.base64Decode('ChhHZXRVcGNvbWluZ0JpbGxzUmVzcG9uc2USNAoKYmlsbHNfbGlzdBgBIAEoCzIVLnBiLlVwY29taW5nQmlsbHNMaXN0UgliaWxsc0xpc3Q=');
