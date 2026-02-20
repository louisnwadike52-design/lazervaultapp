//
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use expenseCategoryDescriptor instead')
const ExpenseCategory$json = {
  '1': 'ExpenseCategory',
  '2': [
    {'1': 'EXPENSE_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'EXPENSE_CATEGORY_FOOD_DINING', '2': 1},
    {'1': 'EXPENSE_CATEGORY_TRANSPORTATION', '2': 2},
    {'1': 'EXPENSE_CATEGORY_SHOPPING', '2': 3},
    {'1': 'EXPENSE_CATEGORY_ENTERTAINMENT', '2': 4},
    {'1': 'EXPENSE_CATEGORY_BILLS_UTILITIES', '2': 5},
    {'1': 'EXPENSE_CATEGORY_HEALTHCARE', '2': 6},
    {'1': 'EXPENSE_CATEGORY_EDUCATION', '2': 7},
    {'1': 'EXPENSE_CATEGORY_TRAVEL', '2': 8},
    {'1': 'EXPENSE_CATEGORY_GROCERIES', '2': 9},
    {'1': 'EXPENSE_CATEGORY_RENT_MORTGAGE', '2': 10},
    {'1': 'EXPENSE_CATEGORY_INSURANCE', '2': 11},
    {'1': 'EXPENSE_CATEGORY_INVESTMENTS', '2': 12},
    {'1': 'EXPENSE_CATEGORY_GIFTS_DONATIONS', '2': 13},
    {'1': 'EXPENSE_CATEGORY_PERSONAL_CARE', '2': 14},
    {'1': 'EXPENSE_CATEGORY_SUBSCRIPTIONS', '2': 15},
    {'1': 'EXPENSE_CATEGORY_OTHER', '2': 16},
  ],
};

/// Descriptor for `ExpenseCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List expenseCategoryDescriptor = $convert.base64Decode(
    'Cg9FeHBlbnNlQ2F0ZWdvcnkSIAocRVhQRU5TRV9DQVRFR09SWV9VTlNQRUNJRklFRBAAEiAKHE'
    'VYUEVOU0VfQ0FURUdPUllfRk9PRF9ESU5JTkcQARIjCh9FWFBFTlNFX0NBVEVHT1JZX1RSQU5T'
    'UE9SVEFUSU9OEAISHQoZRVhQRU5TRV9DQVRFR09SWV9TSE9QUElORxADEiIKHkVYUEVOU0VfQ0'
    'FURUdPUllfRU5URVJUQUlOTUVOVBAEEiQKIEVYUEVOU0VfQ0FURUdPUllfQklMTFNfVVRJTElU'
    'SUVTEAUSHwobRVhQRU5TRV9DQVRFR09SWV9IRUFMVEhDQVJFEAYSHgoaRVhQRU5TRV9DQVRFR0'
    '9SWV9FRFVDQVRJT04QBxIbChdFWFBFTlNFX0NBVEVHT1JZX1RSQVZFTBAIEh4KGkVYUEVOU0Vf'
    'Q0FURUdPUllfR1JPQ0VSSUVTEAkSIgoeRVhQRU5TRV9DQVRFR09SWV9SRU5UX01PUlRHQUdFEA'
    'oSHgoaRVhQRU5TRV9DQVRFR09SWV9JTlNVUkFOQ0UQCxIgChxFWFBFTlNFX0NBVEVHT1JZX0lO'
    'VkVTVE1FTlRTEAwSJAogRVhQRU5TRV9DQVRFR09SWV9HSUZUU19ET05BVElPTlMQDRIiCh5FWF'
    'BFTlNFX0NBVEVHT1JZX1BFUlNPTkFMX0NBUkUQDhIiCh5FWFBFTlNFX0NBVEVHT1JZX1NVQlND'
    'UklQVElPTlMQDxIaChZFWFBFTlNFX0NBVEVHT1JZX09USEVSEBA=');

@$core.Deprecated('Use budgetPeriodDescriptor instead')
const BudgetPeriod$json = {
  '1': 'BudgetPeriod',
  '2': [
    {'1': 'BUDGET_PERIOD_UNSPECIFIED', '2': 0},
    {'1': 'BUDGET_PERIOD_DAILY', '2': 1},
    {'1': 'BUDGET_PERIOD_WEEKLY', '2': 2},
    {'1': 'BUDGET_PERIOD_MONTHLY', '2': 3},
    {'1': 'BUDGET_PERIOD_QUARTERLY', '2': 4},
    {'1': 'BUDGET_PERIOD_YEARLY', '2': 5},
    {'1': 'BUDGET_PERIOD_CUSTOM', '2': 6},
  ],
};

/// Descriptor for `BudgetPeriod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List budgetPeriodDescriptor = $convert.base64Decode(
    'CgxCdWRnZXRQZXJpb2QSHQoZQlVER0VUX1BFUklPRF9VTlNQRUNJRklFRBAAEhcKE0JVREdFVF'
    '9QRVJJT0RfREFJTFkQARIYChRCVURHRVRfUEVSSU9EX1dFRUtMWRACEhkKFUJVREdFVF9QRVJJ'
    'T0RfTU9OVEhMWRADEhsKF0JVREdFVF9QRVJJT0RfUVVBUlRFUkxZEAQSGAoUQlVER0VUX1BFUk'
    'lPRF9ZRUFSTFkQBRIYChRCVURHRVRfUEVSSU9EX0NVU1RPTRAG');

@$core.Deprecated('Use budgetStatusDescriptor instead')
const BudgetStatus$json = {
  '1': 'BudgetStatus',
  '2': [
    {'1': 'BUDGET_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'BUDGET_STATUS_ACTIVE', '2': 1},
    {'1': 'BUDGET_STATUS_EXCEEDED', '2': 2},
    {'1': 'BUDGET_STATUS_NEAR_LIMIT', '2': 3},
    {'1': 'BUDGET_STATUS_INACTIVE', '2': 4},
    {'1': 'BUDGET_STATUS_COMPLETED', '2': 5},
  ],
};

/// Descriptor for `BudgetStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List budgetStatusDescriptor = $convert.base64Decode(
    'CgxCdWRnZXRTdGF0dXMSHQoZQlVER0VUX1NUQVRVU19VTlNQRUNJRklFRBAAEhgKFEJVREdFVF'
    '9TVEFUVVNfQUNUSVZFEAESGgoWQlVER0VUX1NUQVRVU19FWENFRURFRBACEhwKGEJVREdFVF9T'
    'VEFUVVNfTkVBUl9MSU1JVBADEhoKFkJVREdFVF9TVEFUVVNfSU5BQ1RJVkUQBBIbChdCVURHRV'
    'RfU1RBVFVTX0NPTVBMRVRFRBAF');

@$core.Deprecated('Use budgetEnforcementModeDescriptor instead')
const BudgetEnforcementMode$json = {
  '1': 'BudgetEnforcementMode',
  '2': [
    {'1': 'BUDGET_ENFORCEMENT_MODE_UNSPECIFIED', '2': 0},
    {'1': 'BUDGET_ENFORCEMENT_MODE_FLEXIBLE', '2': 1},
    {'1': 'BUDGET_ENFORCEMENT_MODE_STRICT', '2': 2},
  ],
};

/// Descriptor for `BudgetEnforcementMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List budgetEnforcementModeDescriptor = $convert.base64Decode(
    'ChVCdWRnZXRFbmZvcmNlbWVudE1vZGUSJwojQlVER0VUX0VORk9SQ0VNRU5UX01PREVfVU5TUE'
    'VDSUZJRUQQABIkCiBCVURHRVRfRU5GT1JDRU1FTlRfTU9ERV9GTEVYSUJMRRABEiIKHkJVREdF'
    'VF9FTkZPUkNFTUVOVF9NT0RFX1NUUklDVBAC');

@$core.Deprecated('Use alertTypeDescriptor instead')
const AlertType$json = {
  '1': 'AlertType',
  '2': [
    {'1': 'ALERT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'ALERT_TYPE_THRESHOLD_REACHED', '2': 1},
    {'1': 'ALERT_TYPE_BUDGET_EXCEEDED', '2': 2},
    {'1': 'ALERT_TYPE_APPROACHING_LIMIT', '2': 3},
    {'1': 'ALERT_TYPE_RECURRING_EXPENSE_DUE', '2': 4},
  ],
};

/// Descriptor for `AlertType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List alertTypeDescriptor = $convert.base64Decode(
    'CglBbGVydFR5cGUSGgoWQUxFUlRfVFlQRV9VTlNQRUNJRklFRBAAEiAKHEFMRVJUX1RZUEVfVE'
    'hSRVNIT0xEX1JFQUNIRUQQARIeChpBTEVSVF9UWVBFX0JVREdFVF9FWENFRURFRBACEiAKHEFM'
    'RVJUX1RZUEVfQVBQUk9BQ0hJTkdfTElNSVQQAxIkCiBBTEVSVF9UWVBFX1JFQ1VSUklOR19FWF'
    'BFTlNFX0RVRRAE');

@$core.Deprecated('Use incomeCategoryDescriptor instead')
const IncomeCategory$json = {
  '1': 'IncomeCategory',
  '2': [
    {'1': 'INCOME_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'INCOME_CATEGORY_SALARY', '2': 1},
    {'1': 'INCOME_CATEGORY_FREELANCE', '2': 2},
    {'1': 'INCOME_CATEGORY_INVESTMENTS', '2': 3},
    {'1': 'INCOME_CATEGORY_RENTAL', '2': 4},
    {'1': 'INCOME_CATEGORY_BUSINESS', '2': 5},
    {'1': 'INCOME_CATEGORY_DIVIDEND', '2': 6},
    {'1': 'INCOME_CATEGORY_INTEREST', '2': 7},
    {'1': 'INCOME_CATEGORY_GIFT', '2': 8},
    {'1': 'INCOME_CATEGORY_OTHER', '2': 9},
  ],
};

/// Descriptor for `IncomeCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List incomeCategoryDescriptor = $convert.base64Decode(
    'Cg5JbmNvbWVDYXRlZ29yeRIfChtJTkNPTUVfQ0FURUdPUllfVU5TUEVDSUZJRUQQABIaChZJTk'
    'NPTUVfQ0FURUdPUllfU0FMQVJZEAESHQoZSU5DT01FX0NBVEVHT1JZX0ZSRUVMQU5DRRACEh8K'
    'G0lOQ09NRV9DQVRFR09SWV9JTlZFU1RNRU5UUxADEhoKFklOQ09NRV9DQVRFR09SWV9SRU5UQU'
    'wQBBIcChhJTkNPTUVfQ0FURUdPUllfQlVTSU5FU1MQBRIcChhJTkNPTUVfQ0FURUdPUllfRElW'
    'SURFTkQQBhIcChhJTkNPTUVfQ0FURUdPUllfSU5URVJFU1QQBxIYChRJTkNPTUVfQ0FURUdPUl'
    'lfR0lGVBAIEhkKFUlOQ09NRV9DQVRFR09SWV9PVEhFUhAJ');

@$core.Deprecated('Use investmentTypeDescriptor instead')
const InvestmentType$json = {
  '1': 'InvestmentType',
  '2': [
    {'1': 'INVESTMENT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'INVESTMENT_TYPE_STOCKS', '2': 1},
    {'1': 'INVESTMENT_TYPE_CRYPTO', '2': 2},
    {'1': 'INVESTMENT_TYPE_MUTUAL_FUNDS', '2': 3},
    {'1': 'INVESTMENT_TYPE_BONDS', '2': 4},
    {'1': 'INVESTMENT_TYPE_ETF', '2': 5},
    {'1': 'INVESTMENT_TYPE_REAL_ESTATE', '2': 6},
    {'1': 'INVESTMENT_TYPE_COMMODITIES', '2': 7},
    {'1': 'INVESTMENT_TYPE_OTHER', '2': 8},
  ],
};

/// Descriptor for `InvestmentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List investmentTypeDescriptor = $convert.base64Decode(
    'Cg5JbnZlc3RtZW50VHlwZRIfChtJTlZFU1RNRU5UX1RZUEVfVU5TUEVDSUZJRUQQABIaChZJTl'
    'ZFU1RNRU5UX1RZUEVfU1RPQ0tTEAESGgoWSU5WRVNUTUVOVF9UWVBFX0NSWVBUTxACEiAKHElO'
    'VkVTVE1FTlRfVFlQRV9NVVRVQUxfRlVORFMQAxIZChVJTlZFU1RNRU5UX1RZUEVfQk9ORFMQBB'
    'IXChNJTlZFU1RNRU5UX1RZUEVfRVRGEAUSHwobSU5WRVNUTUVOVF9UWVBFX1JFQUxfRVNUQVRF'
    'EAYSHwobSU5WRVNUTUVOVF9UWVBFX0NPTU1PRElUSUVTEAcSGQoVSU5WRVNUTUVOVF9UWVBFX0'
    '9USEVSEAg=');

@$core.Deprecated('Use goalStatusDescriptor instead')
const GoalStatus$json = {
  '1': 'GoalStatus',
  '2': [
    {'1': 'GOAL_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'GOAL_STATUS_IN_PROGRESS', '2': 1},
    {'1': 'GOAL_STATUS_COMPLETED', '2': 2},
    {'1': 'GOAL_STATUS_CANCELLED', '2': 3},
    {'1': 'GOAL_STATUS_PAUSED', '2': 4},
  ],
};

/// Descriptor for `GoalStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List goalStatusDescriptor = $convert.base64Decode(
    'CgpHb2FsU3RhdHVzEhsKF0dPQUxfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGwoXR09BTF9TVEFUVV'
    'NfSU5fUFJPR1JFU1MQARIZChVHT0FMX1NUQVRVU19DT01QTEVURUQQAhIZChVHT0FMX1NUQVRV'
    'U19DQU5DRUxMRUQQAxIWChJHT0FMX1NUQVRVU19QQVVTRUQQBA==');

@$core.Deprecated('Use goalTypeDescriptor instead')
const GoalType$json = {
  '1': 'GoalType',
  '2': [
    {'1': 'GOAL_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'GOAL_TYPE_EMERGENCY_FUND', '2': 1},
    {'1': 'GOAL_TYPE_VACATION', '2': 2},
    {'1': 'GOAL_TYPE_CAR', '2': 3},
    {'1': 'GOAL_TYPE_HOUSE', '2': 4},
    {'1': 'GOAL_TYPE_EDUCATION', '2': 5},
    {'1': 'GOAL_TYPE_RETIREMENT', '2': 6},
    {'1': 'GOAL_TYPE_WEDDING', '2': 7},
    {'1': 'GOAL_TYPE_DEBT_PAYOFF', '2': 8},
    {'1': 'GOAL_TYPE_CUSTOM', '2': 9},
  ],
};

/// Descriptor for `GoalType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List goalTypeDescriptor = $convert.base64Decode(
    'CghHb2FsVHlwZRIZChVHT0FMX1RZUEVfVU5TUEVDSUZJRUQQABIcChhHT0FMX1RZUEVfRU1FUk'
    'dFTkNZX0ZVTkQQARIWChJHT0FMX1RZUEVfVkFDQVRJT04QAhIRCg1HT0FMX1RZUEVfQ0FSEAMS'
    'EwoPR09BTF9UWVBFX0hPVVNFEAQSFwoTR09BTF9UWVBFX0VEVUNBVElPThAFEhgKFEdPQUxfVF'
    'lQRV9SRVRJUkVNRU5UEAYSFQoRR09BTF9UWVBFX1dFRERJTkcQBxIZChVHT0FMX1RZUEVfREVC'
    'VF9QQVlPRkYQCBIUChBHT0FMX1RZUEVfQ1VTVE9NEAk=');

