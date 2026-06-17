import 'package:lazervault/src/generated/multi_country.pb.dart' as pb;
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

/// A group of accounts belonging to a single locale/country
class LocaleAccountGroupEntity {
  final String locale;
  final String countryCode;
  final String countryName;
  final String currencyCode;
  final String currencySymbol;
  final String flagEmoji;
  final List<LocaleAccountEntity> accounts;
  final double totalBalance;
  final bool hasAccounts;
  final bool isSignupLocale;

  const LocaleAccountGroupEntity({
    required this.locale,
    required this.countryCode,
    required this.countryName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.flagEmoji,
    required this.accounts,
    required this.totalBalance,
    required this.hasAccounts,
    required this.isSignupLocale,
  });

  factory LocaleAccountGroupEntity.fromProto(pb.LocaleAccountGroup proto) {
    return LocaleAccountGroupEntity(
      locale: proto.locale,
      countryCode: proto.countryCode,
      countryName: proto.countryName,
      currencyCode: proto.currencyCode,
      currencySymbol: proto.currencySymbol,
      flagEmoji: proto.flagEmoji,
      accounts: proto.accounts.map(LocaleAccountEntity.fromProto).toList(),
      totalBalance: proto.totalBalance,
      hasAccounts: proto.hasAccounts,
      isSignupLocale: proto.isSignupLocale,
    );
  }
}

/// An individual account within a locale group
class LocaleAccountEntity {
  final String id;
  final String accountNumber;
  final String accountName;
  final String accountType;
  final String currency;
  final String locale;
  final double balance;
  final double availableBalance;
  final String status;
  final bool isPrimary;

  const LocaleAccountEntity({
    required this.id,
    required this.accountNumber,
    required this.accountName,
    required this.accountType,
    required this.currency,
    required this.locale,
    required this.balance,
    required this.availableBalance,
    required this.status,
    required this.isPrimary,
  });

  factory LocaleAccountEntity.fromProto(accounts_pb.Account proto) {
    return LocaleAccountEntity(
      id: proto.id,
      accountNumber: proto.accountNumber,
      accountName: proto.accountName,
      accountType: proto.accountType,
      currency: proto.currency,
      locale: proto.locale,
      balance: proto.balance.toDouble(),
      availableBalance: proto.availableBalance.toDouble(),
      status: proto.status,
      isPrimary: proto.isPrimary,
    );
  }
}

/// Supported locale information
class SupportedLocaleEntity {
  final String locale;
  final String countryCode;
  final String countryName;
  final String currencyCode;
  final String currencySymbol;
  final String flagEmoji;
  final bool isActive;
  final bool isBeta;
  final List<String> availableAccountTypes;
  final bool userHasAccount;

  const SupportedLocaleEntity({
    required this.locale,
    required this.countryCode,
    required this.countryName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.flagEmoji,
    required this.isActive,
    required this.isBeta,
    required this.availableAccountTypes,
    required this.userHasAccount,
  });

  factory SupportedLocaleEntity.fromProto(pb.SupportedLocale proto) {
    return SupportedLocaleEntity(
      locale: proto.locale,
      countryCode: proto.countryCode,
      countryName: proto.countryName,
      currencyCode: proto.currencyCode,
      currencySymbol: proto.currencySymbol,
      flagEmoji: proto.flagEmoji,
      isActive: proto.isActive,
      isBeta: proto.isBeta,
      availableAccountTypes: proto.availableAccountTypes.toList(),
      userHasAccount: proto.userHasAccount,
    );
  }
}
