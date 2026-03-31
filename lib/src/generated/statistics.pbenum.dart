//
//  Generated code. Do not modify.
//  source: statistics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ExpenseCategory extends $pb.ProtobufEnum {
  static const ExpenseCategory EXPENSE_CATEGORY_UNSPECIFIED = ExpenseCategory._(0, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_UNSPECIFIED');
  static const ExpenseCategory EXPENSE_CATEGORY_FOOD_DINING = ExpenseCategory._(1, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_FOOD_DINING');
  static const ExpenseCategory EXPENSE_CATEGORY_TRANSPORTATION = ExpenseCategory._(2, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_TRANSPORTATION');
  static const ExpenseCategory EXPENSE_CATEGORY_SHOPPING = ExpenseCategory._(3, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_SHOPPING');
  static const ExpenseCategory EXPENSE_CATEGORY_ENTERTAINMENT = ExpenseCategory._(4, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_ENTERTAINMENT');
  static const ExpenseCategory EXPENSE_CATEGORY_BILLS_UTILITIES = ExpenseCategory._(5, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_BILLS_UTILITIES');
  static const ExpenseCategory EXPENSE_CATEGORY_HEALTHCARE = ExpenseCategory._(6, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_HEALTHCARE');
  static const ExpenseCategory EXPENSE_CATEGORY_EDUCATION = ExpenseCategory._(7, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_EDUCATION');
  static const ExpenseCategory EXPENSE_CATEGORY_TRAVEL = ExpenseCategory._(8, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_TRAVEL');
  static const ExpenseCategory EXPENSE_CATEGORY_GROCERIES = ExpenseCategory._(9, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_GROCERIES');
  static const ExpenseCategory EXPENSE_CATEGORY_RENT_MORTGAGE = ExpenseCategory._(10, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_RENT_MORTGAGE');
  static const ExpenseCategory EXPENSE_CATEGORY_INSURANCE = ExpenseCategory._(11, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_INSURANCE');
  static const ExpenseCategory EXPENSE_CATEGORY_INVESTMENTS = ExpenseCategory._(12, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_INVESTMENTS');
  static const ExpenseCategory EXPENSE_CATEGORY_GIFTS_DONATIONS = ExpenseCategory._(13, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_GIFTS_DONATIONS');
  static const ExpenseCategory EXPENSE_CATEGORY_PERSONAL_CARE = ExpenseCategory._(14, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_PERSONAL_CARE');
  static const ExpenseCategory EXPENSE_CATEGORY_SUBSCRIPTIONS = ExpenseCategory._(15, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_SUBSCRIPTIONS');
  static const ExpenseCategory EXPENSE_CATEGORY_OTHER = ExpenseCategory._(16, _omitEnumNames ? '' : 'EXPENSE_CATEGORY_OTHER');

  static const $core.List<ExpenseCategory> values = <ExpenseCategory> [
    EXPENSE_CATEGORY_UNSPECIFIED,
    EXPENSE_CATEGORY_FOOD_DINING,
    EXPENSE_CATEGORY_TRANSPORTATION,
    EXPENSE_CATEGORY_SHOPPING,
    EXPENSE_CATEGORY_ENTERTAINMENT,
    EXPENSE_CATEGORY_BILLS_UTILITIES,
    EXPENSE_CATEGORY_HEALTHCARE,
    EXPENSE_CATEGORY_EDUCATION,
    EXPENSE_CATEGORY_TRAVEL,
    EXPENSE_CATEGORY_GROCERIES,
    EXPENSE_CATEGORY_RENT_MORTGAGE,
    EXPENSE_CATEGORY_INSURANCE,
    EXPENSE_CATEGORY_INVESTMENTS,
    EXPENSE_CATEGORY_GIFTS_DONATIONS,
    EXPENSE_CATEGORY_PERSONAL_CARE,
    EXPENSE_CATEGORY_SUBSCRIPTIONS,
    EXPENSE_CATEGORY_OTHER,
  ];

  static final $core.Map<$core.int, ExpenseCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExpenseCategory? valueOf($core.int value) => _byValue[value];

  const ExpenseCategory._($core.int v, $core.String n) : super(v, n);
}

class BudgetPeriod extends $pb.ProtobufEnum {
  static const BudgetPeriod BUDGET_PERIOD_UNSPECIFIED = BudgetPeriod._(0, _omitEnumNames ? '' : 'BUDGET_PERIOD_UNSPECIFIED');
  static const BudgetPeriod BUDGET_PERIOD_DAILY = BudgetPeriod._(1, _omitEnumNames ? '' : 'BUDGET_PERIOD_DAILY');
  static const BudgetPeriod BUDGET_PERIOD_WEEKLY = BudgetPeriod._(2, _omitEnumNames ? '' : 'BUDGET_PERIOD_WEEKLY');
  static const BudgetPeriod BUDGET_PERIOD_MONTHLY = BudgetPeriod._(3, _omitEnumNames ? '' : 'BUDGET_PERIOD_MONTHLY');
  static const BudgetPeriod BUDGET_PERIOD_QUARTERLY = BudgetPeriod._(4, _omitEnumNames ? '' : 'BUDGET_PERIOD_QUARTERLY');
  static const BudgetPeriod BUDGET_PERIOD_YEARLY = BudgetPeriod._(5, _omitEnumNames ? '' : 'BUDGET_PERIOD_YEARLY');
  static const BudgetPeriod BUDGET_PERIOD_CUSTOM = BudgetPeriod._(6, _omitEnumNames ? '' : 'BUDGET_PERIOD_CUSTOM');

  static const $core.List<BudgetPeriod> values = <BudgetPeriod> [
    BUDGET_PERIOD_UNSPECIFIED,
    BUDGET_PERIOD_DAILY,
    BUDGET_PERIOD_WEEKLY,
    BUDGET_PERIOD_MONTHLY,
    BUDGET_PERIOD_QUARTERLY,
    BUDGET_PERIOD_YEARLY,
    BUDGET_PERIOD_CUSTOM,
  ];

  static final $core.Map<$core.int, BudgetPeriod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BudgetPeriod? valueOf($core.int value) => _byValue[value];

  const BudgetPeriod._($core.int v, $core.String n) : super(v, n);
}

class BudgetStatus extends $pb.ProtobufEnum {
  static const BudgetStatus BUDGET_STATUS_UNSPECIFIED = BudgetStatus._(0, _omitEnumNames ? '' : 'BUDGET_STATUS_UNSPECIFIED');
  static const BudgetStatus BUDGET_STATUS_ACTIVE = BudgetStatus._(1, _omitEnumNames ? '' : 'BUDGET_STATUS_ACTIVE');
  static const BudgetStatus BUDGET_STATUS_EXCEEDED = BudgetStatus._(2, _omitEnumNames ? '' : 'BUDGET_STATUS_EXCEEDED');
  static const BudgetStatus BUDGET_STATUS_NEAR_LIMIT = BudgetStatus._(3, _omitEnumNames ? '' : 'BUDGET_STATUS_NEAR_LIMIT');
  static const BudgetStatus BUDGET_STATUS_INACTIVE = BudgetStatus._(4, _omitEnumNames ? '' : 'BUDGET_STATUS_INACTIVE');
  static const BudgetStatus BUDGET_STATUS_COMPLETED = BudgetStatus._(5, _omitEnumNames ? '' : 'BUDGET_STATUS_COMPLETED');

  static const $core.List<BudgetStatus> values = <BudgetStatus> [
    BUDGET_STATUS_UNSPECIFIED,
    BUDGET_STATUS_ACTIVE,
    BUDGET_STATUS_EXCEEDED,
    BUDGET_STATUS_NEAR_LIMIT,
    BUDGET_STATUS_INACTIVE,
    BUDGET_STATUS_COMPLETED,
  ];

  static final $core.Map<$core.int, BudgetStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BudgetStatus? valueOf($core.int value) => _byValue[value];

  const BudgetStatus._($core.int v, $core.String n) : super(v, n);
}

/// BudgetEnforcementMode determines how budget limits are enforced
class BudgetEnforcementMode extends $pb.ProtobufEnum {
  static const BudgetEnforcementMode BUDGET_ENFORCEMENT_MODE_UNSPECIFIED = BudgetEnforcementMode._(0, _omitEnumNames ? '' : 'BUDGET_ENFORCEMENT_MODE_UNSPECIFIED');
  static const BudgetEnforcementMode BUDGET_ENFORCEMENT_MODE_FLEXIBLE = BudgetEnforcementMode._(1, _omitEnumNames ? '' : 'BUDGET_ENFORCEMENT_MODE_FLEXIBLE');
  static const BudgetEnforcementMode BUDGET_ENFORCEMENT_MODE_STRICT = BudgetEnforcementMode._(2, _omitEnumNames ? '' : 'BUDGET_ENFORCEMENT_MODE_STRICT');

  static const $core.List<BudgetEnforcementMode> values = <BudgetEnforcementMode> [
    BUDGET_ENFORCEMENT_MODE_UNSPECIFIED,
    BUDGET_ENFORCEMENT_MODE_FLEXIBLE,
    BUDGET_ENFORCEMENT_MODE_STRICT,
  ];

  static final $core.Map<$core.int, BudgetEnforcementMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BudgetEnforcementMode? valueOf($core.int value) => _byValue[value];

  const BudgetEnforcementMode._($core.int v, $core.String n) : super(v, n);
}

class AlertType extends $pb.ProtobufEnum {
  static const AlertType ALERT_TYPE_UNSPECIFIED = AlertType._(0, _omitEnumNames ? '' : 'ALERT_TYPE_UNSPECIFIED');
  static const AlertType ALERT_TYPE_THRESHOLD_REACHED = AlertType._(1, _omitEnumNames ? '' : 'ALERT_TYPE_THRESHOLD_REACHED');
  static const AlertType ALERT_TYPE_BUDGET_EXCEEDED = AlertType._(2, _omitEnumNames ? '' : 'ALERT_TYPE_BUDGET_EXCEEDED');
  static const AlertType ALERT_TYPE_APPROACHING_LIMIT = AlertType._(3, _omitEnumNames ? '' : 'ALERT_TYPE_APPROACHING_LIMIT');
  static const AlertType ALERT_TYPE_RECURRING_EXPENSE_DUE = AlertType._(4, _omitEnumNames ? '' : 'ALERT_TYPE_RECURRING_EXPENSE_DUE');

  static const $core.List<AlertType> values = <AlertType> [
    ALERT_TYPE_UNSPECIFIED,
    ALERT_TYPE_THRESHOLD_REACHED,
    ALERT_TYPE_BUDGET_EXCEEDED,
    ALERT_TYPE_APPROACHING_LIMIT,
    ALERT_TYPE_RECURRING_EXPENSE_DUE,
  ];

  static final $core.Map<$core.int, AlertType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AlertType? valueOf($core.int value) => _byValue[value];

  const AlertType._($core.int v, $core.String n) : super(v, n);
}

/// Income Source Messages
class IncomeCategory extends $pb.ProtobufEnum {
  static const IncomeCategory INCOME_CATEGORY_UNSPECIFIED = IncomeCategory._(0, _omitEnumNames ? '' : 'INCOME_CATEGORY_UNSPECIFIED');
  static const IncomeCategory INCOME_CATEGORY_SALARY = IncomeCategory._(1, _omitEnumNames ? '' : 'INCOME_CATEGORY_SALARY');
  static const IncomeCategory INCOME_CATEGORY_FREELANCE = IncomeCategory._(2, _omitEnumNames ? '' : 'INCOME_CATEGORY_FREELANCE');
  static const IncomeCategory INCOME_CATEGORY_INVESTMENTS = IncomeCategory._(3, _omitEnumNames ? '' : 'INCOME_CATEGORY_INVESTMENTS');
  static const IncomeCategory INCOME_CATEGORY_RENTAL = IncomeCategory._(4, _omitEnumNames ? '' : 'INCOME_CATEGORY_RENTAL');
  static const IncomeCategory INCOME_CATEGORY_BUSINESS = IncomeCategory._(5, _omitEnumNames ? '' : 'INCOME_CATEGORY_BUSINESS');
  static const IncomeCategory INCOME_CATEGORY_DIVIDEND = IncomeCategory._(6, _omitEnumNames ? '' : 'INCOME_CATEGORY_DIVIDEND');
  static const IncomeCategory INCOME_CATEGORY_INTEREST = IncomeCategory._(7, _omitEnumNames ? '' : 'INCOME_CATEGORY_INTEREST');
  static const IncomeCategory INCOME_CATEGORY_GIFT = IncomeCategory._(8, _omitEnumNames ? '' : 'INCOME_CATEGORY_GIFT');
  static const IncomeCategory INCOME_CATEGORY_OTHER = IncomeCategory._(9, _omitEnumNames ? '' : 'INCOME_CATEGORY_OTHER');

  static const $core.List<IncomeCategory> values = <IncomeCategory> [
    INCOME_CATEGORY_UNSPECIFIED,
    INCOME_CATEGORY_SALARY,
    INCOME_CATEGORY_FREELANCE,
    INCOME_CATEGORY_INVESTMENTS,
    INCOME_CATEGORY_RENTAL,
    INCOME_CATEGORY_BUSINESS,
    INCOME_CATEGORY_DIVIDEND,
    INCOME_CATEGORY_INTEREST,
    INCOME_CATEGORY_GIFT,
    INCOME_CATEGORY_OTHER,
  ];

  static final $core.Map<$core.int, IncomeCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static IncomeCategory? valueOf($core.int value) => _byValue[value];

  const IncomeCategory._($core.int v, $core.String n) : super(v, n);
}

/// Investment Portfolio Messages
class InvestmentType extends $pb.ProtobufEnum {
  static const InvestmentType INVESTMENT_TYPE_UNSPECIFIED = InvestmentType._(0, _omitEnumNames ? '' : 'INVESTMENT_TYPE_UNSPECIFIED');
  static const InvestmentType INVESTMENT_TYPE_STOCKS = InvestmentType._(1, _omitEnumNames ? '' : 'INVESTMENT_TYPE_STOCKS');
  static const InvestmentType INVESTMENT_TYPE_CRYPTO = InvestmentType._(2, _omitEnumNames ? '' : 'INVESTMENT_TYPE_CRYPTO');
  static const InvestmentType INVESTMENT_TYPE_MUTUAL_FUNDS = InvestmentType._(3, _omitEnumNames ? '' : 'INVESTMENT_TYPE_MUTUAL_FUNDS');
  static const InvestmentType INVESTMENT_TYPE_BONDS = InvestmentType._(4, _omitEnumNames ? '' : 'INVESTMENT_TYPE_BONDS');
  static const InvestmentType INVESTMENT_TYPE_ETF = InvestmentType._(5, _omitEnumNames ? '' : 'INVESTMENT_TYPE_ETF');
  static const InvestmentType INVESTMENT_TYPE_REAL_ESTATE = InvestmentType._(6, _omitEnumNames ? '' : 'INVESTMENT_TYPE_REAL_ESTATE');
  static const InvestmentType INVESTMENT_TYPE_COMMODITIES = InvestmentType._(7, _omitEnumNames ? '' : 'INVESTMENT_TYPE_COMMODITIES');
  static const InvestmentType INVESTMENT_TYPE_OTHER = InvestmentType._(8, _omitEnumNames ? '' : 'INVESTMENT_TYPE_OTHER');

  static const $core.List<InvestmentType> values = <InvestmentType> [
    INVESTMENT_TYPE_UNSPECIFIED,
    INVESTMENT_TYPE_STOCKS,
    INVESTMENT_TYPE_CRYPTO,
    INVESTMENT_TYPE_MUTUAL_FUNDS,
    INVESTMENT_TYPE_BONDS,
    INVESTMENT_TYPE_ETF,
    INVESTMENT_TYPE_REAL_ESTATE,
    INVESTMENT_TYPE_COMMODITIES,
    INVESTMENT_TYPE_OTHER,
  ];

  static final $core.Map<$core.int, InvestmentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InvestmentType? valueOf($core.int value) => _byValue[value];

  const InvestmentType._($core.int v, $core.String n) : super(v, n);
}

/// Financial Goals Messages
class GoalStatus extends $pb.ProtobufEnum {
  static const GoalStatus GOAL_STATUS_UNSPECIFIED = GoalStatus._(0, _omitEnumNames ? '' : 'GOAL_STATUS_UNSPECIFIED');
  static const GoalStatus GOAL_STATUS_IN_PROGRESS = GoalStatus._(1, _omitEnumNames ? '' : 'GOAL_STATUS_IN_PROGRESS');
  static const GoalStatus GOAL_STATUS_COMPLETED = GoalStatus._(2, _omitEnumNames ? '' : 'GOAL_STATUS_COMPLETED');
  static const GoalStatus GOAL_STATUS_CANCELLED = GoalStatus._(3, _omitEnumNames ? '' : 'GOAL_STATUS_CANCELLED');
  static const GoalStatus GOAL_STATUS_PAUSED = GoalStatus._(4, _omitEnumNames ? '' : 'GOAL_STATUS_PAUSED');

  static const $core.List<GoalStatus> values = <GoalStatus> [
    GOAL_STATUS_UNSPECIFIED,
    GOAL_STATUS_IN_PROGRESS,
    GOAL_STATUS_COMPLETED,
    GOAL_STATUS_CANCELLED,
    GOAL_STATUS_PAUSED,
  ];

  static final $core.Map<$core.int, GoalStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GoalStatus? valueOf($core.int value) => _byValue[value];

  const GoalStatus._($core.int v, $core.String n) : super(v, n);
}

class GoalType extends $pb.ProtobufEnum {
  static const GoalType GOAL_TYPE_UNSPECIFIED = GoalType._(0, _omitEnumNames ? '' : 'GOAL_TYPE_UNSPECIFIED');
  static const GoalType GOAL_TYPE_EMERGENCY_FUND = GoalType._(1, _omitEnumNames ? '' : 'GOAL_TYPE_EMERGENCY_FUND');
  static const GoalType GOAL_TYPE_VACATION = GoalType._(2, _omitEnumNames ? '' : 'GOAL_TYPE_VACATION');
  static const GoalType GOAL_TYPE_CAR = GoalType._(3, _omitEnumNames ? '' : 'GOAL_TYPE_CAR');
  static const GoalType GOAL_TYPE_HOUSE = GoalType._(4, _omitEnumNames ? '' : 'GOAL_TYPE_HOUSE');
  static const GoalType GOAL_TYPE_EDUCATION = GoalType._(5, _omitEnumNames ? '' : 'GOAL_TYPE_EDUCATION');
  static const GoalType GOAL_TYPE_RETIREMENT = GoalType._(6, _omitEnumNames ? '' : 'GOAL_TYPE_RETIREMENT');
  static const GoalType GOAL_TYPE_WEDDING = GoalType._(7, _omitEnumNames ? '' : 'GOAL_TYPE_WEDDING');
  static const GoalType GOAL_TYPE_DEBT_PAYOFF = GoalType._(8, _omitEnumNames ? '' : 'GOAL_TYPE_DEBT_PAYOFF');
  static const GoalType GOAL_TYPE_CUSTOM = GoalType._(9, _omitEnumNames ? '' : 'GOAL_TYPE_CUSTOM');

  static const $core.List<GoalType> values = <GoalType> [
    GOAL_TYPE_UNSPECIFIED,
    GOAL_TYPE_EMERGENCY_FUND,
    GOAL_TYPE_VACATION,
    GOAL_TYPE_CAR,
    GOAL_TYPE_HOUSE,
    GOAL_TYPE_EDUCATION,
    GOAL_TYPE_RETIREMENT,
    GOAL_TYPE_WEDDING,
    GOAL_TYPE_DEBT_PAYOFF,
    GOAL_TYPE_CUSTOM,
  ];

  static final $core.Map<$core.int, GoalType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GoalType? valueOf($core.int value) => _byValue[value];

  const GoalType._($core.int v, $core.String n) : super(v, n);
}

/// Recurring Bills / Upcoming Bills Messages
class BillStatus extends $pb.ProtobufEnum {
  static const BillStatus BILL_STATUS_UNSPECIFIED = BillStatus._(0, _omitEnumNames ? '' : 'BILL_STATUS_UNSPECIFIED');
  static const BillStatus BILL_STATUS_UPCOMING = BillStatus._(1, _omitEnumNames ? '' : 'BILL_STATUS_UPCOMING');
  static const BillStatus BILL_STATUS_PAID = BillStatus._(2, _omitEnumNames ? '' : 'BILL_STATUS_PAID');
  static const BillStatus BILL_STATUS_OVERDUE = BillStatus._(3, _omitEnumNames ? '' : 'BILL_STATUS_OVERDUE');
  static const BillStatus BILL_STATUS_CANCELLED = BillStatus._(4, _omitEnumNames ? '' : 'BILL_STATUS_CANCELLED');

  static const $core.List<BillStatus> values = <BillStatus> [
    BILL_STATUS_UNSPECIFIED,
    BILL_STATUS_UPCOMING,
    BILL_STATUS_PAID,
    BILL_STATUS_OVERDUE,
    BILL_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, BillStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BillStatus? valueOf($core.int value) => _byValue[value];

  const BillStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
