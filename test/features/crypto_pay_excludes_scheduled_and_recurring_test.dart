import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// PAY WITH CRYPTO CANNOT BE SCHEDULED OR REPEATED.
///
/// The conversion runs the moment a transfer is authorised — the coin is sold,
/// the naira lands, the transfer follows. A schedule or a repeat asks for the
/// opposite: pay later, possibly many times. Honouring both would sell a
/// customer's crypto today to pay next month, or sell again on every repeat.
/// auth-service refuses the scheduled combination outright; the app must not
/// offer it in the first place.
///
/// Source-level because the rule lives in one enormous widget's build, and the
/// mistake it guards is a deleted condition, not a reachable behaviour.
void main() {
  final send = File(
    'lib/src/features/funds/presentation/widgets/send_funds/'
    'initiate_send_funds.dart',
  ).readAsStringSync();

  // WHITESPACE-INSENSITIVE. dart format wraps long expressions, so
  // `CryptoPayConflict.recurring` legitimately appears split across two lines.
  // Matching raw source text would fail on formatting, not on behaviour.
  final flat = send.replaceAll(RegExp(r'\s+'), ' ');

  test('the selector is hidden for a scheduled OR recurring transfer', () {
    expect(
      flat.contains("if (scheduledDate == null && !_isRecurringEnabled)"),
      isTrue,
      reason: 'the Pay-with-crypto control must not render once a schedule or '
          'a repeat is set — the conversion happens now, and both pay later',
    );
  });

  test('the INSUFFICIENT-FUNDS offer obeys the same rule', () {
    // The rule now has a SECOND place to be got wrong. Being told the wallet
    // is short is the moment crypto is most useful, so both flows now offer
    // it from that sheet — and an offer there is a way into the conversion
    // that bypasses the selector entirely. If this condition is dropped, a
    // customer with a schedule set is handed the asset sheet from a refusal,
    // and the control that would have refused them is not even on screen.
    final amount = File(
      'lib/src/features/funds/presentation/widgets/send_funds/'
      'send_funds_amount_sheet.dart',
    ).readAsStringSync().replaceAll(RegExp(r'\s+'), ' ');

    expect(
      flat.contains(
          'onPayWithCrypto: (scheduledDate == null && !_isRecurringEnabled)'),
      isTrue,
      reason: 'the long flow must not offer crypto from the shortfall sheet '
          'once a schedule or repeat is set',
    );
    expect(
      amount.contains(
          'onPayWithCrypto: (_scheduledAt == null && _recurring == null)'),
      isTrue,
      reason: 'the short flow must not either — same rule, same reason',
    );
  });

  test('the shortfall offer is gated on the SAME flag as the selector', () {
    // An offer that leads to a control the customer does not have is worse
    // than no offer. Both read FeatureFlags.payWithCryptoAvailable, so the
    // two can never disagree about who has the feature.
    final sheet = File(
      'lib/src/features/funds/presentation/widgets/send_funds/'
      'insufficient_funds_sheet.dart',
    ).readAsStringSync().replaceAll(RegExp(r'\s+'), ' ');
    expect(
      sheet.contains('FeatureFlags.payWithCryptoAvailable('),
      isTrue,
      reason: 'the shortfall sheet must gate its crypto link on the same '
          'availability check the selector uses',
    );
    expect(
      sheet.contains('onPayWithCrypto != null &&'),
      isTrue,
      reason: 'and on the caller actually having a pay-source to set — a '
          'flow with none must show no link at all, not a dead one',
    );
  });

  test('turning ON a repeat while crypto is chosen is CAUGHT, not ignored', () {
    // The other order: crypto first, repeat second. Hiding the control cannot
    // help here because it was already used, so the clash has to be said.
    expect(flat.contains('if (value && _paySource.isCrypto)'), isTrue,
        reason: 'enabling Repeat with crypto selected must raise the clash');
    expect(flat.contains('CryptoPayConflict .recurring') ||
        flat.contains('CryptoPayConflict.recurring'), isTrue);
    expect(
      flat.contains('_paySource = PaySource.wallet'),
      isTrue,
      reason: 'choosing to keep the repeat must move funding back to the wallet',
    );
  });

  test('the asset still reaches the server on the ordinary path', () {
    // The guard must not have severed the feature it guards.
    expect(flat.contains('fundingAsset: _paySource.asset'), isTrue);
  });

  test('the dialog explains both clashes and defaults to the newest choice',
      () {
    final dlg = File(
      'lib/src/features/crypto_pay/presentation/'
      'crypto_pay_unavailable_dialog.dart',
    ).readAsStringSync();
    expect(dlg.contains('enum CryptoPayConflict { scheduled, recurring }'),
        isTrue);
    // A dismissed dialog must not silently undo what the customer just tapped.
    expect(dlg.contains('return ok ?? true;'), isTrue,
        reason: 'dismissing keeps the schedule/repeat the customer just set');
  });

  group('the SHORT flow carries the same rule', () {
    final sheet = File(
      'lib/src/features/funds/presentation/widgets/send_funds/'
      'send_funds_amount_sheet.dart',
    ).readAsStringSync();
    final sheetFlat = sheet.replaceAll(RegExp(r'\s+'), ' ');
    final exec = File(
      'lib/src/features/recipients/presentation/widgets/select_recipients.dart',
    ).readAsStringSync();

    test('the selector is hidden once a schedule or repeat is set', () {
      expect(
        sheetFlat.contains('if (_scheduledAt == null && _recurring == null)'),
        isTrue,
        reason: 'the amount sheet must stop offering crypto once the transfer '
            'is set to happen later',
      );
    });

    test('choosing a schedule AFTER crypto is caught, not ignored', () {
      // The order the control cannot prevent: the coin was already picked.
      expect(sheetFlat.contains('if (choseLater && _paySource.isCrypto)'),
          isTrue);
      expect(sheetFlat.contains('CryptoPayUnavailableDialog.show'), isTrue);
      // Declining the wallet keeps crypto and DROPS the schedule, so the two
      // can never both be set.
      expect(sheetFlat.contains('if (!useWallet) { // They would rather keep') ||
          sheetFlat.contains('if (!useWallet)'), isTrue);
    });

    test('the chosen asset actually reaches the send', () {
      // A selector that cannot fund anything is worse than none at all.
      expect(exec.contains('fundingAsset: fundingAsset'), isTrue,
          reason: 'select_recipients must pass the asset to TransferCubit');
      expect(sheetFlat.contains('fundingAsset: _paySource.asset'), isTrue,
          reason: 'the sheet must return the asset in its result');
    });
  });
}
