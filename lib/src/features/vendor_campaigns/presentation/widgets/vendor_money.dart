import 'package:lazervault/core/utils/currency_formatter.dart';

/// Renders a KOBO amount for display.
///
/// THE ONLY PLACE KOBO BECOMES NAIRA IN THIS FEATURE. Everything else — the
/// wire, the entities, the cubit — stays in integer kobo, so there is exactly
/// one division and it is here, at the point of rendering. An anonymous
/// `/ 100` scattered through widgets is how a screen ends up 100x wrong.
String formatKobo(int amountKobo, [String currencyCode = 'NGN']) =>
    CurrencySymbols.formatAmountWithCurrency(amountKobo / 100, currencyCode);
