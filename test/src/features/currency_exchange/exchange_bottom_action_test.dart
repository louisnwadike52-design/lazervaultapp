import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/currency_exchange/presentation/cubit/exchange_state.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/widgets/exchange_bottom_action.dart';

/// "You have more to do" and "we cannot do this" must not wear the same button.
///
/// The Send Abroad tab shipped with a card reading "Not available at the
/// moment" and, pinned under it, a live purple "Continue" — because the CTA's
/// enabled test only asked whether there was an amount and a rate, both still
/// true from the Convert tab. Additional-KYC-needed is the case that deserves
/// a Continue: the journey exists and the user can finish it.
void main() {
  group('ExchangeBottomAction.resolve', () {
    test('Convert is never gated by the payout rail', () {
      for (final available in [true, false]) {
        expect(
          ExchangeBottomAction.resolve(
            mode: ExchangeMode.convert,
            intlPayoutAvailable: available,
          ),
          ExchangeBottomAction.convertNow,
          reason: 'converting between your own currencies uses no payout rail',
        );
      }
    });

    test('Send Abroad with the rail ON continues the journey', () {
      expect(
        ExchangeBottomAction.resolve(
          mode: ExchangeMode.sendAbroad,
          intlPayoutAvailable: true,
        ),
        ExchangeBottomAction.continueSendAbroad,
      );
    });

    test('Send Abroad with the rail OFF offers the tab that works', () {
      final a = ExchangeBottomAction.resolve(
        mode: ExchangeMode.sendAbroad,
        intlPayoutAvailable: false,
      );
      expect(a, ExchangeBottomAction.switchToConvert);
      expect(a.label, isNot(contains('Continue')),
          reason: 'a Continue here promises a journey that cannot complete');
      expect(a.isJourneyCta, isFalse,
          reason: 'it navigates between tabs, so no amount or rate gates it');
    });

    test('the two journey CTAs are labelled for their own journey', () {
      expect(ExchangeBottomAction.convertNow.label, 'Convert Now');
      expect(ExchangeBottomAction.continueSendAbroad.label, 'Continue');
      expect(ExchangeBottomAction.convertNow.isJourneyCta, isTrue);
      expect(ExchangeBottomAction.continueSendAbroad.isJourneyCta, isTrue);
    });
  });
}
