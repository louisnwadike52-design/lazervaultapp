// The ACTIVE account and ACTIVE locale have to reach the agent, on every chat
// surface. Five links, three languages, and nothing checked them:
//
//   AccountManager.activeAccountId + LocaleManager.currentLocale/Country/Currency
//     -> the cubit puts them in the request body (per-service AND central)
//     -> GrpcCallOptionsHelper.withAuth() also sets X-Account-Id / X-Locale /
//        X-Currency / X-User-Country on every authed call
//     -> chat-agent-gateway BACKFILLS blank body fields from those headers
//     -> route_to_service_agent forwards them downstream
//     -> each agent reads context.currency / context.locale
//
// Every one of these has been broken at least once: the per-service cubit
// hard-coded accountId:'' and used the USER PROFILE's country instead of the
// active account's, and the gateway bound the Pydantic body only and ignored
// the headers, so any body-less client path lost account and locale entirely.
//
// The failure mode is quiet and expensive: a user whose active account is GBP
// gets answers, limits and fee quotes computed in naira.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String _app(String p) => File(p).readAsStringSync();
String _repo(String p) {
  final f = File('../$p');
  // Throws rather than using expect(): this is called at group-declaration
  // time, where expect() is not allowed and fails the whole file to load.
  if (!f.existsSync()) {
    throw StateError('cannot find $p — path moved?');
  }
  return f.readAsStringSync();
}

void main() {
  group('the app sends the ACTIVE account, not a blank or the profile default',
      () {
    test('the per-service chat cubit reads AccountManager.activeAccountId', () {
      final src = _app(
        'lib/src/features/microservice_chat/cubit/microservice_chat_cubit.dart',
      );
      expect(
        RegExp(r'serviceLocator<AccountManager>\(\)\.activeAccountId')
            .hasMatch(src),
        isTrue,
        reason: 'the per-service chat no longer reads the active account — it '
            'once hard-coded accountId: \'\'',
      );
      // and it must be what gets sent, not just read
      expect(RegExp(r'accountId:\s*activeAccountId').hasMatch(src), isTrue,
          reason: 'activeAccountId is read but not passed as accountId');
      // Comment lines are documentation, not code — and the comment that
      // explains this very defect quotes `accountId: ''`, which is what the
      // first version of this assertion tripped over.
      final code = src
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(RegExp(r"accountId:\s*''").hasMatch(code), isFalse,
          reason: 'a blank accountId is back in the per-service chat — every '
              'send path must carry the active account, the PIN-confirm turn '
              'most of all, because that is the one that moves the money');
    });

    test('the second central chat cubit reads it too', () {
      final src = _app(
        'lib/src/features/microservice_chat/cubit/general_chat_cubit.dart',
      );
      expect(RegExp(r'accountId:\s*am\.activeAccountId').hasMatch(src), isTrue,
          reason: 'general_chat_cubit no longer sends the active account');
    });

    test('the locale comes from LocaleManager, which is the region switcher',
        () {
      final src = _app(
        'lib/src/features/microservice_chat/cubit/microservice_chat_cubit.dart',
      );
      expect(src.contains('serviceLocator<LocaleManager>().currentLocale'),
          isTrue,
          reason: 'the chat no longer reads the active locale');
      // A locale that is read once at construction and never again goes stale
      // the moment the user switches region mid-conversation.
      // The NAME appearing is not enough — `localeStreamDISABLED` contains
      // it. The subscription has to actually be made.
      expect(
        RegExp(r'localeStream\s*\.\s*listen\(').hasMatch(src),
        isTrue,
        reason: 'the cubit does not SUBSCRIBE to locale changes, so switching '
            'region mid-conversation leaves the agent on the old one',
      );
    });
  });

  group('the gateway does not lose them', () {
    final gw = _repo('chat-agent-gateway/main.py');

    test('blank body fields are backfilled from the X- headers', () {
      for (final h in [
        'x-account-id',
        'x-user-country',
        'x-currency',
        'x-locale',
      ]) {
        expect(gw.contains('"$h"'), isTrue,
            reason: 'the gateway no longer reads $h, so a body-less client '
                'path loses it downstream');
      }
      // The backfill must only fill a BLANK — a header must not override an
      // explicit body value.
      expect(
        RegExp(r'message\.account_id\s*=\s*_hdr\.get\("x-account-id",\s*""\)\s*or\s*message\.account_id')
            .hasMatch(gw),
        isTrue,
        reason: 'the account-id backfill no longer prefers the body value, so '
            'a stale header could override an explicit account',
      );
    });

    test('they are read back out when routing to a service agent', () {
      final idx = gw.indexOf('async def route_to_service_agent');
      expect(idx, greaterThan(0), reason: 'route_to_service_agent is gone');
      final body = gw.substring(idx, idx + 6000);
      for (final f in ['account_id', 'user_country', 'currency', 'locale']) {
        expect(
          RegExp('$f = message_data\\.get\\("$f"').hasMatch(body),
          isTrue,
          reason: 'route_to_service_agent no longer reads $f, so it cannot '
              'forward it to the per-service agent',
        );
      }
    });
  });

  test('the agents actually consult the currency they were given', () {
    // A context field nothing reads is the same as one never sent. Sampled
    // across the money agents rather than all 16, so the assertion stays
    // meaningful without pinning every file.
    for (final svc in const [
      'chat-accounts-service',
      'chat-products-service',
      'chat-transfers-service',
      'chat-commerce-service',
    ]) {
      final dir = Directory('../$svc/core');
      expect(dir.existsSync(), isTrue, reason: '$svc/core is missing');
      var reads = 0;
      for (final f in dir.listSync().whereType<File>()) {
        if (!f.path.endsWith('.py')) continue;
        final s = f.readAsStringSync();
        reads += RegExp(r'context\.(currency|locale)').allMatches(s).length;
      }
      expect(reads, greaterThan(5),
          reason: '$svc barely reads context.currency/locale ($reads sites) — '
              'the locale is being delivered and ignored');
    }
  });
}