@$core.Deprecated('Use billStatusDescriptor instead')
const BillStatus$json = {
  '1': 'BillStatus',
  '2': [
    {'1': 'BILL_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'BILL_STATUS_UPCOMING', '2': 1},
    {'1': 'BILL_STATUS_PAID', '2': 2},
    {'1': 'BILL_STATUS_OVERDUE', '2': 3},
    {'1': 'BILL_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `BillStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List billStatusDescriptor = $convert.base64Decode(
    'CgpCaWxsU3RhdHVzEhsKF0JJTExfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGAoUQklMTF9TVEFUVV'
    'NfVVBDT01JTkcQARIUChBCSUxMX1NUQVRVU19QQUlEEAISFwoTQklMTF9TVEFUVVNfT1ZFUkRV'
    'RRADEhkKFUJJTExfU1RBVFVTX0NBTkNFTExFRBAE');

@$core.Deprecated('Use expenseMessageDescriptor instead')
const ExpenseMessage$json = {
  '1': 'ExpenseMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'subcategory', '3': 7, '4': 1, '5': 9, '10': 'subcategory'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'merchant', '3': 9, '4': 1, '5': 9, '10': 'merchant'},
    {'1': 'transaction_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'payment_method', '3': 11, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'receipt_url', '3': 12, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'tags', '3': 13, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'notes', '3': 14, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'is_recurring', '3': 15, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_pattern', '3': 16, '4': 1, '5': 9, '10': 'recurrencePattern'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `ExpenseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expenseMessageDescriptor = $convert.base64Decode(
    'Cg5FeHBlbnNlTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlck'
    'lkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIWCgZhbW91bnQYBCABKAFSBmFtb3Vu'
    'dBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSLwoIY2F0ZWdvcnkYBiABKA4yEy5wYi5FeH'
    'BlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5EiAKC3N1YmNhdGVnb3J5GAcgASgJUgtzdWJjYXRlZ29y'
    'eRIgCgtkZXNjcmlwdGlvbhgIIAEoCVILZGVzY3JpcHRpb24SGgoIbWVyY2hhbnQYCSABKAlSCG'
    '1lcmNoYW50EkUKEHRyYW5zYWN0aW9uX2RhdGUYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGlt'
    'ZXN0YW1wUg90cmFuc2FjdGlvbkRhdGUSJQoOcGF5bWVudF9tZXRob2QYCyABKAlSDXBheW1lbn'
    'RNZXRob2QSHwoLcmVjZWlwdF91cmwYDCABKAlSCnJlY2VpcHRVcmwSEgoEdGFncxgNIAMoCVIE'
    'dGFncxIUCgVub3RlcxgOIAEoCVIFbm90ZXMSIQoMaXNfcmVjdXJyaW5nGA8gASgIUgtpc1JlY3'
    'VycmluZxItChJyZWN1cnJlbmNlX3BhdHRlcm4YECABKAlSEXJlY3VycmVuY2VQYXR0ZXJuEjkK'
    'CmNyZWF0ZWRfYXQYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQX'
    'QSOQoKdXBkYXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0'
    'ZWRBdA==');

@$core.Deprecated('Use budgetMessageDescriptor instead')
const BudgetMessage$json = {
  '1': 'BudgetMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'period', '3': 7, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
    {'1': 'start_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'spent_amount', '3': 10, '4': 1, '5': 1, '10': 'spentAmount'},
    {'1': 'remaining_amount', '3': 11, '4': 1, '5': 1, '10': 'remainingAmount'},
    {'1': 'percentage_used', '3': 12, '4': 1, '5': 1, '10': 'percentageUsed'},
    {'1': 'status', '3': 13, '4': 1, '5': 14, '6': '.pb.BudgetStatus', '10': 'status'},
    {'1': 'enable_alerts', '3': 14, '4': 1, '5': 8, '10': 'enableAlerts'},
    {'1': 'alert_threshold', '3': 15, '4': 1, '5': 1, '10': 'alertThreshold'},
    {'1': 'enforcement_mode', '3': 16, '4': 1, '5': 14, '6': '.pb.BudgetEnforcementMode', '10': 'enforcementMode'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `BudgetMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetMessageDescriptor = $convert.base64Decode(
    'Cg1CdWRnZXRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySW'
    'QSEgoEbmFtZRgDIAEoCVIEbmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5j'
    'eRgFIAEoCVIIY3VycmVuY3kSLwoIY2F0ZWdvcnkYBiABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcn'
    'lSCGNhdGVnb3J5EigKBnBlcmlvZBgHIAEoDjIQLnBiLkJ1ZGdldFBlcmlvZFIGcGVyaW9kEjkK'
    'CnN0YXJ0X2RhdGUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdG'
    'USNQoIZW5kX2RhdGUYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl'
    'EiEKDHNwZW50X2Ftb3VudBgKIAEoAVILc3BlbnRBbW91bnQSKQoQcmVtYWluaW5nX2Ftb3VudB'
    'gLIAEoAVIPcmVtYWluaW5nQW1vdW50EicKD3BlcmNlbnRhZ2VfdXNlZBgMIAEoAVIOcGVyY2Vu'
    'dGFnZVVzZWQSKAoGc3RhdHVzGA0gASgOMhAucGIuQnVkZ2V0U3RhdHVzUgZzdGF0dXMSIwoNZW'
    '5hYmxlX2FsZXJ0cxgOIAEoCFIMZW5hYmxlQWxlcnRzEicKD2FsZXJ0X3RocmVzaG9sZBgPIAEo'
    'AVIOYWxlcnRUaHJlc2hvbGQSRAoQZW5mb3JjZW1lbnRfbW9kZRgQIAEoDjIZLnBiLkJ1ZGdldE'
    'VuZm9yY2VtZW50TW9kZVIPZW5mb3JjZW1lbnRNb2RlEjkKCmNyZWF0ZWRfYXQYESABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgSIAEoCz'
    'IaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use budgetAlertMessageDescriptor instead')
const BudgetAlertMessage$json = {
  '1': 'BudgetAlertMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'budget_id', '3': 3, '4': 1, '5': 9, '10': 'budgetId'},
    {'1': 'budget_name', '3': 4, '4': 1, '5': 9, '10': 'budgetName'},
    {'1': 'alert_type', '3': 5, '4': 1, '5': 14, '6': '.pb.AlertType', '10': 'alertType'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    {'1': 'current_spent', '3': 7, '4': 1, '5': 1, '10': 'currentSpent'},
    {'1': 'budget_limit', '3': 8, '4': 1, '5': 1, '10': 'budgetLimit'},
    {'1': 'percentage_used', '3': 9, '4': 1, '5': 1, '10': 'percentageUsed'},
    {'1': 'is_read', '3': 10, '4': 1, '5': 8, '10': 'isRead'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `BudgetAlertMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetAlertMessageDescriptor = $convert.base64Decode(
    'ChJCdWRnZXRBbGVydE1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBn'
    'VzZXJJZBIbCglidWRnZXRfaWQYAyABKAlSCGJ1ZGdldElkEh8KC2J1ZGdldF9uYW1lGAQgASgJ'
    'UgpidWRnZXROYW1lEiwKCmFsZXJ0X3R5cGUYBSABKA4yDS5wYi5BbGVydFR5cGVSCWFsZXJ0VH'
    'lwZRIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdlEiMKDWN1cnJlbnRfc3BlbnQYByABKAFSDGN1'
    'cnJlbnRTcGVudBIhCgxidWRnZXRfbGltaXQYCCABKAFSC2J1ZGdldExpbWl0EicKD3BlcmNlbn'
    'RhZ2VfdXNlZBgJIAEoAVIOcGVyY2VudGFnZVVzZWQSFwoHaXNfcmVhZBgKIAEoCFIGaXNSZWFk'
    'EjkKCmNyZWF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdG'
    'VkQXQ=');

@$core.Deprecated('Use spendingAnalyticsDescriptor instead')
const SpendingAnalytics$json = {
  '1': 'SpendingAnalytics',
  '2': [
    {'1': 'period', '3': 1, '4': 1, '5': 9, '10': 'period'},
    {'1': 'total_spent', '3': 2, '4': 1, '5': 1, '10': 'totalSpent'},
    {'1': 'total_budget', '3': 3, '4': 1, '5': 1, '10': 'totalBudget'},
    {'1': 'remaining_budget', '3': 4, '4': 1, '5': 1, '10': 'remainingBudget'},
    {'1': 'transaction_count', '3': 5, '4': 1, '5': 5, '10': 'transactionCount'},
    {'1': 'average_transaction', '3': 6, '4': 1, '5': 1, '10': 'averageTransaction'},
    {'1': 'category_breakdown', '3': 7, '4': 3, '5': 11, '6': '.pb.CategorySpending', '10': 'categoryBreakdown'},
    {'1': 'daily_trend', '3': 8, '4': 3, '5': 11, '6': '.pb.DailySpending', '10': 'dailyTrend'},
    {'1': 'top_category', '3': 9, '4': 1, '5': 9, '10': 'topCategory'},
    {'1': 'top_category_amount', '3': 10, '4': 1, '5': 1, '10': 'topCategoryAmount'},
    {'1': 'savings_rate', '3': 11, '4': 1, '5': 1, '10': 'savingsRate'},
  ],
};

/// Descriptor for `SpendingAnalytics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spendingAnalyticsDescriptor = $convert.base64Decode(
    'ChFTcGVuZGluZ0FuYWx5dGljcxIWCgZwZXJpb2QYASABKAlSBnBlcmlvZBIfCgt0b3RhbF9zcG'
    'VudBgCIAEoAVIKdG90YWxTcGVudBIhCgx0b3RhbF9idWRnZXQYAyABKAFSC3RvdGFsQnVkZ2V0'
    'EikKEHJlbWFpbmluZ19idWRnZXQYBCABKAFSD3JlbWFpbmluZ0J1ZGdldBIrChF0cmFuc2FjdG'
    'lvbl9jb3VudBgFIAEoBVIQdHJhbnNhY3Rpb25Db3VudBIvChNhdmVyYWdlX3RyYW5zYWN0aW9u'
    'GAYgASgBUhJhdmVyYWdlVHJhbnNhY3Rpb24SQwoSY2F0ZWdvcnlfYnJlYWtkb3duGAcgAygLMh'
    'QucGIuQ2F0ZWdvcnlTcGVuZGluZ1IRY2F0ZWdvcnlCcmVha2Rvd24SMgoLZGFpbHlfdHJlbmQY'
    'CCADKAsyES5wYi5EYWlseVNwZW5kaW5nUgpkYWlseVRyZW5kEiEKDHRvcF9jYXRlZ29yeRgJIA'
    'EoCVILdG9wQ2F0ZWdvcnkSLgoTdG9wX2NhdGVnb3J5X2Ftb3VudBgKIAEoAVIRdG9wQ2F0ZWdv'
    'cnlBbW91bnQSIQoMc2F2aW5nc19yYXRlGAsgASgBUgtzYXZpbmdzUmF0ZQ==');

@$core.Deprecated('Use categorySpendingDescriptor instead')
const CategorySpending$json = {
  '1': 'CategorySpending',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
    {'1': 'transaction_count', '3': 5, '4': 1, '5': 5, '10': 'transactionCount'},
    {'1': 'budget_allocated', '3': 6, '4': 1, '5': 1, '10': 'budgetAllocated'},
    {'1': 'budget_remaining', '3': 7, '4': 1, '5': 1, '10': 'budgetRemaining'},
  ],
};

/// Descriptor for `CategorySpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categorySpendingDescriptor = $convert.base64Decode(
    'ChBDYXRlZ29yeVNwZW5kaW5nEi8KCGNhdGVnb3J5GAEgASgOMhMucGIuRXhwZW5zZUNhdGVnb3'
    'J5UghjYXRlZ29yeRIjCg1jYXRlZ29yeV9uYW1lGAIgASgJUgxjYXRlZ29yeU5hbWUSFgoGYW1v'
    'dW50GAMgASgBUgZhbW91bnQSHgoKcGVyY2VudGFnZRgEIAEoAVIKcGVyY2VudGFnZRIrChF0cm'
    'Fuc2FjdGlvbl9jb3VudBgFIAEoBVIQdHJhbnNhY3Rpb25Db3VudBIpChBidWRnZXRfYWxsb2Nh'
    'dGVkGAYgASgBUg9idWRnZXRBbGxvY2F0ZWQSKQoQYnVkZ2V0X3JlbWFpbmluZxgHIAEoAVIPYn'
    'VkZ2V0UmVtYWluaW5n');

@$core.Deprecated('Use dailySpendingDescriptor instead')
const DailySpending$json = {
  '1': 'DailySpending',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_count', '3': 3, '4': 1, '5': 5, '10': 'transactionCount'},
  ],
};

/// Descriptor for `DailySpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailySpendingDescriptor = $convert.base64Decode(
    'Cg1EYWlseVNwZW5kaW5nEi4KBGRhdGUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgRkYXRlEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EisKEXRyYW5zYWN0aW9uX2NvdW50GAMg'
    'ASgFUhB0cmFuc2FjdGlvbkNvdW50');

@$core.Deprecated('Use budgetProgressItemDescriptor instead')
const BudgetProgressItem$json = {
  '1': 'BudgetProgressItem',
  '2': [
    {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
    {'1': 'budget_name', '3': 2, '4': 1, '5': 9, '10': 'budgetName'},
    {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'budget_amount', '3': 4, '4': 1, '5': 1, '10': 'budgetAmount'},
    {'1': 'spent_amount', '3': 5, '4': 1, '5': 1, '10': 'spentAmount'},
    {'1': 'remaining_amount', '3': 6, '4': 1, '5': 1, '10': 'remainingAmount'},
    {'1': 'percentage_used', '3': 7, '4': 1, '5': 1, '10': 'percentageUsed'},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.BudgetStatus', '10': 'status'},
    {'1': 'days_remaining', '3': 9, '4': 1, '5': 5, '10': 'daysRemaining'},
    {'1': 'daily_average_spend', '3': 10, '4': 1, '5': 1, '10': 'dailyAverageSpend'},
    {'1': 'projected_spend', '3': 11, '4': 1, '5': 1, '10': 'projectedSpend'},
    {'1': 'will_exceed', '3': 12, '4': 1, '5': 8, '10': 'willExceed'},
  ],
};

/// Descriptor for `BudgetProgressItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetProgressItemDescriptor = $convert.base64Decode(
    'ChJCdWRnZXRQcm9ncmVzc0l0ZW0SGwoJYnVkZ2V0X2lkGAEgASgJUghidWRnZXRJZBIfCgtidW'
    'RnZXRfbmFtZRgCIAEoCVIKYnVkZ2V0TmFtZRIvCghjYXRlZ29yeRgDIAEoDjITLnBiLkV4cGVu'
    'c2VDYXRlZ29yeVIIY2F0ZWdvcnkSIwoNYnVkZ2V0X2Ftb3VudBgEIAEoAVIMYnVkZ2V0QW1vdW'
    '50EiEKDHNwZW50X2Ftb3VudBgFIAEoAVILc3BlbnRBbW91bnQSKQoQcmVtYWluaW5nX2Ftb3Vu'
    'dBgGIAEoAVIPcmVtYWluaW5nQW1vdW50EicKD3BlcmNlbnRhZ2VfdXNlZBgHIAEoAVIOcGVyY2'
    'VudGFnZVVzZWQSKAoGc3RhdHVzGAggASgOMhAucGIuQnVkZ2V0U3RhdHVzUgZzdGF0dXMSJQoO'
    'ZGF5c19yZW1haW5pbmcYCSABKAVSDWRheXNSZW1haW5pbmcSLgoTZGFpbHlfYXZlcmFnZV9zcG'
    'VuZBgKIAEoAVIRZGFpbHlBdmVyYWdlU3BlbmQSJwoPcHJvamVjdGVkX3NwZW5kGAsgASgBUg5w'
    'cm9qZWN0ZWRTcGVuZBIfCgt3aWxsX2V4Y2VlZBgMIAEoCFIKd2lsbEV4Y2VlZA==');

@$core.Deprecated('Use spendingTrendDescriptor instead')
const SpendingTrend$json = {
  '1': 'SpendingTrend',
  '2': [
    {'1': 'period_label', '3': 1, '4': 1, '5': 9, '10': 'periodLabel'},
    {'1': 'period_start', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'periodStart'},
    {'1': 'period_end', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'periodEnd'},
    {'1': 'total_spent', '3': 4, '4': 1, '5': 1, '10': 'totalSpent'},
    {'1': 'budget_amount', '3': 5, '4': 1, '5': 1, '10': 'budgetAmount'},
    {'1': 'variance', '3': 6, '4': 1, '5': 1, '10': 'variance'},
    {'1': 'variance_percentage', '3': 7, '4': 1, '5': 1, '10': 'variancePercentage'},
    {'1': 'categories', '3': 8, '4': 3, '5': 11, '6': '.pb.CategorySpending', '10': 'categories'},
  ],
};

/// Descriptor for `SpendingTrend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spendingTrendDescriptor = $convert.base64Decode(
    'Cg1TcGVuZGluZ1RyZW5kEiEKDHBlcmlvZF9sYWJlbBgBIAEoCVILcGVyaW9kTGFiZWwSPQoMcG'
    'VyaW9kX3N0YXJ0GAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcGVyaW9kU3Rh'
    'cnQSOQoKcGVyaW9kX2VuZBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXBlcm'
    'lvZEVuZBIfCgt0b3RhbF9zcGVudBgEIAEoAVIKdG90YWxTcGVudBIjCg1idWRnZXRfYW1vdW50'
    'GAUgASgBUgxidWRnZXRBbW91bnQSGgoIdmFyaWFuY2UYBiABKAFSCHZhcmlhbmNlEi8KE3Zhcm'
    'lhbmNlX3BlcmNlbnRhZ2UYByABKAFSEnZhcmlhbmNlUGVyY2VudGFnZRI0CgpjYXRlZ29yaWVz'
    'GAggAygLMhQucGIuQ2F0ZWdvcnlTcGVuZGluZ1IKY2F0ZWdvcmllcw==');

@$core.Deprecated('Use createExpenseRequestDescriptor instead')
const CreateExpenseRequest$json = {
  '1': 'CreateExpenseRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'subcategory', '3': 5, '4': 1, '5': 9, '10': 'subcategory'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'merchant', '3': 7, '4': 1, '5': 9, '10': 'merchant'},
    {'1': 'transaction_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'payment_method', '3': 9, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'receipt_url', '3': 10, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'tags', '3': 11, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'notes', '3': 12, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'is_recurring', '3': 13, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_pattern', '3': 14, '4': 1, '5': 9, '10': 'recurrencePattern'},
  ],
};

/// Descriptor for `CreateExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createExpenseRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVFeHBlbnNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFg'
    'oGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5Ei8KCGNh'
    'dGVnb3J5GAQgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UghjYXRlZ29yeRIgCgtzdWJjYXRlZ2'
    '9yeRgFIAEoCVILc3ViY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YBiABKAlSC2Rlc2NyaXB0aW9u'
    'EhoKCG1lcmNoYW50GAcgASgJUghtZXJjaGFudBJFChB0cmFuc2FjdGlvbl9kYXRlGAggASgLMh'
    'ouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEiUKDnBheW1lbnRf'
    'bWV0aG9kGAkgASgJUg1wYXltZW50TWV0aG9kEh8KC3JlY2VpcHRfdXJsGAogASgJUgpyZWNlaX'
    'B0VXJsEhIKBHRhZ3MYCyADKAlSBHRhZ3MSFAoFbm90ZXMYDCABKAlSBW5vdGVzEiEKDGlzX3Jl'
    'Y3VycmluZxgNIAEoCFILaXNSZWN1cnJpbmcSLQoScmVjdXJyZW5jZV9wYXR0ZXJuGA4gASgJUh'
    'FyZWN1cnJlbmNlUGF0dGVybg==');

@$core.Deprecated('Use createExpenseResponseDescriptor instead')
const CreateExpenseResponse$json = {
  '1': 'CreateExpenseResponse',
  '2': [
    {'1': 'expense', '3': 1, '4': 1, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expense'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createExpenseResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVFeHBlbnNlUmVzcG9uc2USLAoHZXhwZW5zZRgBIAEoCzISLnBiLkV4cGVuc2VNZX'
    'NzYWdlUgdleHBlbnNlEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEo'
    'CVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getExpensesRequestDescriptor instead')
const GetExpensesRequest$json = {
  '1': 'GetExpensesRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    {'1': 'start_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'category', '3': 5, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'min_amount', '3': 6, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 7, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'search_query', '3': 8, '4': 1, '5': 9, '10': 'searchQuery'},
    {'1': 'tags', '3': 9, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `GetExpensesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpensesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRFeHBlbnNlc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgCIA'
    'EoBVIHcGVyUGFnZRI5CgpzdGFydF9kYXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVz'
    'dGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcFIHZW5kRGF0ZRIvCghjYXRlZ29yeRgFIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVII'
    'Y2F0ZWdvcnkSHQoKbWluX2Ftb3VudBgGIAEoAVIJbWluQW1vdW50Eh0KCm1heF9hbW91bnQYBy'
    'ABKAFSCW1heEFtb3VudBIhCgxzZWFyY2hfcXVlcnkYCCABKAlSC3NlYXJjaFF1ZXJ5EhIKBHRh'
    'Z3MYCSADKAlSBHRhZ3M=');

@$core.Deprecated('Use getExpensesResponseDescriptor instead')
const GetExpensesResponse$json = {
  '1': 'GetExpensesResponse',
  '2': [
    {'1': 'expenses', '3': 1, '4': 3, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expenses'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationMetadata', '10': 'pagination'},
    {'1': 'total_amount', '3': 3, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'total_count', '3': 4, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetExpensesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpensesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRFeHBlbnNlc1Jlc3BvbnNlEi4KCGV4cGVuc2VzGAEgAygLMhIucGIuRXhwZW5zZU1lc3'
    'NhZ2VSCGV4cGVuc2VzEjYKCnBhZ2luYXRpb24YAiABKAsyFi5wYi5QYWdpbmF0aW9uTWV0YWRh'
    'dGFSCnBhZ2luYXRpb24SIQoMdG90YWxfYW1vdW50GAMgASgBUgt0b3RhbEFtb3VudBIfCgt0b3'
    'RhbF9jb3VudBgEIAEoBVIKdG90YWxDb3VudA==');

@$core.Deprecated('Use getExpenseByIdRequestDescriptor instead')
const GetExpenseByIdRequest$json = {
  '1': 'GetExpenseByIdRequest',
  '2': [
    {'1': 'expense_id', '3': 1, '4': 1, '5': 9, '10': 'expenseId'},
  ],
};

/// Descriptor for `GetExpenseByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseByIdRequestDescriptor = $convert.base64Decode(
    'ChVHZXRFeHBlbnNlQnlJZFJlcXVlc3QSHQoKZXhwZW5zZV9pZBgBIAEoCVIJZXhwZW5zZUlk');

@$core.Deprecated('Use getExpenseByIdResponseDescriptor instead')
const GetExpenseByIdResponse$json = {
  '1': 'GetExpenseByIdResponse',
  '2': [
    {'1': 'expense', '3': 1, '4': 1, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expense'},
  ],
};

/// Descriptor for `GetExpenseByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseByIdResponseDescriptor = $convert.base64Decode(
    'ChZHZXRFeHBlbnNlQnlJZFJlc3BvbnNlEiwKB2V4cGVuc2UYASABKAsyEi5wYi5FeHBlbnNlTW'
    'Vzc2FnZVIHZXhwZW5zZQ==');

@$core.Deprecated('Use updateExpenseRequestDescriptor instead')
const UpdateExpenseRequest$json = {
  '1': 'UpdateExpenseRequest',
  '2': [
    {'1': 'expense_id', '3': 1, '4': 1, '5': 9, '10': 'expenseId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'subcategory', '3': 4, '4': 1, '5': 9, '10': 'subcategory'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'merchant', '3': 6, '4': 1, '5': 9, '10': 'merchant'},
    {'1': 'transaction_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'payment_method', '3': 8, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'tags', '3': 9, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateExpenseRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVFeHBlbnNlUmVxdWVzdBIdCgpleHBlbnNlX2lkGAEgASgJUglleHBlbnNlSWQSFg'
    'oGYW1vdW50GAIgASgBUgZhbW91bnQSLwoIY2F0ZWdvcnkYAyABKA4yEy5wYi5FeHBlbnNlQ2F0'
    'ZWdvcnlSCGNhdGVnb3J5EiAKC3N1YmNhdGVnb3J5GAQgASgJUgtzdWJjYXRlZ29yeRIgCgtkZX'
    'NjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SGgoIbWVyY2hhbnQYBiABKAlSCG1lcmNoYW50'
    'EkUKEHRyYW5zYWN0aW9uX2RhdGUYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    '90cmFuc2FjdGlvbkRhdGUSJQoOcGF5bWVudF9tZXRob2QYCCABKAlSDXBheW1lbnRNZXRob2QS'
    'EgoEdGFncxgJIAMoCVIEdGFncxIUCgVub3RlcxgKIAEoCVIFbm90ZXM=');

@$core.Deprecated('Use updateExpenseResponseDescriptor instead')
const UpdateExpenseResponse$json = {
  '1': 'UpdateExpenseResponse',
  '2': [
    {'1': 'expense', '3': 1, '4': 1, '5': 11, '6': '.pb.ExpenseMessage', '10': 'expense'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateExpenseResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVFeHBlbnNlUmVzcG9uc2USLAoHZXhwZW5zZRgBIAEoCzISLnBiLkV4cGVuc2VNZX'
    'NzYWdlUgdleHBlbnNlEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEo'
    'CVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteExpenseRequestDescriptor instead')
const DeleteExpenseRequest$json = {
  '1': 'DeleteExpenseRequest',
  '2': [
    {'1': 'expense_id', '3': 1, '4': 1, '5': 9, '10': 'expenseId'},
  ],
};

/// Descriptor for `DeleteExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteExpenseRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVFeHBlbnNlUmVxdWVzdBIdCgpleHBlbnNlX2lkGAEgASgJUglleHBlbnNlSWQ=');

@$core.Deprecated('Use deleteExpenseResponseDescriptor instead')
const DeleteExpenseResponse$json = {
  '1': 'DeleteExpenseResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteExpenseResponseDescriptor = $convert.base64Decode(
    'ChVEZWxldGVFeHBlbnNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use createBudgetRequestDescriptor instead')
const CreateBudgetRequest$json = {
  '1': 'CreateBudgetRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'period', '3': 5, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
    {'1': 'start_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'enable_alerts', '3': 8, '4': 1, '5': 8, '10': 'enableAlerts'},
    {'1': 'alert_threshold', '3': 9, '4': 1, '5': 1, '10': 'alertThreshold'},
    {'1': 'enforcement_mode', '3': 10, '4': 1, '5': 14, '6': '.pb.BudgetEnforcementMode', '10': 'enforcementMode'},
  ],
};

/// Descriptor for `CreateBudgetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBudgetRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVCdWRnZXRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSFgoGYW1vdW50GAIgAS'
    'gBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5Ei8KCGNhdGVnb3J5GAQgASgO'
    'MhMucGIuRXhwZW5zZUNhdGVnb3J5UghjYXRlZ29yeRIoCgZwZXJpb2QYBSABKA4yEC5wYi5CdW'
    'RnZXRQZXJpb2RSBnBlcmlvZBI5CgpzdGFydF9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAcgASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIHZW5kRGF0ZRIjCg1lbmFibGVfYWxlcnRzGAggASgIUgxlbmFibGVBbGVy'
    'dHMSJwoPYWxlcnRfdGhyZXNob2xkGAkgASgBUg5hbGVydFRocmVzaG9sZBJEChBlbmZvcmNlbW'
    'VudF9tb2RlGAogASgOMhkucGIuQnVkZ2V0RW5mb3JjZW1lbnRNb2RlUg9lbmZvcmNlbWVudE1v'
    'ZGU=');

@$core.Deprecated('Use createBudgetResponseDescriptor instead')
const CreateBudgetResponse$json = {
  '1': 'CreateBudgetResponse',
  '2': [
    {'1': 'budget', '3': 1, '4': 1, '5': 11, '6': '.pb.BudgetMessage', '10': 'budget'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateBudgetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBudgetResponseDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVCdWRnZXRSZXNwb25zZRIpCgZidWRnZXQYASABKAsyES5wYi5CdWRnZXRNZXNzYW'
    'dlUgZidWRnZXQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdt'
    'ZXNzYWdl');

@$core.Deprecated('Use getBudgetsRequestDescriptor instead')
const GetBudgetsRequest$json = {
  '1': 'GetBudgetsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.BudgetStatus', '10': 'status'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
  ],
};

/// Descriptor for `GetBudgetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetsRequestDescriptor = $convert.base64Decode(
    'ChFHZXRCdWRnZXRzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAIgAS'
    'gFUgdwZXJQYWdlEigKBnN0YXR1cxgDIAEoDjIQLnBiLkJ1ZGdldFN0YXR1c1IGc3RhdHVzEi8K'
    'CGNhdGVnb3J5GAQgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UghjYXRlZ29yeQ==');

@$core.Deprecated('Use getBudgetsResponseDescriptor instead')
const GetBudgetsResponse$json = {
  '1': 'GetBudgetsResponse',
  '2': [
    {'1': 'budgets', '3': 1, '4': 3, '5': 11, '6': '.pb.BudgetMessage', '10': 'budgets'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationMetadata', '10': 'pagination'},
    {'1': 'total_budget_amount', '3': 3, '4': 1, '5': 1, '10': 'totalBudgetAmount'},
    {'1': 'total_spent_amount', '3': 4, '4': 1, '5': 1, '10': 'totalSpentAmount'},
  ],
};

/// Descriptor for `GetBudgetsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetsResponseDescriptor = $convert.base64Decode(
    'ChJHZXRCdWRnZXRzUmVzcG9uc2USKwoHYnVkZ2V0cxgBIAMoCzIRLnBiLkJ1ZGdldE1lc3NhZ2'
    'VSB2J1ZGdldHMSNgoKcGFnaW5hdGlvbhgCIAEoCzIWLnBiLlBhZ2luYXRpb25NZXRhZGF0YVIK'
    'cGFnaW5hdGlvbhIuChN0b3RhbF9idWRnZXRfYW1vdW50GAMgASgBUhF0b3RhbEJ1ZGdldEFtb3'
    'VudBIsChJ0b3RhbF9zcGVudF9hbW91bnQYBCABKAFSEHRvdGFsU3BlbnRBbW91bnQ=');

@$core.Deprecated('Use getBudgetByIdRequestDescriptor instead')
const GetBudgetByIdRequest$json = {
  '1': 'GetBudgetByIdRequest',
  '2': [
    {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
  ],
};

/// Descriptor for `GetBudgetByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetByIdRequestDescriptor = $convert.base64Decode(
    'ChRHZXRCdWRnZXRCeUlkUmVxdWVzdBIbCglidWRnZXRfaWQYASABKAlSCGJ1ZGdldElk');

@$core.Deprecated('Use getBudgetByIdResponseDescriptor instead')
const GetBudgetByIdResponse$json = {
  '1': 'GetBudgetByIdResponse',
  '2': [
    {'1': 'budget', '3': 1, '4': 1, '5': 11, '6': '.pb.BudgetMessage', '10': 'budget'},
    {'1': 'recent_expenses', '3': 2, '4': 3, '5': 11, '6': '.pb.ExpenseMessage', '10': 'recentExpenses'},
  ],
};

/// Descriptor for `GetBudgetByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetByIdResponseDescriptor = $convert.base64Decode(
    'ChVHZXRCdWRnZXRCeUlkUmVzcG9uc2USKQoGYnVkZ2V0GAEgASgLMhEucGIuQnVkZ2V0TWVzc2'
    'FnZVIGYnVkZ2V0EjsKD3JlY2VudF9leHBlbnNlcxgCIAMoCzISLnBiLkV4cGVuc2VNZXNzYWdl'
    'Ug5yZWNlbnRFeHBlbnNlcw==');

@$core.Deprecated('Use updateBudgetRequestDescriptor instead')
const UpdateBudgetRequest$json = {
  '1': 'UpdateBudgetRequest',
  '2': [
    {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'period', '3': 4, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
    {'1': 'start_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'enable_alerts', '3': 7, '4': 1, '5': 8, '10': 'enableAlerts'},
    {'1': 'alert_threshold', '3': 8, '4': 1, '5': 1, '10': 'alertThreshold'},
    {'1': 'enforcement_mode', '3': 9, '4': 1, '5': 14, '6': '.pb.BudgetEnforcementMode', '10': 'enforcementMode'},
  ],
};

/// Descriptor for `UpdateBudgetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBudgetRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVCdWRnZXRSZXF1ZXN0EhsKCWJ1ZGdldF9pZBgBIAEoCVIIYnVkZ2V0SWQSEgoEbm'
    'FtZRgCIAEoCVIEbmFtZRIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIoCgZwZXJpb2QYBCABKA4y'
    'EC5wYi5CdWRnZXRQZXJpb2RSBnBlcmlvZBI5CgpzdGFydF9kYXRlGAUgASgLMhouZ29vZ2xlLn'
    'Byb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAYgASgLMhouZ29vZ2xl'
    'LnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIjCg1lbmFibGVfYWxlcnRzGAcgASgIUgxlbm'
    'FibGVBbGVydHMSJwoPYWxlcnRfdGhyZXNob2xkGAggASgBUg5hbGVydFRocmVzaG9sZBJEChBl'
    'bmZvcmNlbWVudF9tb2RlGAkgASgOMhkucGIuQnVkZ2V0RW5mb3JjZW1lbnRNb2RlUg9lbmZvcm'
    'NlbWVudE1vZGU=');

@$core.Deprecated('Use updateBudgetResponseDescriptor instead')
const UpdateBudgetResponse$json = {
  '1': 'UpdateBudgetResponse',
  '2': [
    {'1': 'budget', '3': 1, '4': 1, '5': 11, '6': '.pb.BudgetMessage', '10': 'budget'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateBudgetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBudgetResponseDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVCdWRnZXRSZXNwb25zZRIpCgZidWRnZXQYASABKAsyES5wYi5CdWRnZXRNZXNzYW'
    'dlUgZidWRnZXQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdt'
    'ZXNzYWdl');

@$core.Deprecated('Use deleteBudgetRequestDescriptor instead')
const DeleteBudgetRequest$json = {
  '1': 'DeleteBudgetRequest',
  '2': [
    {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
  ],
};

/// Descriptor for `DeleteBudgetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBudgetRequestDescriptor = $convert.base64Decode(
    'ChNEZWxldGVCdWRnZXRSZXF1ZXN0EhsKCWJ1ZGdldF9pZBgBIAEoCVIIYnVkZ2V0SWQ=');

@$core.Deprecated('Use deleteBudgetResponseDescriptor instead')
const DeleteBudgetResponse$json = {
  '1': 'DeleteBudgetResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteBudgetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBudgetResponseDescriptor = $convert.base64Decode(
    'ChREZWxldGVCdWRnZXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getSpendingAnalyticsRequestDescriptor instead')
const GetSpendingAnalyticsRequest$json = {
  '1': 'GetSpendingAnalyticsRequest',
  '2': [
    {'1': 'period', '3': 1, '4': 1, '5': 9, '10': 'period'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
  ],
};

/// Descriptor for `GetSpendingAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingAnalyticsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRTcGVuZGluZ0FuYWx5dGljc1JlcXVlc3QSFgoGcGVyaW9kGAEgASgJUgZwZXJpb2QSOQ'
    'oKc3RhcnRfZGF0ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0'
    'ZRI1CghlbmRfZGF0ZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdG'
    'USLwoIY2F0ZWdvcnkYBCABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVnb3J5');

@$core.Deprecated('Use getSpendingAnalyticsResponseDescriptor instead')
const GetSpendingAnalyticsResponse$json = {
  '1': 'GetSpendingAnalyticsResponse',
  '2': [
    {'1': 'analytics', '3': 1, '4': 1, '5': 11, '6': '.pb.SpendingAnalytics', '10': 'analytics'},
  ],
};

/// Descriptor for `GetSpendingAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingAnalyticsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRTcGVuZGluZ0FuYWx5dGljc1Jlc3BvbnNlEjMKCWFuYWx5dGljcxgBIAEoCzIVLnBiLl'
    'NwZW5kaW5nQW5hbHl0aWNzUglhbmFseXRpY3M=');

@$core.Deprecated('Use getCategoryBreakdownRequestDescriptor instead')
const GetCategoryBreakdownRequest$json = {
  '1': 'GetCategoryBreakdownRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetCategoryBreakdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryBreakdownRequestDescriptor = $convert.base64Decode(
    'ChtHZXRDYXRlZ29yeUJyZWFrZG93blJlcXVlc3QSOQoKc3RhcnRfZGF0ZRgBIAEoCzIaLmdvb2'
    'dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0ZRgCIAEoCzIaLmdv'
    'b2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGU=');

@$core.Deprecated('Use getCategoryBreakdownResponseDescriptor instead')
const GetCategoryBreakdownResponse$json = {
  '1': 'GetCategoryBreakdownResponse',
  '2': [
    {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.pb.CategorySpending', '10': 'categories'},
    {'1': 'total_spent', '3': 2, '4': 1, '5': 1, '10': 'totalSpent'},
  ],
};

/// Descriptor for `GetCategoryBreakdownResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryBreakdownResponseDescriptor = $convert.base64Decode(
    'ChxHZXRDYXRlZ29yeUJyZWFrZG93blJlc3BvbnNlEjQKCmNhdGVnb3JpZXMYASADKAsyFC5wYi'
    '5DYXRlZ29yeVNwZW5kaW5nUgpjYXRlZ29yaWVzEh8KC3RvdGFsX3NwZW50GAIgASgBUgp0b3Rh'
    'bFNwZW50');

@$core.Deprecated('Use getBudgetProgressRequestDescriptor instead')
const GetBudgetProgressRequest$json = {
  '1': 'GetBudgetProgressRequest',
  '2': [
    {'1': 'period', '3': 1, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'period'},
  ],
};

/// Descriptor for `GetBudgetProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetProgressRequestDescriptor = $convert.base64Decode(
    'ChhHZXRCdWRnZXRQcm9ncmVzc1JlcXVlc3QSKAoGcGVyaW9kGAEgASgOMhAucGIuQnVkZ2V0UG'
    'VyaW9kUgZwZXJpb2Q=');

@$core.Deprecated('Use getBudgetProgressResponseDescriptor instead')
const GetBudgetProgressResponse$json = {
  '1': 'GetBudgetProgressResponse',
  '2': [
    {'1': 'budgets', '3': 1, '4': 3, '5': 11, '6': '.pb.BudgetProgressItem', '10': 'budgets'},
    {'1': 'total_budget', '3': 2, '4': 1, '5': 1, '10': 'totalBudget'},
    {'1': 'total_spent', '3': 3, '4': 1, '5': 1, '10': 'totalSpent'},
    {'1': 'overall_percentage', '3': 4, '4': 1, '5': 1, '10': 'overallPercentage'},
  ],
};

/// Descriptor for `GetBudgetProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetProgressResponseDescriptor = $convert.base64Decode(
    'ChlHZXRCdWRnZXRQcm9ncmVzc1Jlc3BvbnNlEjAKB2J1ZGdldHMYASADKAsyFi5wYi5CdWRnZX'
    'RQcm9ncmVzc0l0ZW1SB2J1ZGdldHMSIQoMdG90YWxfYnVkZ2V0GAIgASgBUgt0b3RhbEJ1ZGdl'
    'dBIfCgt0b3RhbF9zcGVudBgDIAEoAVIKdG90YWxTcGVudBItChJvdmVyYWxsX3BlcmNlbnRhZ2'
    'UYBCABKAFSEW92ZXJhbGxQZXJjZW50YWdl');

@$core.Deprecated('Use getSpendingTrendsRequestDescriptor instead')
const GetSpendingTrendsRequest$json = {
  '1': 'GetSpendingTrendsRequest',
  '2': [
    {'1': 'period_type', '3': 1, '4': 1, '5': 9, '10': 'periodType'},
    {'1': 'periods_count', '3': 2, '4': 1, '5': 5, '10': 'periodsCount'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetSpendingTrendsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingTrendsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRTcGVuZGluZ1RyZW5kc1JlcXVlc3QSHwoLcGVyaW9kX3R5cGUYASABKAlSCnBlcmlvZF'
    'R5cGUSIwoNcGVyaW9kc19jb3VudBgCIAEoBVIMcGVyaW9kc0NvdW50EjUKCGVuZF9kYXRlGAMg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZQ==');

@$core.Deprecated('Use getSpendingTrendsResponseDescriptor instead')
const GetSpendingTrendsResponse$json = {
  '1': 'GetSpendingTrendsResponse',
  '2': [
    {'1': 'trends', '3': 1, '4': 3, '5': 11, '6': '.pb.SpendingTrend', '10': 'trends'},
  ],
};

/// Descriptor for `GetSpendingTrendsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSpendingTrendsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRTcGVuZGluZ1RyZW5kc1Jlc3BvbnNlEikKBnRyZW5kcxgBIAMoCzIRLnBiLlNwZW5kaW'
    '5nVHJlbmRSBnRyZW5kcw==');

@$core.Deprecated('Use getBudgetAlertsRequestDescriptor instead')
const GetBudgetAlertsRequest$json = {
  '1': 'GetBudgetAlertsRequest',
  '2': [
    {'1': 'unread_only', '3': 1, '4': 1, '5': 8, '10': 'unreadOnly'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetBudgetAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetAlertsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRCdWRnZXRBbGVydHNSZXF1ZXN0Eh8KC3VucmVhZF9vbmx5GAEgASgIUgp1bnJlYWRPbm'
    'x5EhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getBudgetAlertsResponseDescriptor instead')
const GetBudgetAlertsResponse$json = {
  '1': 'GetBudgetAlertsResponse',
  '2': [
    {'1': 'alerts', '3': 1, '4': 3, '5': 11, '6': '.pb.BudgetAlertMessage', '10': 'alerts'},
    {'1': 'unread_count', '3': 2, '4': 1, '5': 5, '10': 'unreadCount'},
  ],
};

/// Descriptor for `GetBudgetAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBudgetAlertsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRCdWRnZXRBbGVydHNSZXNwb25zZRIuCgZhbGVydHMYASADKAsyFi5wYi5CdWRnZXRBbG'
    'VydE1lc3NhZ2VSBmFsZXJ0cxIhCgx1bnJlYWRfY291bnQYAiABKAVSC3VucmVhZENvdW50');

@$core.Deprecated('Use markAlertAsReadRequestDescriptor instead')
const MarkAlertAsReadRequest$json = {
  '1': 'MarkAlertAsReadRequest',
  '2': [
    {'1': 'alert_id', '3': 1, '4': 1, '5': 9, '10': 'alertId'},
  ],
};

/// Descriptor for `MarkAlertAsReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAlertAsReadRequestDescriptor = $convert.base64Decode(
    'ChZNYXJrQWxlcnRBc1JlYWRSZXF1ZXN0EhkKCGFsZXJ0X2lkGAEgASgJUgdhbGVydElk');

@$core.Deprecated('Use markAlertAsReadResponseDescriptor instead')
const MarkAlertAsReadResponse$json = {
  '1': 'MarkAlertAsReadResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `MarkAlertAsReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAlertAsReadResponseDescriptor = $convert.base64Decode(
    'ChdNYXJrQWxlcnRBc1JlYWRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use paginationMetadataDescriptor instead')
const PaginationMetadata$json = {
  '1': 'PaginationMetadata',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
    {'1': 'total_pages', '3': 3, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 4, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `PaginationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationMetadataDescriptor = $convert.base64Decode(
    'ChJQYWdpbmF0aW9uTWV0YWRhdGESIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UGFnZR'
    'IZCghwZXJfcGFnZRgCIAEoBVIHcGVyUGFnZRIfCgt0b3RhbF9wYWdlcxgDIAEoBVIKdG90YWxQ'
    'YWdlcxIfCgt0b3RhbF9pdGVtcxgEIAEoBVIKdG90YWxJdGVtcxIZCghoYXNfbmV4dBgFIAEoCF'
    'IHaGFzTmV4dBIZCghoYXNfcHJldhgGIAEoCFIHaGFzUHJldg==');

@$core.Deprecated('Use getAISpendingInsightsRequestDescriptor instead')
const GetAISpendingInsightsRequest$json = {
  '1': 'GetAISpendingInsightsRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'focus_area', '3': 3, '4': 1, '5': 9, '10': 'focusArea'},
  ],
};

/// Descriptor for `GetAISpendingInsightsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAISpendingInsightsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRBSVNwZW5kaW5nSW5zaWdodHNSZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRlEh0KCmZvY3VzX2FyZWEYAyABKAlSCW'
    'ZvY3VzQXJlYQ==');

@$core.Deprecated('Use getAISpendingInsightsResponseDescriptor instead')
const GetAISpendingInsightsResponse$json = {
  '1': 'GetAISpendingInsightsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'summary', '3': 2, '4': 1, '5': 9, '10': 'summary'},
    {'1': 'insights', '3': 3, '4': 3, '5': 11, '6': '.pb.AIInsight', '10': 'insights'},
    {'1': 'recommendations', '3': 4, '4': 3, '5': 11, '6': '.pb.AIRecommendation', '10': 'recommendations'},
    {'1': 'anomalies', '3': 5, '4': 3, '5': 11, '6': '.pb.AnomalyDetection', '10': 'anomalies'},
  ],
};

/// Descriptor for `GetAISpendingInsightsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAISpendingInsightsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRBSVNwZW5kaW5nSW5zaWdodHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhgKB3N1bW1hcnkYAiABKAlSB3N1bW1hcnkSKQoIaW5zaWdodHMYAyADKAsyDS5wYi5BSUlu'
    'c2lnaHRSCGluc2lnaHRzEj4KD3JlY29tbWVuZGF0aW9ucxgEIAMoCzIULnBiLkFJUmVjb21tZW'
    '5kYXRpb25SD3JlY29tbWVuZGF0aW9ucxIyCglhbm9tYWxpZXMYBSADKAsyFC5wYi5Bbm9tYWx5'
    'RGV0ZWN0aW9uUglhbm9tYWxpZXM=');

@$core.Deprecated('Use aIInsightDescriptor instead')
const AIInsight$json = {
  '1': 'AIInsight',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'insight_type', '3': 3, '4': 1, '5': 9, '10': 'insightType'},
    {'1': 'impact_amount', '3': 4, '4': 1, '5': 1, '10': 'impactAmount'},
    {'1': 'supporting_data', '3': 5, '4': 3, '5': 9, '10': 'supportingData'},
  ],
};

/// Descriptor for `AIInsight`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aIInsightDescriptor = $convert.base64Decode(
    'CglBSUluc2lnaHQSFAoFdGl0bGUYASABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAIgASgJUg'
    'tkZXNjcmlwdGlvbhIhCgxpbnNpZ2h0X3R5cGUYAyABKAlSC2luc2lnaHRUeXBlEiMKDWltcGFj'
    'dF9hbW91bnQYBCABKAFSDGltcGFjdEFtb3VudBInCg9zdXBwb3J0aW5nX2RhdGEYBSADKAlSDn'
    'N1cHBvcnRpbmdEYXRh');

@$core.Deprecated('Use aIRecommendationDescriptor instead')
const AIRecommendation$json = {
  '1': 'AIRecommendation',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'action', '3': 3, '4': 1, '5': 9, '10': 'action'},
    {'1': 'potential_savings', '3': 4, '4': 1, '5': 1, '10': 'potentialSavings'},
    {'1': 'priority', '3': 5, '4': 1, '5': 9, '10': 'priority'},
    {'1': 'affected_category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'affectedCategory'},
  ],
};

/// Descriptor for `AIRecommendation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aIRecommendationDescriptor = $convert.base64Decode(
    'ChBBSVJlY29tbWVuZGF0aW9uEhQKBXRpdGxlGAEgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbh'
    'gCIAEoCVILZGVzY3JpcHRpb24SFgoGYWN0aW9uGAMgASgJUgZhY3Rpb24SKwoRcG90ZW50aWFs'
    'X3NhdmluZ3MYBCABKAFSEHBvdGVudGlhbFNhdmluZ3MSGgoIcHJpb3JpdHkYBSABKAlSCHByaW'
    '9yaXR5EkAKEWFmZmVjdGVkX2NhdGVnb3J5GAYgASgOMhMucGIuRXhwZW5zZUNhdGVnb3J5UhBh'
    'ZmZlY3RlZENhdGVnb3J5');

@$core.Deprecated('Use anomalyDetectionDescriptor instead')
const AnomalyDetection$json = {
  '1': 'AnomalyDetection',
  '2': [
    {'1': 'anomaly_type', '3': 1, '4': 1, '5': 9, '10': 'anomalyType'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'detected_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'detectedDate'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'category', '3': 5, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'severity', '3': 6, '4': 1, '5': 9, '10': 'severity'},
  ],
};

/// Descriptor for `AnomalyDetection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anomalyDetectionDescriptor = $convert.base64Decode(
    'ChBBbm9tYWx5RGV0ZWN0aW9uEiEKDGFub21hbHlfdHlwZRgBIAEoCVILYW5vbWFseVR5cGUSIA'
    'oLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEj8KDWRldGVjdGVkX2RhdGUYAyABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxkZXRlY3RlZERhdGUSFgoGYW1vdW50GAQgAS'
    'gBUgZhbW91bnQSLwoIY2F0ZWdvcnkYBSABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcnlSCGNhdGVn'
    'b3J5EhoKCHNldmVyaXR5GAYgASgJUghzZXZlcml0eQ==');

@$core.Deprecated('Use getAIBudgetingRecommendationsRequestDescriptor instead')
const GetAIBudgetingRecommendationsRequest$json = {
  '1': 'GetAIBudgetingRecommendationsRequest',
  '2': [
    {'1': 'monthly_income', '3': 1, '4': 1, '5': 1, '10': 'monthlyIncome'},
    {'1': 'financial_goals', '3': 2, '4': 3, '5': 9, '10': 'financialGoals'},
    {'1': 'risk_tolerance', '3': 3, '4': 1, '5': 9, '10': 'riskTolerance'},
  ],
};

/// Descriptor for `GetAIBudgetingRecommendationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIBudgetingRecommendationsRequestDescriptor = $convert.base64Decode(
    'CiRHZXRBSUJ1ZGdldGluZ1JlY29tbWVuZGF0aW9uc1JlcXVlc3QSJQoObW9udGhseV9pbmNvbW'
    'UYASABKAFSDW1vbnRobHlJbmNvbWUSJwoPZmluYW5jaWFsX2dvYWxzGAIgAygJUg5maW5hbmNp'
    'YWxHb2FscxIlCg5yaXNrX3RvbGVyYW5jZRgDIAEoCVINcmlza1RvbGVyYW5jZQ==');

@$core.Deprecated('Use getAIBudgetingRecommendationsResponseDescriptor instead')
const GetAIBudgetingRecommendationsResponse$json = {
  '1': 'GetAIBudgetingRecommendationsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'summary', '3': 2, '4': 1, '5': 9, '10': 'summary'},
    {'1': 'budget_recommendations', '3': 3, '4': 3, '5': 11, '6': '.pb.BudgetRecommendation', '10': 'budgetRecommendations'},
    {'1': 'recommended_savings_rate', '3': 4, '4': 1, '5': 1, '10': 'recommendedSavingsRate'},
    {'1': 'rationale', '3': 5, '4': 1, '5': 9, '10': 'rationale'},
  ],
};

