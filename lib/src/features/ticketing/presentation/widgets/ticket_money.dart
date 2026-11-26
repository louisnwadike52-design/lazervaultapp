import 'package:lazervault/core/utils/currency_formatter.dart';

/// THE ONE PLACE A TICKET AMOUNT BECOMES TEXT.
///
/// Everything else in this feature — the wire, the repository, the cubit, the
/// state — stays in integer MINOR UNITS, so there is exactly one division by
/// 100 in the whole path and it is here. A `/ 100` scattered through widgets is
/// how a screen ends up a hundred times wrong, which on a ticket price is the
/// difference between ₦50 and ₦5,000. Copied deliberately from
/// vendor_money.dart, which exists for the same reason.
String ticketMoney(int amountMinor, String currencyCode) =>
    CurrencySymbols.formatAmountWithCurrency(amountMinor / 100, currencyCode);
