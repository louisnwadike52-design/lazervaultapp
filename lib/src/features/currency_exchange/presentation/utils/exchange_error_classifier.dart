/// Maps raw error messages from the exchange-service handler into a
/// kind+headline+detail tuple the UI can render. The backend's
/// `sanitizeError` already passes structured strings through (e.g.
/// "amount too low for this corridor: provider fee is 5.00 USD, send at
/// least 6.00 USD"), so the classifier matches on stable substrings.
///
/// Keep the matching predicates aligned with the sanitizer's whitelist
/// in `exchange-service/internal/handler/exchange_handler.go` — if a new
/// raw error string is added there, add a matching case here so it
/// doesn't fall through to the generic "Something went wrong" branch.
library;

class ExchangeErrorView {
  final ExchangeErrorKind kind;
  final String headline;
  final String detail;
  final String? cta;

  const ExchangeErrorView({
    required this.kind,
    required this.headline,
    required this.detail,
    this.cta,
  });
}

enum ExchangeErrorKind {
  amountTooLow,
  perTransactionLimit,
  dailyLimit,
  insufficientBalance,
  rateUnavailable,
  rateLimit,
  duplicateRequest,
  pin,
  unsupportedCorridor,
  receiverField,
  generic,
}

ExchangeErrorView classifyExchangeError(String? rawMessage) {
  final msg = (rawMessage ?? '').trim();
  final lc = msg.toLowerCase();

  if (lc.contains('amount too low for this corridor')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.amountTooLow,
      headline: 'Amount too low for this corridor',
      // The backend message already includes the fee and suggested
      // minimum (e.g. "send at least 6.00 USD") — show it verbatim
      // so the user knows exactly how much to bump to.
      detail: _stripAfterColon(msg),
      cta: 'Increase amount',
    );
  }

  if (lc.contains('per-transaction limit')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.perTransactionLimit,
      headline: 'Single-transaction limit reached',
      detail: _stripAfterColon(msg),
      cta: 'Upgrade your KYC tier',
    );
  }

  if (lc.contains('minimum amount for this exchange')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.amountTooLow,
      headline: 'Below minimum',
      detail: _stripAfterColon(msg),
      cta: 'Increase amount',
    );
  }

  if (lc.contains('daily fx') || lc.contains('daily limit')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.dailyLimit,
      headline: 'Daily limit reached',
      detail: _stripAfterColon(msg),
      cta: 'Upgrade your KYC tier',
    );
  }

  if (lc.contains('insufficient balance') ||
      lc.contains('insufficient available balance')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.insufficientBalance,
      headline: 'Not enough balance',
      detail: _stripAfterColon(msg),
      cta: 'Top up your wallet',
    );
  }

  if (lc.contains('rate unavailable') ||
      lc.contains('exchange rate unavailable')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.rateUnavailable,
      headline: 'Exchange rate unavailable',
      detail: 'We could not get a quote for this corridor right now. '
          'Please try again in a moment.',
    );
  }

  if (lc.contains('moving too fast') ||
      lc.contains('rate limit exceeded')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.rateLimit,
      headline: 'Slow down',
      detail: 'You are sending transfers too quickly. '
          'Please wait a moment before retrying.',
    );
  }

  if (lc.contains('duplicate request')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.duplicateRequest,
      headline: 'Duplicate transfer',
      detail: 'A transfer with this idempotency key is already being processed.',
    );
  }

  if (lc.contains('invalid pin') ||
      lc.contains('verification token') ||
      lc.contains('verification') && lc.contains('failed')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.pin,
      headline: 'PIN verification failed',
      detail: 'The PIN you entered was rejected. Please try again.',
      cta: 'Re-enter PIN',
    );
  }

  if (lc.contains('currency') && lc.contains('not supported')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.unsupportedCorridor,
      headline: 'Corridor not supported',
      detail: 'This currency pair is not available right now. '
          'Try a different destination.',
    );
  }

  // Receiver-field validation surfaces from the handler as e.g.
  // "recipient email or phone is required for ZAR transfers" or
  // "UK sort code must be 6 digits". Render these verbatim — they're
  // already operator-friendly and tell the user which field to fix.
  if (lc.contains('is required for') ||
      lc.contains('must be 8 or 11') ||
      lc.contains('must be 6 digits') ||
      lc.contains('iban') ||
      lc.contains('beneficiary_type')) {
    return ExchangeErrorView(
      kind: ExchangeErrorKind.receiverField,
      headline: 'Check recipient details',
      detail: msg,
      cta: 'Edit recipient',
    );
  }

  return ExchangeErrorView(
    kind: ExchangeErrorKind.generic,
    headline: 'Something went wrong',
    detail: msg.isEmpty
        ? 'We could not complete the exchange. Please try again.'
        : msg,
  );
}

// Trims server-style prefixes ("...: actual message") so the detail
// shown to the user reads like a sentence rather than a leaked log line.
String _stripAfterColon(String s) {
  final i = s.indexOf(':');
  if (i < 0 || i >= s.length - 1) return s;
  final tail = s.substring(i + 1).trim();
  if (tail.isEmpty) return s;
  // Capitalize first letter for readability.
  return tail[0].toUpperCase() + tail.substring(1);
}