/// Descriptor for `GetAIBudgetingRecommendationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIBudgetingRecommendationsResponseDescriptor = $convert.base64Decode(
    'CiVHZXRBSUJ1ZGdldGluZ1JlY29tbWVuZGF0aW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKA'
    'hSB3N1Y2Nlc3MSGAoHc3VtbWFyeRgCIAEoCVIHc3VtbWFyeRJPChZidWRnZXRfcmVjb21tZW5k'
    'YXRpb25zGAMgAygLMhgucGIuQnVkZ2V0UmVjb21tZW5kYXRpb25SFWJ1ZGdldFJlY29tbWVuZG'
    'F0aW9ucxI4ChhyZWNvbW1lbmRlZF9zYXZpbmdzX3JhdGUYBCABKAFSFnJlY29tbWVuZGVkU2F2'
    'aW5nc1JhdGUSHAoJcmF0aW9uYWxlGAUgASgJUglyYXRpb25hbGU=');

@$core.Deprecated('Use budgetRecommendationDescriptor instead')
const BudgetRecommendation$json = {
  '1': 'BudgetRecommendation',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'recommended_amount', '3': 3, '4': 1, '5': 1, '10': 'recommendedAmount'},
    {'1': 'current_amount', '3': 4, '4': 1, '5': 1, '10': 'currentAmount'},
    {'1': 'difference', '3': 5, '4': 1, '5': 1, '10': 'difference'},
    {'1': 'reasoning', '3': 6, '4': 1, '5': 9, '10': 'reasoning'},
    {'1': 'recommended_period', '3': 7, '4': 1, '5': 14, '6': '.pb.BudgetPeriod', '10': 'recommendedPeriod'},
  ],
};

/// Descriptor for `BudgetRecommendation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetRecommendationDescriptor = $convert.base64Decode(
    'ChRCdWRnZXRSZWNvbW1lbmRhdGlvbhIvCghjYXRlZ29yeRgBIAEoDjITLnBiLkV4cGVuc2VDYX'
    'RlZ29yeVIIY2F0ZWdvcnkSIwoNY2F0ZWdvcnlfbmFtZRgCIAEoCVIMY2F0ZWdvcnlOYW1lEi0K'
    'EnJlY29tbWVuZGVkX2Ftb3VudBgDIAEoAVIRcmVjb21tZW5kZWRBbW91bnQSJQoOY3VycmVudF'
    '9hbW91bnQYBCABKAFSDWN1cnJlbnRBbW91bnQSHgoKZGlmZmVyZW5jZRgFIAEoAVIKZGlmZmVy'
    'ZW5jZRIcCglyZWFzb25pbmcYBiABKAlSCXJlYXNvbmluZxI/ChJyZWNvbW1lbmRlZF9wZXJpb2'
    'QYByABKA4yEC5wYi5CdWRnZXRQZXJpb2RSEXJlY29tbWVuZGVkUGVyaW9k');

@$core.Deprecated('Use autoCategorizeExpenseRequestDescriptor instead')
const AutoCategorizeExpenseRequest$json = {
  '1': 'AutoCategorizeExpenseRequest',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    {'1': 'merchant', '3': 2, '4': 1, '5': 9, '10': 'merchant'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `AutoCategorizeExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoCategorizeExpenseRequestDescriptor = $convert.base64Decode(
    'ChxBdXRvQ2F0ZWdvcml6ZUV4cGVuc2VSZXF1ZXN0EiAKC2Rlc2NyaXB0aW9uGAEgASgJUgtkZX'
    'NjcmlwdGlvbhIaCghtZXJjaGFudBgCIAEoCVIIbWVyY2hhbnQSFgoGYW1vdW50GAMgASgBUgZh'
    'bW91bnQSFAoFbm90ZXMYBCABKAlSBW5vdGVz');

@$core.Deprecated('Use autoCategorizeExpenseResponseDescriptor instead')
const AutoCategorizeExpenseResponse$json = {
  '1': 'AutoCategorizeExpenseResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'suggested_category', '3': 2, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'suggestedCategory'},
    {'1': 'category_name', '3': 3, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'confidence_score', '3': 4, '4': 1, '5': 1, '10': 'confidenceScore'},
    {'1': 'alternative_categories', '3': 5, '4': 3, '5': 11, '6': '.pb.CategorySuggestion', '10': 'alternativeCategories'},
    {'1': 'reasoning', '3': 6, '4': 1, '5': 9, '10': 'reasoning'},
  ],
};

/// Descriptor for `AutoCategorizeExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoCategorizeExpenseResponseDescriptor = $convert.base64Decode(
    'Ch1BdXRvQ2F0ZWdvcml6ZUV4cGVuc2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEkIKEnN1Z2dlc3RlZF9jYXRlZ29yeRgCIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVIRc3Vn'
    'Z2VzdGVkQ2F0ZWdvcnkSIwoNY2F0ZWdvcnlfbmFtZRgDIAEoCVIMY2F0ZWdvcnlOYW1lEikKEG'
    'NvbmZpZGVuY2Vfc2NvcmUYBCABKAFSD2NvbmZpZGVuY2VTY29yZRJNChZhbHRlcm5hdGl2ZV9j'
    'YXRlZ29yaWVzGAUgAygLMhYucGIuQ2F0ZWdvcnlTdWdnZXN0aW9uUhVhbHRlcm5hdGl2ZUNhdG'
    'Vnb3JpZXMSHAoJcmVhc29uaW5nGAYgASgJUglyZWFzb25pbmc=');

@$core.Deprecated('Use categorySuggestionDescriptor instead')
const CategorySuggestion$json = {
  '1': 'CategorySuggestion',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'confidence_score', '3': 3, '4': 1, '5': 1, '10': 'confidenceScore'},
  ],
};

/// Descriptor for `CategorySuggestion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categorySuggestionDescriptor = $convert.base64Decode(
    'ChJDYXRlZ29yeVN1Z2dlc3Rpb24SLwoIY2F0ZWdvcnkYASABKA4yEy5wYi5FeHBlbnNlQ2F0ZW'
    'dvcnlSCGNhdGVnb3J5EiMKDWNhdGVnb3J5X25hbWUYAiABKAlSDGNhdGVnb3J5TmFtZRIpChBj'
    'b25maWRlbmNlX3Njb3JlGAMgASgBUg9jb25maWRlbmNlU2NvcmU=');

@$core.Deprecated('Use getAIFinancialAdviceRequestDescriptor instead')
const GetAIFinancialAdviceRequest$json = {
  '1': 'GetAIFinancialAdviceRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'context_areas', '3': 2, '4': 3, '5': 9, '10': 'contextAreas'},
  ],
};

/// Descriptor for `GetAIFinancialAdviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIFinancialAdviceRequestDescriptor = $convert.base64Decode(
    'ChtHZXRBSUZpbmFuY2lhbEFkdmljZVJlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EiMKDW'
    'NvbnRleHRfYXJlYXMYAiADKAlSDGNvbnRleHRBcmVhcw==');

@$core.Deprecated('Use getAIFinancialAdviceResponseDescriptor instead')
const GetAIFinancialAdviceResponse$json = {
  '1': 'GetAIFinancialAdviceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    {'1': 'advice', '3': 3, '4': 1, '5': 9, '10': 'advice'},
    {'1': 'action_steps', '3': 4, '4': 3, '5': 11, '6': '.pb.ActionStep', '10': 'actionSteps'},
    {'1': 'relevant_resources', '3': 5, '4': 3, '5': 9, '10': 'relevantResources'},
    {'1': 'disclaimer', '3': 6, '4': 1, '5': 9, '10': 'disclaimer'},
  ],
};

/// Descriptor for `GetAIFinancialAdviceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIFinancialAdviceResponseDescriptor = $convert.base64Decode(
    'ChxHZXRBSUZpbmFuY2lhbEFkdmljZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSFAoFcXVlcnkYAiABKAlSBXF1ZXJ5EhYKBmFkdmljZRgDIAEoCVIGYWR2aWNlEjEKDGFjdGlv'
    'bl9zdGVwcxgEIAMoCzIOLnBiLkFjdGlvblN0ZXBSC2FjdGlvblN0ZXBzEi0KEnJlbGV2YW50X3'
    'Jlc291cmNlcxgFIAMoCVIRcmVsZXZhbnRSZXNvdXJjZXMSHgoKZGlzY2xhaW1lchgGIAEoCVIK'
    'ZGlzY2xhaW1lcg==');

@$core.Deprecated('Use actionStepDescriptor instead')
const ActionStep$json = {
  '1': 'ActionStep',
  '2': [
    {'1': 'step_number', '3': 1, '4': 1, '5': 5, '10': 'stepNumber'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'estimated_impact', '3': 4, '4': 1, '5': 9, '10': 'estimatedImpact'},
    {'1': 'is_completed', '3': 5, '4': 1, '5': 8, '10': 'isCompleted'},
  ],
};

/// Descriptor for `ActionStep`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionStepDescriptor = $convert.base64Decode(
    'CgpBY3Rpb25TdGVwEh8KC3N0ZXBfbnVtYmVyGAEgASgFUgpzdGVwTnVtYmVyEhQKBXRpdGxlGA'
    'IgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SKQoQZXN0aW1h'
    'dGVkX2ltcGFjdBgEIAEoCVIPZXN0aW1hdGVkSW1wYWN0EiEKDGlzX2NvbXBsZXRlZBgFIAEoCF'
    'ILaXNDb21wbGV0ZWQ=');

@$core.Deprecated('Use incomeSourceDescriptor instead')
const IncomeSource$json = {
  '1': 'IncomeSource',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.IncomeCategory', '10': 'category'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_pattern', '3': 8, '4': 1, '5': 9, '10': 'recurrencePattern'},
    {'1': 'last_received', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastReceived'},
    {'1': 'next_expected', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextExpected'},
    {'1': 'is_active', '3': 11, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `IncomeSource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomeSourceDescriptor = $convert.base64Decode(
    'CgxJbmNvbWVTb3VyY2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'ISCgRuYW1lGAMgASgJUgRuYW1lEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5'
    'GAUgASgJUghjdXJyZW5jeRIuCghjYXRlZ29yeRgGIAEoDjISLnBiLkluY29tZUNhdGVnb3J5Ug'
    'hjYXRlZ29yeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEi0KEnJlY3VycmVu'
    'Y2VfcGF0dGVybhgIIAEoCVIRcmVjdXJyZW5jZVBhdHRlcm4SPwoNbGFzdF9yZWNlaXZlZBgJIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGxhc3RSZWNlaXZlZBI/Cg1uZXh0X2V4'
    'cGVjdGVkGAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMbmV4dEV4cGVjdGVkEh'
    'sKCWlzX2FjdGl2ZRgLIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA0gASgLMhouZ2'
    '9vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use incomeBreakdownDescriptor instead')
const IncomeBreakdown$json = {
  '1': 'IncomeBreakdown',
  '2': [
    {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.pb.IncomeCategoryData', '10': 'categories'},
    {'1': 'total_income', '3': 2, '4': 1, '5': 1, '10': 'totalIncome'},
    {'1': 'period', '3': 3, '4': 1, '5': 9, '10': 'period'},
  ],
};

/// Descriptor for `IncomeBreakdown`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomeBreakdownDescriptor = $convert.base64Decode(
    'Cg9JbmNvbWVCcmVha2Rvd24SNgoKY2F0ZWdvcmllcxgBIAMoCzIWLnBiLkluY29tZUNhdGVnb3'
    'J5RGF0YVIKY2F0ZWdvcmllcxIhCgx0b3RhbF9pbmNvbWUYAiABKAFSC3RvdGFsSW5jb21lEhYK'
    'BnBlcmlvZBgDIAEoCVIGcGVyaW9k');

@$core.Deprecated('Use incomeCategoryDataDescriptor instead')
const IncomeCategoryData$json = {
  '1': 'IncomeCategoryData',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.pb.IncomeCategory', '10': 'category'},
    {'1': 'category_name', '3': 2, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
    {'1': 'source_count', '3': 5, '4': 1, '5': 5, '10': 'sourceCount'},
  ],
};

/// Descriptor for `IncomeCategoryData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomeCategoryDataDescriptor = $convert.base64Decode(
    'ChJJbmNvbWVDYXRlZ29yeURhdGESLgoIY2F0ZWdvcnkYASABKA4yEi5wYi5JbmNvbWVDYXRlZ2'
    '9yeVIIY2F0ZWdvcnkSIwoNY2F0ZWdvcnlfbmFtZRgCIAEoCVIMY2F0ZWdvcnlOYW1lEhYKBmFt'
    'b3VudBgDIAEoAVIGYW1vdW50Eh4KCnBlcmNlbnRhZ2UYBCABKAFSCnBlcmNlbnRhZ2USIQoMc2'
    '91cmNlX2NvdW50GAUgASgFUgtzb3VyY2VDb3VudA==');

@$core.Deprecated('Use investmentDescriptor instead')
const Investment$json = {
  '1': 'Investment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'investment_type', '3': 4, '4': 1, '5': 14, '6': '.pb.InvestmentType', '10': 'investmentType'},
    {'1': 'current_value', '3': 5, '4': 1, '5': 1, '10': 'currentValue'},
    {'1': 'initial_investment', '3': 6, '4': 1, '5': 1, '10': 'initialInvestment'},
    {'1': 'gain_loss', '3': 7, '4': 1, '5': 1, '10': 'gainLoss'},
    {'1': 'gain_loss_percentage', '3': 8, '4': 1, '5': 1, '10': 'gainLossPercentage'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'purchase_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'purchaseDate'},
    {'1': 'last_updated', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'ticker_symbol', '3': 12, '4': 1, '5': 9, '10': 'tickerSymbol'},
    {'1': 'quantity', '3': 13, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'current_price', '3': 14, '4': 1, '5': 1, '10': 'currentPrice'},
  ],
};

/// Descriptor for `Investment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentDescriptor = $convert.base64Decode(
    'CgpJbnZlc3RtZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSEg'
    'oEbmFtZRgDIAEoCVIEbmFtZRI7Cg9pbnZlc3RtZW50X3R5cGUYBCABKA4yEi5wYi5JbnZlc3Rt'
    'ZW50VHlwZVIOaW52ZXN0bWVudFR5cGUSIwoNY3VycmVudF92YWx1ZRgFIAEoAVIMY3VycmVudF'
    'ZhbHVlEi0KEmluaXRpYWxfaW52ZXN0bWVudBgGIAEoAVIRaW5pdGlhbEludmVzdG1lbnQSGwoJ'
    'Z2Fpbl9sb3NzGAcgASgBUghnYWluTG9zcxIwChRnYWluX2xvc3NfcGVyY2VudGFnZRgIIAEoAV'
    'ISZ2Fpbkxvc3NQZXJjZW50YWdlEhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRI/Cg1wdXJj'
    'aGFzZV9kYXRlGAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcHVyY2hhc2VEYX'
    'RlEj0KDGxhc3RfdXBkYXRlZBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xh'
    'c3RVcGRhdGVkEiMKDXRpY2tlcl9zeW1ib2wYDCABKAlSDHRpY2tlclN5bWJvbBIaCghxdWFudG'
    'l0eRgNIAEoBVIIcXVhbnRpdHkSIwoNY3VycmVudF9wcmljZRgOIAEoAVIMY3VycmVudFByaWNl');

@$core.Deprecated('Use investmentPortfolioDescriptor instead')
const InvestmentPortfolio$json = {
  '1': 'InvestmentPortfolio',
  '2': [
    {'1': 'investments', '3': 1, '4': 3, '5': 11, '6': '.pb.InvestmentTypeData', '10': 'investments'},
    {'1': 'total_value', '3': 2, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'total_invested', '3': 3, '4': 1, '5': 1, '10': 'totalInvested'},
    {'1': 'total_gain_loss', '3': 4, '4': 1, '5': 1, '10': 'totalGainLoss'},
    {'1': 'total_gain_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'totalGainLossPercentage'},
  ],
};

/// Descriptor for `InvestmentPortfolio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentPortfolioDescriptor = $convert.base64Decode(
    'ChNJbnZlc3RtZW50UG9ydGZvbGlvEjgKC2ludmVzdG1lbnRzGAEgAygLMhYucGIuSW52ZXN0bW'
    'VudFR5cGVEYXRhUgtpbnZlc3RtZW50cxIfCgt0b3RhbF92YWx1ZRgCIAEoAVIKdG90YWxWYWx1'
    'ZRIlCg50b3RhbF9pbnZlc3RlZBgDIAEoAVINdG90YWxJbnZlc3RlZBImCg90b3RhbF9nYWluX2'
    'xvc3MYBCABKAFSDXRvdGFsR2Fpbkxvc3MSOwoadG90YWxfZ2Fpbl9sb3NzX3BlcmNlbnRhZ2UY'
    'BSABKAFSF3RvdGFsR2Fpbkxvc3NQZXJjZW50YWdl');

@$core.Deprecated('Use investmentTypeDataDescriptor instead')
const InvestmentTypeData$json = {
  '1': 'InvestmentTypeData',
  '2': [
    {'1': 'investment_type', '3': 1, '4': 1, '5': 14, '6': '.pb.InvestmentType', '10': 'investmentType'},
    {'1': 'type_name', '3': 2, '4': 1, '5': 9, '10': 'typeName'},
    {'1': 'current_value', '3': 3, '4': 1, '5': 1, '10': 'currentValue'},
    {'1': 'gain_loss', '3': 4, '4': 1, '5': 1, '10': 'gainLoss'},
    {'1': 'gain_loss_percentage', '3': 5, '4': 1, '5': 1, '10': 'gainLossPercentage'},
    {'1': 'asset_count', '3': 6, '4': 1, '5': 5, '10': 'assetCount'},
  ],
};

/// Descriptor for `InvestmentTypeData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List investmentTypeDataDescriptor = $convert.base64Decode(
    'ChJJbnZlc3RtZW50VHlwZURhdGESOwoPaW52ZXN0bWVudF90eXBlGAEgASgOMhIucGIuSW52ZX'
    'N0bWVudFR5cGVSDmludmVzdG1lbnRUeXBlEhsKCXR5cGVfbmFtZRgCIAEoCVIIdHlwZU5hbWUS'
    'IwoNY3VycmVudF92YWx1ZRgDIAEoAVIMY3VycmVudFZhbHVlEhsKCWdhaW5fbG9zcxgEIAEoAV'
    'IIZ2Fpbkxvc3MSMAoUZ2Fpbl9sb3NzX3BlcmNlbnRhZ2UYBSABKAFSEmdhaW5Mb3NzUGVyY2Vu'
    'dGFnZRIfCgthc3NldF9jb3VudBgGIAEoBVIKYXNzZXRDb3VudA==');

@$core.Deprecated('Use financialGoalDescriptor instead')
const FinancialGoal$json = {
  '1': 'FinancialGoal',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'goal_type', '3': 4, '4': 1, '5': 14, '6': '.pb.GoalType', '10': 'goalType'},
    {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'current_amount', '3': 6, '4': 1, '5': 1, '10': 'currentAmount'},
    {'1': 'monthly_contribution', '3': 7, '4': 1, '5': 1, '10': 'monthlyContribution'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'target_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.GoalStatus', '10': 'status'},
    {'1': 'percentage_complete', '3': 11, '4': 1, '5': 1, '10': 'percentageComplete'},
    {'1': 'months_remaining', '3': 12, '4': 1, '5': 5, '10': 'monthsRemaining'},
    {'1': 'icon', '3': 13, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'color', '3': 14, '4': 1, '5': 9, '10': 'color'},
    {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `FinancialGoal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List financialGoalDescriptor = $convert.base64Decode(
    'Cg1GaW5hbmNpYWxHb2FsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySW'
    'QSEgoEbmFtZRgDIAEoCVIEbmFtZRIpCglnb2FsX3R5cGUYBCABKA4yDC5wYi5Hb2FsVHlwZVII'
    'Z29hbFR5cGUSIwoNdGFyZ2V0X2Ftb3VudBgFIAEoAVIMdGFyZ2V0QW1vdW50EiUKDmN1cnJlbn'
    'RfYW1vdW50GAYgASgBUg1jdXJyZW50QW1vdW50EjEKFG1vbnRobHlfY29udHJpYnV0aW9uGAcg'
    'ASgBUhNtb250aGx5Q29udHJpYnV0aW9uEhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRI7Cg'
    't0YXJnZXRfZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnRhcmdldERh'
    'dGUSJgoGc3RhdHVzGAogASgOMg4ucGIuR29hbFN0YXR1c1IGc3RhdHVzEi8KE3BlcmNlbnRhZ2'
    'VfY29tcGxldGUYCyABKAFSEnBlcmNlbnRhZ2VDb21wbGV0ZRIpChBtb250aHNfcmVtYWluaW5n'
    'GAwgASgFUg9tb250aHNSZW1haW5pbmcSEgoEaWNvbhgNIAEoCVIEaWNvbhIUCgVjb2xvchgOIA'
    'EoCVIFY29sb3ISOQoKY3JlYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use financialGoalsListDescriptor instead')
const FinancialGoalsList$json = {
  '1': 'FinancialGoalsList',
  '2': [
    {'1': 'goals', '3': 1, '4': 3, '5': 11, '6': '.pb.FinancialGoal', '10': 'goals'},
    {'1': 'total_target', '3': 2, '4': 1, '5': 1, '10': 'totalTarget'},
    {'1': 'total_saved', '3': 3, '4': 1, '5': 1, '10': 'totalSaved'},
    {'1': 'active_goals_count', '3': 4, '4': 1, '5': 5, '10': 'activeGoalsCount'},
  ],
};

/// Descriptor for `FinancialGoalsList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List financialGoalsListDescriptor = $convert.base64Decode(
    'ChJGaW5hbmNpYWxHb2Fsc0xpc3QSJwoFZ29hbHMYASADKAsyES5wYi5GaW5hbmNpYWxHb2FsUg'
    'Vnb2FscxIhCgx0b3RhbF90YXJnZXQYAiABKAFSC3RvdGFsVGFyZ2V0Eh8KC3RvdGFsX3NhdmVk'
    'GAMgASgBUgp0b3RhbFNhdmVkEiwKEmFjdGl2ZV9nb2Fsc19jb3VudBgEIAEoBVIQYWN0aXZlR2'
    '9hbHNDb3VudA==');

@$core.Deprecated('Use savingsGoalDescriptor instead')
const SavingsGoal$json = {
  '1': 'SavingsGoal',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'target_amount', '3': 4, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'current_amount', '3': 5, '4': 1, '5': 1, '10': 'currentAmount'},
    {'1': 'percentage_complete', '3': 6, '4': 1, '5': 1, '10': 'percentageComplete'},
    {'1': 'target_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `SavingsGoal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List savingsGoalDescriptor = $convert.base64Decode(
    'CgtTYXZpbmdzR29hbBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    'IKBG5hbWUYAyABKAlSBG5hbWUSIwoNdGFyZ2V0X2Ftb3VudBgEIAEoAVIMdGFyZ2V0QW1vdW50'
    'EiUKDmN1cnJlbnRfYW1vdW50GAUgASgBUg1jdXJyZW50QW1vdW50Ei8KE3BlcmNlbnRhZ2VfY2'
    '9tcGxldGUYBiABKAFSEnBlcmNlbnRhZ2VDb21wbGV0ZRI7Cgt0YXJnZXRfZGF0ZRgHIAEoCzIa'
    'Lmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnRhcmdldERhdGUSOQoKY3JlYXRlZF9hdBgIIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0'
    'GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use recurringBillDescriptor instead')
const RecurringBill$json = {
  '1': 'RecurringBill',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 6, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'recurrence_pattern', '3': 7, '4': 1, '5': 9, '10': 'recurrencePattern'},
    {'1': 'next_due_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextDueDate'},
    {'1': 'last_paid_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastPaidDate'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.BillStatus', '10': 'status'},
    {'1': 'days_until_due', '3': 11, '4': 1, '5': 5, '10': 'daysUntilDue'},
    {'1': 'merchant', '3': 12, '4': 1, '5': 9, '10': 'merchant'},
    {'1': 'icon', '3': 13, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'auto_pay_enabled', '3': 14, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `RecurringBill`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringBillDescriptor = $convert.base64Decode(
    'Cg1SZWN1cnJpbmdCaWxsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySW'
    'QSEgoEbmFtZRgDIAEoCVIEbmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5j'
    'eRgFIAEoCVIIY3VycmVuY3kSLwoIY2F0ZWdvcnkYBiABKA4yEy5wYi5FeHBlbnNlQ2F0ZWdvcn'
    'lSCGNhdGVnb3J5Ei0KEnJlY3VycmVuY2VfcGF0dGVybhgHIAEoCVIRcmVjdXJyZW5jZVBhdHRl'
    'cm4SPgoNbmV4dF9kdWVfZGF0ZRgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2'
    '5leHREdWVEYXRlEkAKDmxhc3RfcGFpZF9kYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRp'
    'bWVzdGFtcFIMbGFzdFBhaWREYXRlEiYKBnN0YXR1cxgKIAEoDjIOLnBiLkJpbGxTdGF0dXNSBn'
    'N0YXR1cxIkCg5kYXlzX3VudGlsX2R1ZRgLIAEoBVIMZGF5c1VudGlsRHVlEhoKCG1lcmNoYW50'
    'GAwgASgJUghtZXJjaGFudBISCgRpY29uGA0gASgJUgRpY29uEigKEGF1dG9fcGF5X2VuYWJsZW'
    'QYDiABKAhSDmF1dG9QYXlFbmFibGVkEjkKCmNyZWF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgQIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use upcomingBillsListDescriptor instead')
const UpcomingBillsList$json = {
  '1': 'UpcomingBillsList',
  '2': [
    {'1': 'bills', '3': 1, '4': 3, '5': 11, '6': '.pb.RecurringBill', '10': 'bills'},
    {'1': 'total_upcoming', '3': 2, '4': 1, '5': 1, '10': 'totalUpcoming'},
    {'1': 'bills_count', '3': 3, '4': 1, '5': 5, '10': 'billsCount'},
  ],
};

/// Descriptor for `UpcomingBillsList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upcomingBillsListDescriptor = $convert.base64Decode(
    'ChFVcGNvbWluZ0JpbGxzTGlzdBInCgViaWxscxgBIAMoCzIRLnBiLlJlY3VycmluZ0JpbGxSBW'
    'JpbGxzEiUKDnRvdGFsX3VwY29taW5nGAIgASgBUg10b3RhbFVwY29taW5nEh8KC2JpbGxzX2Nv'
    'dW50GAMgASgFUgpiaWxsc0NvdW50');

@$core.Deprecated('Use createIncomeSourceRequestDescriptor instead')
const CreateIncomeSourceRequest$json = {
  '1': 'CreateIncomeSourceRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.IncomeCategory', '10': 'category'},
    {'1': 'is_recurring', '3': 5, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_pattern', '3': 6, '4': 1, '5': 9, '10': 'recurrencePattern'},
    {'1': 'last_received', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastReceived'},
    {'1': 'next_expected', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextExpected'},
  ],
};

/// Descriptor for `CreateIncomeSourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIncomeSourceRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVJbmNvbWVTb3VyY2VSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSFgoGYW1vdW'
    '50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5Ei4KCGNhdGVnb3J5'
    'GAQgASgOMhIucGIuSW5jb21lQ2F0ZWdvcnlSCGNhdGVnb3J5EiEKDGlzX3JlY3VycmluZxgFIA'
    'EoCFILaXNSZWN1cnJpbmcSLQoScmVjdXJyZW5jZV9wYXR0ZXJuGAYgASgJUhFyZWN1cnJlbmNl'
    'UGF0dGVybhI/Cg1sYXN0X3JlY2VpdmVkGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIMbGFzdFJlY2VpdmVkEj8KDW5leHRfZXhwZWN0ZWQYCCABKAsyGi5nb29nbGUucHJvdG9i'
    'dWYuVGltZXN0YW1wUgxuZXh0RXhwZWN0ZWQ=');

@$core.Deprecated('Use createIncomeSourceResponseDescriptor instead')
const CreateIncomeSourceResponse$json = {
  '1': 'CreateIncomeSourceResponse',
  '2': [
    {'1': 'income_source', '3': 1, '4': 1, '5': 11, '6': '.pb.IncomeSource', '10': 'incomeSource'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateIncomeSourceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIncomeSourceResponseDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVJbmNvbWVTb3VyY2VSZXNwb25zZRI1Cg1pbmNvbWVfc291cmNlGAEgASgLMhAucG'
    'IuSW5jb21lU291cmNlUgxpbmNvbWVTb3VyY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIY'
    'CgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getIncomeSourcesRequestDescriptor instead')
const GetIncomeSourcesRequest$json = {
  '1': 'GetIncomeSourcesRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetIncomeSourcesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeSourcesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRJbmNvbWVTb3VyY2VzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aXZlT2'
    '5seQ==');

@$core.Deprecated('Use getIncomeSourcesResponseDescriptor instead')
const GetIncomeSourcesResponse$json = {
  '1': 'GetIncomeSourcesResponse',
  '2': [
    {'1': 'income_sources', '3': 1, '4': 3, '5': 11, '6': '.pb.IncomeSource', '10': 'incomeSources'},
    {'1': 'total_monthly_income', '3': 2, '4': 1, '5': 1, '10': 'totalMonthlyIncome'},
  ],
};

/// Descriptor for `GetIncomeSourcesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeSourcesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRJbmNvbWVTb3VyY2VzUmVzcG9uc2USNwoOaW5jb21lX3NvdXJjZXMYASADKAsyEC5wYi'
    '5JbmNvbWVTb3VyY2VSDWluY29tZVNvdXJjZXMSMAoUdG90YWxfbW9udGhseV9pbmNvbWUYAiAB'
    'KAFSEnRvdGFsTW9udGhseUluY29tZQ==');

@$core.Deprecated('Use getIncomeBreakdownRequestDescriptor instead')
const GetIncomeBreakdownRequest$json = {
  '1': 'GetIncomeBreakdownRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetIncomeBreakdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeBreakdownRequestDescriptor = $convert.base64Decode(
    'ChlHZXRJbmNvbWVCcmVha2Rvd25SZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb29nbG'
    'UucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl');

@$core.Deprecated('Use getIncomeBreakdownResponseDescriptor instead')
const GetIncomeBreakdownResponse$json = {
  '1': 'GetIncomeBreakdownResponse',
  '2': [
    {'1': 'breakdown', '3': 1, '4': 1, '5': 11, '6': '.pb.IncomeBreakdown', '10': 'breakdown'},
  ],
};

/// Descriptor for `GetIncomeBreakdownResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomeBreakdownResponseDescriptor = $convert.base64Decode(
    'ChpHZXRJbmNvbWVCcmVha2Rvd25SZXNwb25zZRIxCglicmVha2Rvd24YASABKAsyEy5wYi5Jbm'
    'NvbWVCcmVha2Rvd25SCWJyZWFrZG93bg==');

@$core.Deprecated('Use getInvestmentPortfolioRequestDescriptor instead')
const GetInvestmentPortfolioRequest$json = {
  '1': 'GetInvestmentPortfolioRequest',
};

/// Descriptor for `GetInvestmentPortfolioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentPortfolioRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRJbnZlc3RtZW50UG9ydGZvbGlvUmVxdWVzdA==');

@$core.Deprecated('Use getInvestmentPortfolioResponseDescriptor instead')
const GetInvestmentPortfolioResponse$json = {
  '1': 'GetInvestmentPortfolioResponse',
  '2': [
    {'1': 'portfolio', '3': 1, '4': 1, '5': 11, '6': '.pb.InvestmentPortfolio', '10': 'portfolio'},
    {'1': 'individual_investments', '3': 2, '4': 3, '5': 11, '6': '.pb.Investment', '10': 'individualInvestments'},
  ],
};

/// Descriptor for `GetInvestmentPortfolioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvestmentPortfolioResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRJbnZlc3RtZW50UG9ydGZvbGlvUmVzcG9uc2USNQoJcG9ydGZvbGlvGAEgASgLMhcucG'
    'IuSW52ZXN0bWVudFBvcnRmb2xpb1IJcG9ydGZvbGlvEkUKFmluZGl2aWR1YWxfaW52ZXN0bWVu'
    'dHMYAiADKAsyDi5wYi5JbnZlc3RtZW50UhVpbmRpdmlkdWFsSW52ZXN0bWVudHM=');

@$core.Deprecated('Use createInvestmentRequestDescriptor instead')
const CreateInvestmentRequest$json = {
  '1': 'CreateInvestmentRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'investment_type', '3': 2, '4': 1, '5': 14, '6': '.pb.InvestmentType', '10': 'investmentType'},
    {'1': 'initial_investment', '3': 3, '4': 1, '5': 1, '10': 'initialInvestment'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'purchase_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'purchaseDate'},
    {'1': 'ticker_symbol', '3': 6, '4': 1, '5': 9, '10': 'tickerSymbol'},
    {'1': 'quantity', '3': 7, '4': 1, '5': 5, '10': 'quantity'},
  ],
};

/// Descriptor for `CreateInvestmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVJbnZlc3RtZW50UmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEjsKD2ludmVzdG'
    '1lbnRfdHlwZRgCIAEoDjISLnBiLkludmVzdG1lbnRUeXBlUg5pbnZlc3RtZW50VHlwZRItChJp'
    'bml0aWFsX2ludmVzdG1lbnQYAyABKAFSEWluaXRpYWxJbnZlc3RtZW50EhoKCGN1cnJlbmN5GA'
    'QgASgJUghjdXJyZW5jeRI/Cg1wdXJjaGFzZV9kYXRlGAUgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIMcHVyY2hhc2VEYXRlEiMKDXRpY2tlcl9zeW1ib2wYBiABKAlSDHRpY2tlcl'
    'N5bWJvbBIaCghxdWFudGl0eRgHIAEoBVIIcXVhbnRpdHk=');

@$core.Deprecated('Use createInvestmentResponseDescriptor instead')
const CreateInvestmentResponse$json = {
  '1': 'CreateInvestmentResponse',
  '2': [
    {'1': 'investment', '3': 1, '4': 1, '5': 11, '6': '.pb.Investment', '10': 'investment'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInvestmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvestmentResponseDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVJbnZlc3RtZW50UmVzcG9uc2USLgoKaW52ZXN0bWVudBgBIAEoCzIOLnBiLkludm'
    'VzdG1lbnRSCmludmVzdG1lbnQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdl'
    'GAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use createFinancialGoalRequestDescriptor instead')
const CreateFinancialGoalRequest$json = {
  '1': 'CreateFinancialGoalRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'goal_type', '3': 2, '4': 1, '5': 14, '6': '.pb.GoalType', '10': 'goalType'},
    {'1': 'target_amount', '3': 3, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'current_amount', '3': 4, '4': 1, '5': 1, '10': 'currentAmount'},
    {'1': 'monthly_contribution', '3': 5, '4': 1, '5': 1, '10': 'monthlyContribution'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'target_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
    {'1': 'icon', '3': 8, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'color', '3': 9, '4': 1, '5': 9, '10': 'color'},
  ],
};

/// Descriptor for `CreateFinancialGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFinancialGoalRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVGaW5hbmNpYWxHb2FsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEikKCWdvYW'
    'xfdHlwZRgCIAEoDjIMLnBiLkdvYWxUeXBlUghnb2FsVHlwZRIjCg10YXJnZXRfYW1vdW50GAMg'
    'ASgBUgx0YXJnZXRBbW91bnQSJQoOY3VycmVudF9hbW91bnQYBCABKAFSDWN1cnJlbnRBbW91bn'
    'QSMQoUbW9udGhseV9jb250cmlidXRpb24YBSABKAFSE21vbnRobHlDb250cmlidXRpb24SGgoI'
    'Y3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EjsKC3RhcmdldF9kYXRlGAcgASgLMhouZ29vZ2xlLn'
    'Byb3RvYnVmLlRpbWVzdGFtcFIKdGFyZ2V0RGF0ZRISCgRpY29uGAggASgJUgRpY29uEhQKBWNv'
    'bG9yGAkgASgJUgVjb2xvcg==');

@$core.Deprecated('Use createFinancialGoalResponseDescriptor instead')
const CreateFinancialGoalResponse$json = {
  '1': 'CreateFinancialGoalResponse',
  '2': [
    {'1': 'goal', '3': 1, '4': 1, '5': 11, '6': '.pb.FinancialGoal', '10': 'goal'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateFinancialGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFinancialGoalResponseDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVGaW5hbmNpYWxHb2FsUmVzcG9uc2USJQoEZ29hbBgBIAEoCzIRLnBiLkZpbmFuY2'
    'lhbEdvYWxSBGdvYWwSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJ'
    'UgdtZXNzYWdl');

@$core.Deprecated('Use getFinancialGoalsRequestDescriptor instead')
const GetFinancialGoalsRequest$json = {
  '1': 'GetFinancialGoalsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.pb.GoalStatus', '10': 'status'},
  ],
};

/// Descriptor for `GetFinancialGoalsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialGoalsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRGaW5hbmNpYWxHb2Fsc1JlcXVlc3QSJgoGc3RhdHVzGAEgASgOMg4ucGIuR29hbFN0YX'
    'R1c1IGc3RhdHVz');

@$core.Deprecated('Use getFinancialGoalsResponseDescriptor instead')
const GetFinancialGoalsResponse$json = {
  '1': 'GetFinancialGoalsResponse',
  '2': [
    {'1': 'goals_list', '3': 1, '4': 1, '5': 11, '6': '.pb.FinancialGoalsList', '10': 'goalsList'},
  ],
};

/// Descriptor for `GetFinancialGoalsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialGoalsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRGaW5hbmNpYWxHb2Fsc1Jlc3BvbnNlEjUKCmdvYWxzX2xpc3QYASABKAsyFi5wYi5GaW'
    '5hbmNpYWxHb2Fsc0xpc3RSCWdvYWxzTGlzdA==');

@$core.Deprecated('Use updateFinancialGoalProgressRequestDescriptor instead')
const UpdateFinancialGoalProgressRequest$json = {
  '1': 'UpdateFinancialGoalProgressRequest',
  '2': [
    {'1': 'goal_id', '3': 1, '4': 1, '5': 9, '10': 'goalId'},
    {'1': 'amount_to_add', '3': 2, '4': 1, '5': 1, '10': 'amountToAdd'},
  ],
};

/// Descriptor for `UpdateFinancialGoalProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFinancialGoalProgressRequestDescriptor = $convert.base64Decode(
    'CiJVcGRhdGVGaW5hbmNpYWxHb2FsUHJvZ3Jlc3NSZXF1ZXN0EhcKB2dvYWxfaWQYASABKAlSBm'
    'dvYWxJZBIiCg1hbW91bnRfdG9fYWRkGAIgASgBUgthbW91bnRUb0FkZA==');

@$core.Deprecated('Use updateFinancialGoalProgressResponseDescriptor instead')
const UpdateFinancialGoalProgressResponse$json = {
  '1': 'UpdateFinancialGoalProgressResponse',
  '2': [
    {'1': 'goal', '3': 1, '4': 1, '5': 11, '6': '.pb.FinancialGoal', '10': 'goal'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateFinancialGoalProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFinancialGoalProgressResponseDescriptor = $convert.base64Decode(
    'CiNVcGRhdGVGaW5hbmNpYWxHb2FsUHJvZ3Jlc3NSZXNwb25zZRIlCgRnb2FsGAEgASgLMhEucG'
    'IuRmluYW5jaWFsR29hbFIEZ29hbBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhgKB21lc3Nh'
    'Z2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getSavingsGoalRequestDescriptor instead')
const GetSavingsGoalRequest$json = {
  '1': 'GetSavingsGoalRequest',
};

/// Descriptor for `GetSavingsGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSavingsGoalRequestDescriptor = $convert.base64Decode(
    'ChVHZXRTYXZpbmdzR29hbFJlcXVlc3Q=');

@$core.Deprecated('Use getSavingsGoalResponseDescriptor instead')
const GetSavingsGoalResponse$json = {
  '1': 'GetSavingsGoalResponse',
  '2': [
    {'1': 'savings_goal', '3': 1, '4': 1, '5': 11, '6': '.pb.SavingsGoal', '10': 'savingsGoal'},
    {'1': 'has_goal', '3': 2, '4': 1, '5': 8, '10': 'hasGoal'},
  ],
};

/// Descriptor for `GetSavingsGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSavingsGoalResponseDescriptor = $convert.base64Decode(
    'ChZHZXRTYXZpbmdzR29hbFJlc3BvbnNlEjIKDHNhdmluZ3NfZ29hbBgBIAEoCzIPLnBiLlNhdm'
    'luZ3NHb2FsUgtzYXZpbmdzR29hbBIZCghoYXNfZ29hbBgCIAEoCFIHaGFzR29hbA==');

@$core.Deprecated('Use createOrUpdateSavingsGoalRequestDescriptor instead')
const CreateOrUpdateSavingsGoalRequest$json = {
  '1': 'CreateOrUpdateSavingsGoalRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'target_amount', '3': 2, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'current_amount', '3': 3, '4': 1, '5': 1, '10': 'currentAmount'},
    {'1': 'target_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'targetDate'},
  ],
};

/// Descriptor for `CreateOrUpdateSavingsGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrUpdateSavingsGoalRequestDescriptor = $convert.base64Decode(
    'CiBDcmVhdGVPclVwZGF0ZVNhdmluZ3NHb2FsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEi'
    'MKDXRhcmdldF9hbW91bnQYAiABKAFSDHRhcmdldEFtb3VudBIlCg5jdXJyZW50X2Ftb3VudBgD'
    'IAEoAVINY3VycmVudEFtb3VudBI7Cgt0YXJnZXRfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2'
    'J1Zi5UaW1lc3RhbXBSCnRhcmdldERhdGU=');

@$core.Deprecated('Use createOrUpdateSavingsGoalResponseDescriptor instead')
const CreateOrUpdateSavingsGoalResponse$json = {
  '1': 'CreateOrUpdateSavingsGoalResponse',
  '2': [
    {'1': 'savings_goal', '3': 1, '4': 1, '5': 11, '6': '.pb.SavingsGoal', '10': 'savingsGoal'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateOrUpdateSavingsGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrUpdateSavingsGoalResponseDescriptor = $convert.base64Decode(
    'CiFDcmVhdGVPclVwZGF0ZVNhdmluZ3NHb2FsUmVzcG9uc2USMgoMc2F2aW5nc19nb2FsGAEgAS'
    'gLMg8ucGIuU2F2aW5nc0dvYWxSC3NhdmluZ3NHb2FsEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nl'
    'c3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use createRecurringBillRequestDescriptor instead')
const CreateRecurringBillRequest$json = {
  '1': 'CreateRecurringBillRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.pb.ExpenseCategory', '10': 'category'},
    {'1': 'recurrence_pattern', '3': 5, '4': 1, '5': 9, '10': 'recurrencePattern'},
    {'1': 'next_due_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextDueDate'},
    {'1': 'merchant', '3': 7, '4': 1, '5': 9, '10': 'merchant'},
    {'1': 'icon', '3': 8, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'auto_pay_enabled', '3': 9, '4': 1, '5': 8, '10': 'autoPayEnabled'},
  ],
};

/// Descriptor for `CreateRecurringBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringBillRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVSZWN1cnJpbmdCaWxsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhYKBmFtb3'
    'VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIvCghjYXRlZ29y'
    'eRgEIAEoDjITLnBiLkV4cGVuc2VDYXRlZ29yeVIIY2F0ZWdvcnkSLQoScmVjdXJyZW5jZV9wYX'
    'R0ZXJuGAUgASgJUhFyZWN1cnJlbmNlUGF0dGVybhI+Cg1uZXh0X2R1ZV9kYXRlGAYgASgLMhou'
    'Z29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbmV4dER1ZURhdGUSGgoIbWVyY2hhbnQYByABKA'
    'lSCG1lcmNoYW50EhIKBGljb24YCCABKAlSBGljb24SKAoQYXV0b19wYXlfZW5hYmxlZBgJIAEo'
    'CFIOYXV0b1BheUVuYWJsZWQ=');

@$core.Deprecated('Use createRecurringBillResponseDescriptor instead')
const CreateRecurringBillResponse$json = {
  '1': 'CreateRecurringBillResponse',
  '2': [
    {'1': 'bill', '3': 1, '4': 1, '5': 11, '6': '.pb.RecurringBill', '10': 'bill'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateRecurringBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringBillResponseDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVSZWN1cnJpbmdCaWxsUmVzcG9uc2USJQoEYmlsbBgBIAEoCzIRLnBiLlJlY3Vycm'
    'luZ0JpbGxSBGJpbGwSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJ'
    'UgdtZXNzYWdl');

@$core.Deprecated('Use getUpcomingBillsRequestDescriptor instead')
const GetUpcomingBillsRequest$json = {
  '1': 'GetUpcomingBillsRequest',
  '2': [
    {'1': 'days_ahead', '3': 1, '4': 1, '5': 5, '10': 'daysAhead'},
  ],
};

/// Descriptor for `GetUpcomingBillsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpcomingBillsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVcGNvbWluZ0JpbGxzUmVxdWVzdBIdCgpkYXlzX2FoZWFkGAEgASgFUglkYXlzQWhlYW'
    'Q=');

@$core.Deprecated('Use getUpcomingBillsResponseDescriptor instead')
const GetUpcomingBillsResponse$json = {
  '1': 'GetUpcomingBillsResponse',
  '2': [
    {'1': 'bills_list', '3': 1, '4': 1, '5': 11, '6': '.pb.UpcomingBillsList', '10': 'billsList'},
  ],
};

/// Descriptor for `GetUpcomingBillsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpcomingBillsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVcGNvbWluZ0JpbGxzUmVzcG9uc2USNAoKYmlsbHNfbGlzdBgBIAEoCzIVLnBiLlVwY2'
    '9taW5nQmlsbHNMaXN0UgliaWxsc0xpc3Q=');

@$core.Deprecated('Use trackedIncomeTransactionDescriptor instead')
const TrackedIncomeTransaction$json = {
  '1': 'TrackedIncomeTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'source_type', '3': 5, '4': 1, '5': 9, '10': 'sourceType'},
    {'1': 'source_id', '3': 6, '4': 1, '5': 9, '10': 'sourceId'},
    {'1': 'source_reference', '3': 7, '4': 1, '5': 9, '10': 'sourceReference'},
    {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'sender_id', '3': 10, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'sender_name', '3': 11, '4': 1, '5': 9, '10': 'senderName'},
    {'1': 'transaction_date', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TrackedIncomeTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackedIncomeTransactionDescriptor = $convert.base64Decode(
    'ChhUcmFja2VkSW5jb21lVHJhbnNhY3Rpb24SDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAi'
    'ABKAlSBnVzZXJJZBIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVII'
    'Y3VycmVuY3kSHwoLc291cmNlX3R5cGUYBSABKAlSCnNvdXJjZVR5cGUSGwoJc291cmNlX2lkGA'
    'YgASgJUghzb3VyY2VJZBIpChBzb3VyY2VfcmVmZXJlbmNlGAcgASgJUg9zb3VyY2VSZWZlcmVu'
    'Y2USGgoIY2F0ZWdvcnkYCCABKAlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGAkgASgJUgtkZX'
    'NjcmlwdGlvbhIbCglzZW5kZXJfaWQYCiABKAlSCHNlbmRlcklkEh8KC3NlbmRlcl9uYW1lGAsg'
    'ASgJUgpzZW5kZXJOYW1lEkUKEHRyYW5zYWN0aW9uX2RhdGUYDCABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wUg90cmFuc2FjdGlvbkRhdGUSGgoIbWV0YWRhdGEYDSABKAlSCG1ldGFk'
    'YXRhEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcm'
    'VhdGVkQXQ=');

@$core.Deprecated('Use trackedExpenditureTransactionDescriptor instead')
const TrackedExpenditureTransaction$json = {
  '1': 'TrackedExpenditureTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'expense_type', '3': 5, '4': 1, '5': 9, '10': 'expenseType'},
    {'1': 'expense_id', '3': 6, '4': 1, '5': 9, '10': 'expenseId'},
    {'1': 'expense_reference', '3': 7, '4': 1, '5': 9, '10': 'expenseReference'},
    {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    {'1': 'recipient_id', '3': 9, '4': 1, '5': 9, '10': 'recipientId'},
    {'1': 'recipient_name', '3': 10, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'merchant', '3': 11, '4': 1, '5': 9, '10': 'merchant'},
    {'1': 'description', '3': 12, '4': 1, '5': 9, '10': 'description'},
    {'1': 'transaction_date', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'metadata', '3': 14, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TrackedExpenditureTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackedExpenditureTransactionDescriptor = $convert.base64Decode(
    'Ch1UcmFja2VkRXhwZW5kaXR1cmVUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl'
    '9pZBgCIAEoCVIGdXNlcklkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAQg'
    'ASgJUghjdXJyZW5jeRIhCgxleHBlbnNlX3R5cGUYBSABKAlSC2V4cGVuc2VUeXBlEh0KCmV4cG'
    'Vuc2VfaWQYBiABKAlSCWV4cGVuc2VJZBIrChFleHBlbnNlX3JlZmVyZW5jZRgHIAEoCVIQZXhw'
    'ZW5zZVJlZmVyZW5jZRIaCghjYXRlZ29yeRgIIAEoCVIIY2F0ZWdvcnkSIQoMcmVjaXBpZW50X2'
    'lkGAkgASgJUgtyZWNpcGllbnRJZBIlCg5yZWNpcGllbnRfbmFtZRgKIAEoCVINcmVjaXBpZW50'
    'TmFtZRIaCghtZXJjaGFudBgLIAEoCVIIbWVyY2hhbnQSIAoLZGVzY3JpcHRpb24YDCABKAlSC2'
    'Rlc2NyaXB0aW9uEkUKEHRyYW5zYWN0aW9uX2RhdGUYDSABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUg90cmFuc2FjdGlvbkRhdGUSGgoIbWV0YWRhdGEYDiABKAlSCG1ldGFkYXRhEj'
    'kKCmNyZWF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVk'
    'QXQ=');

@$core.Deprecated('Use getTrackedIncomeRequestDescriptor instead')
const GetTrackedIncomeRequest$json = {
  '1': 'GetTrackedIncomeRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetTrackedIncomeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedIncomeRequestDescriptor = $convert.base64Decode(
    'ChdHZXRUcmFja2VkSW5jb21lUmVxdWVzdBI5CgpzdGFydF9kYXRlGAEgASgLMhouZ29vZ2xlLn'
    'Byb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAIgASgLMhouZ29vZ2xl'
    'LnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZQ==');

@$core.Deprecated('Use getTrackedIncomeResponseDescriptor instead')
const GetTrackedIncomeResponse$json = {
  '1': 'GetTrackedIncomeResponse',
  '2': [
    {'1': 'total_income', '3': 1, '4': 1, '5': 1, '10': 'totalIncome'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GetTrackedIncomeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedIncomeResponseDescriptor = $convert.base64Decode(
    'ChhHZXRUcmFja2VkSW5jb21lUmVzcG9uc2USIQoMdG90YWxfaW5jb21lGAEgASgBUgt0b3RhbE'
    'luY29tZRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use getTrackedExpenditureRequestDescriptor instead')
const GetTrackedExpenditureRequest$json = {
  '1': 'GetTrackedExpenditureRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetTrackedExpenditureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedExpenditureRequestDescriptor = $convert.base64Decode(
    'ChxHZXRUcmFja2VkRXhwZW5kaXR1cmVSZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl');

@$core.Deprecated('Use getTrackedExpenditureResponseDescriptor instead')
const GetTrackedExpenditureResponse$json = {
  '1': 'GetTrackedExpenditureResponse',
  '2': [
    {'1': 'total_expenditure', '3': 1, '4': 1, '5': 1, '10': 'totalExpenditure'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GetTrackedExpenditureResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedExpenditureResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRUcmFja2VkRXhwZW5kaXR1cmVSZXNwb25zZRIrChF0b3RhbF9leHBlbmRpdHVyZRgBIA'
    'EoAVIQdG90YWxFeHBlbmRpdHVyZRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use getTrackedIncomeBreakdownRequestDescriptor instead')
const GetTrackedIncomeBreakdownRequest$json = {
  '1': 'GetTrackedIncomeBreakdownRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetTrackedIncomeBreakdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedIncomeBreakdownRequestDescriptor = $convert.base64Decode(
    'CiBHZXRUcmFja2VkSW5jb21lQnJlYWtkb3duUmVxdWVzdBI5CgpzdGFydF9kYXRlGAEgASgLMh'
    'ouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAIgASgL'
    'MhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZQ==');

@$core.Deprecated('Use getTrackedIncomeBreakdownResponseDescriptor instead')
const GetTrackedIncomeBreakdownResponse$json = {
  '1': 'GetTrackedIncomeBreakdownResponse',
  '2': [
    {'1': 'breakdown_by_source', '3': 1, '4': 3, '5': 11, '6': '.pb.GetTrackedIncomeBreakdownResponse.BreakdownBySourceEntry', '10': 'breakdownBySource'},
    {'1': 'total_income', '3': 2, '4': 1, '5': 1, '10': 'totalIncome'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
  ],
  '3': [GetTrackedIncomeBreakdownResponse_BreakdownBySourceEntry$json],
};

@$core.Deprecated('Use getTrackedIncomeBreakdownResponseDescriptor instead')
const GetTrackedIncomeBreakdownResponse_BreakdownBySourceEntry$json = {
  '1': 'BreakdownBySourceEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetTrackedIncomeBreakdownResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedIncomeBreakdownResponseDescriptor = $convert.base64Decode(
    'CiFHZXRUcmFja2VkSW5jb21lQnJlYWtkb3duUmVzcG9uc2USbAoTYnJlYWtkb3duX2J5X3NvdX'
    'JjZRgBIAMoCzI8LnBiLkdldFRyYWNrZWRJbmNvbWVCcmVha2Rvd25SZXNwb25zZS5CcmVha2Rv'
    'd25CeVNvdXJjZUVudHJ5UhFicmVha2Rvd25CeVNvdXJjZRIhCgx0b3RhbF9pbmNvbWUYAiABKA'
    'FSC3RvdGFsSW5jb21lEhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3MaRAoWQnJlYWtkb3duQnlT'
    'b3VyY2VFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoAVIFdmFsdWU6AjgB');

@$core.Deprecated('Use getTrackedExpenditureBreakdownRequestDescriptor instead')
const GetTrackedExpenditureBreakdownRequest$json = {
  '1': 'GetTrackedExpenditureBreakdownRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetTrackedExpenditureBreakdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedExpenditureBreakdownRequestDescriptor = $convert.base64Decode(
    'CiVHZXRUcmFja2VkRXhwZW5kaXR1cmVCcmVha2Rvd25SZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYAS'
    'ABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUY'
    'AiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl');

@$core.Deprecated('Use getTrackedExpenditureBreakdownResponseDescriptor instead')
const GetTrackedExpenditureBreakdownResponse$json = {
  '1': 'GetTrackedExpenditureBreakdownResponse',
  '2': [
    {'1': 'breakdown_by_type', '3': 1, '4': 3, '5': 11, '6': '.pb.GetTrackedExpenditureBreakdownResponse.BreakdownByTypeEntry', '10': 'breakdownByType'},
    {'1': 'total_expenditure', '3': 2, '4': 1, '5': 1, '10': 'totalExpenditure'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
  ],
  '3': [GetTrackedExpenditureBreakdownResponse_BreakdownByTypeEntry$json],
};

@$core.Deprecated('Use getTrackedExpenditureBreakdownResponseDescriptor instead')
const GetTrackedExpenditureBreakdownResponse_BreakdownByTypeEntry$json = {
  '1': 'BreakdownByTypeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetTrackedExpenditureBreakdownResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedExpenditureBreakdownResponseDescriptor = $convert.base64Decode(
    'CiZHZXRUcmFja2VkRXhwZW5kaXR1cmVCcmVha2Rvd25SZXNwb25zZRJrChFicmVha2Rvd25fYn'
    'lfdHlwZRgBIAMoCzI/LnBiLkdldFRyYWNrZWRFeHBlbmRpdHVyZUJyZWFrZG93blJlc3BvbnNl'
    'LkJyZWFrZG93bkJ5VHlwZUVudHJ5Ug9icmVha2Rvd25CeVR5cGUSKwoRdG90YWxfZXhwZW5kaX'
    'R1cmUYAiABKAFSEHRvdGFsRXhwZW5kaXR1cmUSGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxpC'
    'ChRCcmVha2Rvd25CeVR5cGVFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoAV'
    'IFdmFsdWU6AjgB');

@$core.Deprecated('Use getTrackedIncomeTransactionsRequestDescriptor instead')
const GetTrackedIncomeTransactionsRequest$json = {
  '1': 'GetTrackedIncomeTransactionsRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTrackedIncomeTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedIncomeTransactionsRequestDescriptor = $convert.base64Decode(
    'CiNHZXRUcmFja2VkSW5jb21lVHJhbnNhY3Rpb25zUmVxdWVzdBI5CgpzdGFydF9kYXRlGAEgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAIg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIUCgVsaW1pdBgDIAEoBV'
    'IFbGltaXQ=');

@$core.Deprecated('Use getTrackedIncomeTransactionsResponseDescriptor instead')
const GetTrackedIncomeTransactionsResponse$json = {
  '1': 'GetTrackedIncomeTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.TrackedIncomeTransaction', '10': 'transactions'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GetTrackedIncomeTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedIncomeTransactionsResponseDescriptor = $convert.base64Decode(
    'CiRHZXRUcmFja2VkSW5jb21lVHJhbnNhY3Rpb25zUmVzcG9uc2USQAoMdHJhbnNhY3Rpb25zGA'
    'EgAygLMhwucGIuVHJhY2tlZEluY29tZVRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSHwoLdG90'
    'YWxfY291bnQYAiABKAVSCnRvdGFsQ291bnQSGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use getTrackedExpenditureTransactionsRequestDescriptor instead')
const GetTrackedExpenditureTransactionsRequest$json = {
  '1': 'GetTrackedExpenditureTransactionsRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTrackedExpenditureTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedExpenditureTransactionsRequestDescriptor = $convert.base64Decode(
    'CihHZXRUcmFja2VkRXhwZW5kaXR1cmVUcmFuc2FjdGlvbnNSZXF1ZXN0EjkKCnN0YXJ0X2RhdG'
    'UYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2Rh'
    'dGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRlEhQKBWxpbWl0GA'
    'MgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getTrackedExpenditureTransactionsResponseDescriptor instead')
const GetTrackedExpenditureTransactionsResponse$json = {
  '1': 'GetTrackedExpenditureTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.TrackedExpenditureTransaction', '10': 'transactions'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GetTrackedExpenditureTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackedExpenditureTransactionsResponseDescriptor = $convert.base64Decode(
    'CilHZXRUcmFja2VkRXhwZW5kaXR1cmVUcmFuc2FjdGlvbnNSZXNwb25zZRJFCgx0cmFuc2FjdG'
    'lvbnMYASADKAsyIS5wYi5UcmFja2VkRXhwZW5kaXR1cmVUcmFuc2FjdGlvblIMdHJhbnNhY3Rp'
    'b25zEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50EhgKB3N1Y2Nlc3MYAyABKAhSB3'
    'N1Y2Nlc3M=');

@$core.Deprecated('Use getComprehensiveFinancialSummaryRequestDescriptor instead')
const GetComprehensiveFinancialSummaryRequest$json = {
  '1': 'GetComprehensiveFinancialSummaryRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetComprehensiveFinancialSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComprehensiveFinancialSummaryRequestDescriptor = $convert.base64Decode(
    'CidHZXRDb21wcmVoZW5zaXZlRmluYW5jaWFsU3VtbWFyeVJlcXVlc3QSOQoKc3RhcnRfZGF0ZR'
    'gBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0'
    'ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGU=');

@$core.Deprecated('Use getComprehensiveFinancialSummaryResponseDescriptor instead')
const GetComprehensiveFinancialSummaryResponse$json = {
  '1': 'GetComprehensiveFinancialSummaryResponse',
  '2': [
    {'1': 'summary', '3': 1, '4': 1, '5': 11, '6': '.pb.ComprehensiveFinancialSummary', '10': 'summary'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GetComprehensiveFinancialSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComprehensiveFinancialSummaryResponseDescriptor = $convert.base64Decode(
    'CihHZXRDb21wcmVoZW5zaXZlRmluYW5jaWFsU3VtbWFyeVJlc3BvbnNlEjsKB3N1bW1hcnkYAS'
    'ABKAsyIS5wYi5Db21wcmVoZW5zaXZlRmluYW5jaWFsU3VtbWFyeVIHc3VtbWFyeRIYCgdzdWNj'
    'ZXNzGAIgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use comprehensiveFinancialSummaryDescriptor instead')
const ComprehensiveFinancialSummary$json = {
  '1': 'ComprehensiveFinancialSummary',
  '2': [
    {'1': 'period', '3': 1, '4': 1, '5': 11, '6': '.pb.ComprehensivePeriod', '10': 'period'},
    {'1': 'income', '3': 2, '4': 1, '5': 11, '6': '.pb.ComprehensiveIncomeData', '10': 'income'},
    {'1': 'expenditure', '3': 3, '4': 1, '5': 11, '6': '.pb.ComprehensiveExpenditureData', '10': 'expenditure'},
    {'1': 'net_income', '3': 4, '4': 1, '5': 1, '10': 'netIncome'},
    {'1': 'savings_rate', '3': 5, '4': 1, '5': 1, '10': 'savingsRate'},
  ],
};

/// Descriptor for `ComprehensiveFinancialSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comprehensiveFinancialSummaryDescriptor = $convert.base64Decode(
    'Ch1Db21wcmVoZW5zaXZlRmluYW5jaWFsU3VtbWFyeRIvCgZwZXJpb2QYASABKAsyFy5wYi5Db2'
    '1wcmVoZW5zaXZlUGVyaW9kUgZwZXJpb2QSMwoGaW5jb21lGAIgASgLMhsucGIuQ29tcHJlaGVu'
    'c2l2ZUluY29tZURhdGFSBmluY29tZRJCCgtleHBlbmRpdHVyZRgDIAEoCzIgLnBiLkNvbXByZW'
    'hlbnNpdmVFeHBlbmRpdHVyZURhdGFSC2V4cGVuZGl0dXJlEh0KCm5ldF9pbmNvbWUYBCABKAFS'
    'CW5ldEluY29tZRIhCgxzYXZpbmdzX3JhdGUYBSABKAFSC3NhdmluZ3NSYXRl');

@$core.Deprecated('Use comprehensivePeriodDescriptor instead')
const ComprehensivePeriod$json = {
  '1': 'ComprehensivePeriod',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `ComprehensivePeriod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comprehensivePeriodDescriptor = $convert.base64Decode(
    'ChNDb21wcmVoZW5zaXZlUGVyaW9kEjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUgdlbmREYXRl');

@$core.Deprecated('Use comprehensiveIncomeDataDescriptor instead')
const ComprehensiveIncomeData$json = {
  '1': 'ComprehensiveIncomeData',
  '2': [
    {'1': 'manual_income', '3': 1, '4': 1, '5': 1, '10': 'manualIncome'},
    {'1': 'tracked_income', '3': 2, '4': 1, '5': 1, '10': 'trackedIncome'},
    {'1': 'total_income', '3': 3, '4': 1, '5': 1, '10': 'totalIncome'},
    {'1': 'income_breakdown', '3': 4, '4': 3, '5': 11, '6': '.pb.ComprehensiveIncomeData.IncomeBreakdownEntry', '10': 'incomeBreakdown'},
  ],
  '3': [ComprehensiveIncomeData_IncomeBreakdownEntry$json],
};

@$core.Deprecated('Use comprehensiveIncomeDataDescriptor instead')
const ComprehensiveIncomeData_IncomeBreakdownEntry$json = {
  '1': 'IncomeBreakdownEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ComprehensiveIncomeData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comprehensiveIncomeDataDescriptor = $convert.base64Decode(
    'ChdDb21wcmVoZW5zaXZlSW5jb21lRGF0YRIjCg1tYW51YWxfaW5jb21lGAEgASgBUgxtYW51YW'
    'xJbmNvbWUSJQoOdHJhY2tlZF9pbmNvbWUYAiABKAFSDXRyYWNrZWRJbmNvbWUSIQoMdG90YWxf'
    'aW5jb21lGAMgASgBUgt0b3RhbEluY29tZRJbChBpbmNvbWVfYnJlYWtkb3duGAQgAygLMjAucG'
    'IuQ29tcHJlaGVuc2l2ZUluY29tZURhdGEuSW5jb21lQnJlYWtkb3duRW50cnlSD2luY29tZUJy'
    'ZWFrZG93bhpCChRJbmNvbWVCcmVha2Rvd25FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YW'
    'x1ZRgCIAEoAVIFdmFsdWU6AjgB');

@$core.Deprecated('Use comprehensiveExpenditureDataDescriptor instead')
const ComprehensiveExpenditureData$json = {
  '1': 'ComprehensiveExpenditureData',
  '2': [
    {'1': 'manual_expenses', '3': 1, '4': 1, '5': 1, '10': 'manualExpenses'},
    {'1': 'tracked_expenditure', '3': 2, '4': 1, '5': 1, '10': 'trackedExpenditure'},
    {'1': 'total_expenditure', '3': 3, '4': 1, '5': 1, '10': 'totalExpenditure'},
    {'1': 'expenditure_breakdown', '3': 4, '4': 3, '5': 11, '6': '.pb.ComprehensiveExpenditureData.ExpenditureBreakdownEntry', '10': 'expenditureBreakdown'},
  ],
  '3': [ComprehensiveExpenditureData_ExpenditureBreakdownEntry$json],
};

@$core.Deprecated('Use comprehensiveExpenditureDataDescriptor instead')
const ComprehensiveExpenditureData_ExpenditureBreakdownEntry$json = {
  '1': 'ExpenditureBreakdownEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ComprehensiveExpenditureData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comprehensiveExpenditureDataDescriptor = $convert.base64Decode(
    'ChxDb21wcmVoZW5zaXZlRXhwZW5kaXR1cmVEYXRhEicKD21hbnVhbF9leHBlbnNlcxgBIAEoAV'
    'IObWFudWFsRXhwZW5zZXMSLwoTdHJhY2tlZF9leHBlbmRpdHVyZRgCIAEoAVISdHJhY2tlZEV4'
    'cGVuZGl0dXJlEisKEXRvdGFsX2V4cGVuZGl0dXJlGAMgASgBUhB0b3RhbEV4cGVuZGl0dXJlEm'
    '8KFWV4cGVuZGl0dXJlX2JyZWFrZG93bhgEIAMoCzI6LnBiLkNvbXByZWhlbnNpdmVFeHBlbmRp'
    'dHVyZURhdGEuRXhwZW5kaXR1cmVCcmVha2Rvd25FbnRyeVIUZXhwZW5kaXR1cmVCcmVha2Rvd2'
    '4aRwoZRXhwZW5kaXR1cmVCcmVha2Rvd25FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1'
    'ZRgCIAEoAVIFdmFsdWU6AjgB');

@$core.Deprecated('Use validateCategoryBudgetRequestDescriptor instead')
const ValidateCategoryBudgetRequest$json = {
  '1': 'ValidateCategoryBudgetRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'budget_category', '3': 2, '4': 1, '5': 5, '10': 'budgetCategory'},
    {'1': 'amount_minor', '3': 3, '4': 1, '5': 3, '10': 'amountMinor'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `ValidateCategoryBudgetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCategoryBudgetRequestDescriptor = $convert.base64Decode(
    'Ch1WYWxpZGF0ZUNhdGVnb3J5QnVkZ2V0UmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySW'
    'QSJwoPYnVkZ2V0X2NhdGVnb3J5GAIgASgFUg5idWRnZXRDYXRlZ29yeRIhCgxhbW91bnRfbWlu'
    'b3IYAyABKANSC2Ftb3VudE1pbm9yEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeQ==');

@$core.Deprecated('Use validateCategoryBudgetResponseDescriptor instead')
const ValidateCategoryBudgetResponse$json = {
  '1': 'ValidateCategoryBudgetResponse',
  '2': [
    {'1': 'allowed', '3': 1, '4': 1, '5': 8, '10': 'allowed'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'current_spent', '3': 3, '4': 1, '5': 1, '10': 'currentSpent'},
    {'1': 'budget_limit', '3': 4, '4': 1, '5': 1, '10': 'budgetLimit'},
    {'1': 'percentage_used', '3': 5, '4': 1, '5': 1, '10': 'percentageUsed'},
    {'1': 'remaining', '3': 6, '4': 1, '5': 1, '10': 'remaining'},
    {'1': 'matching_budgets', '3': 7, '4': 3, '5': 11, '6': '.pb.BudgetInfo', '10': 'matchingBudgets'},
  ],
};

/// Descriptor for `ValidateCategoryBudgetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCategoryBudgetResponseDescriptor = $convert.base64Decode(
    'Ch5WYWxpZGF0ZUNhdGVnb3J5QnVkZ2V0UmVzcG9uc2USGAoHYWxsb3dlZBgBIAEoCFIHYWxsb3'
    'dlZBIWCgZyZWFzb24YAiABKAlSBnJlYXNvbhIjCg1jdXJyZW50X3NwZW50GAMgASgBUgxjdXJy'
    'ZW50U3BlbnQSIQoMYnVkZ2V0X2xpbWl0GAQgASgBUgtidWRnZXRMaW1pdBInCg9wZXJjZW50YW'
    'dlX3VzZWQYBSABKAFSDnBlcmNlbnRhZ2VVc2VkEhwKCXJlbWFpbmluZxgGIAEoAVIJcmVtYWlu'
    'aW5nEjkKEG1hdGNoaW5nX2J1ZGdldHMYByADKAsyDi5wYi5CdWRnZXRJbmZvUg9tYXRjaGluZ0'
    'J1ZGdldHM=');

@$core.Deprecated('Use budgetInfoDescriptor instead')
const BudgetInfo$json = {
  '1': 'BudgetInfo',
  '2': [
    {'1': 'budget_id', '3': 1, '4': 1, '5': 9, '10': 'budgetId'},
    {'1': 'budget_name', '3': 2, '4': 1, '5': 9, '10': 'budgetName'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'spent', '3': 4, '4': 1, '5': 1, '10': 'spent'},
    {'1': 'percentage', '3': 5, '4': 1, '5': 1, '10': 'percentage'},
    {'1': 'days_remaining', '3': 6, '4': 1, '5': 5, '10': 'daysRemaining'},
    {'1': 'start_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `BudgetInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetInfoDescriptor = $convert.base64Decode(
    'CgpCdWRnZXRJbmZvEhsKCWJ1ZGdldF9pZBgBIAEoCVIIYnVkZ2V0SWQSHwoLYnVkZ2V0X25hbW'
    'UYAiABKAlSCmJ1ZGdldE5hbWUSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSFAoFc3BlbnQYBCAB'
    'KAFSBXNwZW50Eh4KCnBlcmNlbnRhZ2UYBSABKAFSCnBlcmNlbnRhZ2USJQoOZGF5c19yZW1haW'
    '5pbmcYBiABKAVSDWRheXNSZW1haW5pbmcSOQoKc3RhcnRfZGF0ZRgHIAEoCzIaLmdvb2dsZS5w'
    'cm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0ZRgIIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGUSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use getServiceCategoriesRequestDescriptor instead')
const GetServiceCategoriesRequest$json = {
  '1': 'GetServiceCategoriesRequest',
  '2': [
    {'1': 'service_name', '3': 1, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetServiceCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceCategoriesRequestDescriptor = $convert.base64Decode(
    'ChtHZXRTZXJ2aWNlQ2F0ZWdvcmllc1JlcXVlc3QSIQoMc2VydmljZV9uYW1lGAEgASgJUgtzZX'
    'J2aWNlTmFtZRIfCgthY3RpdmVfb25seRgCIAEoCFIKYWN0aXZlT25seQ==');

@$core.Deprecated('Use getServiceCategoriesResponseDescriptor instead')
const GetServiceCategoriesResponse$json = {
  '1': 'GetServiceCategoriesResponse',
  '2': [
    {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.pb.ServiceCategoryItem', '10': 'categories'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GetServiceCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceCategoriesResponseDescriptor = $convert.base64Decode(
    'ChxHZXRTZXJ2aWNlQ2F0ZWdvcmllc1Jlc3BvbnNlEjcKCmNhdGVnb3JpZXMYASADKAsyFy5wYi'
    '5TZXJ2aWNlQ2F0ZWdvcnlJdGVtUgpjYXRlZ29yaWVzEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nl'
    'c3M=');

@$core.Deprecated('Use serviceCategoryItemDescriptor instead')
const ServiceCategoryItem$json = {
  '1': 'ServiceCategoryItem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'service_name', '3': 2, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'sub_category_name', '3': 3, '4': 1, '5': 9, '10': 'subCategoryName'},
    {'1': 'budget_category', '3': 4, '4': 1, '5': 5, '10': 'budgetCategory'},
    {'1': 'display_name', '3': 5, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'icon', '3': 6, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'color', '3': 7, '4': 1, '5': 9, '10': 'color'},
    {'1': 'is_active', '3': 8, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `ServiceCategoryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceCategoryItemDescriptor = $convert.base64Decode(
    'ChNTZXJ2aWNlQ2F0ZWdvcnlJdGVtEg4KAmlkGAEgASgJUgJpZBIhCgxzZXJ2aWNlX25hbWUYAi'
    'ABKAlSC3NlcnZpY2VOYW1lEioKEXN1Yl9jYXRlZ29yeV9uYW1lGAMgASgJUg9zdWJDYXRlZ29y'
    'eU5hbWUSJwoPYnVkZ2V0X2NhdGVnb3J5GAQgASgFUg5idWRnZXRDYXRlZ29yeRIhCgxkaXNwbG'
    'F5X25hbWUYBSABKAlSC2Rpc3BsYXlOYW1lEhIKBGljb24YBiABKAlSBGljb24SFAoFY29sb3IY'
    'ByABKAlSBWNvbG9yEhsKCWlzX2FjdGl2ZRgIIAEoCFIIaXNBY3RpdmU=');

