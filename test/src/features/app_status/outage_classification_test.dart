import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/app_status/widgets/outage_copy.dart';

/// Reported from a device, mid-signup: a card reading
/// "Under maintenance — Our servers are being worked on right now. Your money
/// and data are safe."
///
/// That instance was TRUE — the screenshot is timestamped 15:43 and prod's
/// core-gateway restarted at 15:45 during a deploy, so the backend really was
/// down. But it exposed two faults in how the app reaches that conclusion and
/// how it words it.
void main() {
  group('the copy tells the truth about who is at fault', () {
    test('a connection problem never claims our servers are down', () {
      final c = OutageCopy.of(OutageKind.connection, isSignUp: true);
      expect(c.message.toLowerCase(), isNot(contains('our servers')));
      expect(c.title, 'No internet connection');
      expect(c.icon, Icons.wifi_off_rounded);
    });

    test('a server problem never tells the user to check their connection', () {
      final c = OutageCopy.of(OutageKind.server, isSignUp: false);
      expect(c.message.toLowerCase(), isNot(contains('check your')));
      expect(c.message.toLowerCase(), contains('our servers'));
    });

    test('signup is not promised that its money is safe', () {
      // She is three steps into creating an account. She has no money with us
      // and no data with us, so the reassurance answers a question she never
      // asked — and implies she has something at stake.
      final c = OutageCopy.of(OutageKind.server, isSignUp: true);
      expect(c.message.toLowerCase(), isNot(contains('your money')));
      // What she actually wants to know: does she have to start again.
      expect(c.message.toLowerCase(), contains('nothing you have entered'));
    });

    test('an existing user IS reassured, because for them it is true', () {
      final c = OutageCopy.of(OutageKind.server, isSignUp: false);
      expect(c.message.toLowerCase(), contains('your money and data are safe'));
    });

    test('the connection message names the causes that look like signal', () {
      // "Check your connection" over four bars of 4G reads as the app being
      // wrong. A spent data bundle is the common real cause and looks identical
      // to a healthy connection from the radio's point of view.
      final c = OutageCopy.of(OutageKind.connection, isSignUp: true);
      expect(c.message.toLowerCase(), contains('data bundle'));
    });
  });

  group('what the user is allowed to do about it', () {
    test('a server outage holds, because nothing behind it works', () {
      expect(OutageCopy.of(OutageKind.server, isSignUp: true).dismissible,
          isFalse);
    });

    test('a connection problem can be dismissed', () {
      // It is theirs to fix and fixing it may mean leaving the app. Trapping
      // them behind a barrier they cannot act on from here would be the app
      // being certain at their expense.
      expect(OutageCopy.of(OutageKind.connection, isSignUp: true).dismissible,
          isTrue);
    });
  });

  group('the probe distinguishes the two', () {
    late String source;

    setUpAll(() {
      source = File('lib/core/services/server_status_service.dart')
          .readAsStringSync();
    });

    test('a 5xx is recorded as a server error, not as unreachable', () {
      expect(source, contains('BackendReachability.serverError'));
      expect(source, contains('resp.statusCode < 500'));
    });

    test('there is a real internet check, not just a radio check', () {
      // connectivity_plus reports the INTERFACE. A phone with four bars and an
      // exhausted data bundle, a captive portal, or a broken APN reports itself
      // as online — and every one of those used to be reported to the user as
      // our servers being down.
      expect(source, contains('hasWorkingInternet'));
      expect(source, contains('generate_204'));
    });

    test('exactly 204 counts, so a captive portal is not mistaken for internet',
        () {
      // A portal answers the probe with its own login page — a 200 or a
      // redirect. Only an empty 204 means the connection is really open.
      expect(source, contains('resp.statusCode == 204'));
    });

    test('two independent operators, so one being blocked is not conclusive',
        () {
      expect(source, contains('cp.cloudflare.com'));
      expect(source, contains('connectivitycheck.gstatic.com'));
    });
  });

  group('the gate uses that evidence', () {
    late String source;

    setUpAll(() {
      source = File('lib/src/features/app_status/widgets/app_startup_gate.dart')
          .readAsStringSync();
    });

    test('a server error short-circuits, without further probing', () {
      // Something answered for us with a 5xx. No amount of connectivity
      // checking makes that the user's fault.
      expect(source, contains('return OutageKind.server;'));
    });

    test('an unreachable edge is only called an outage with internet proof',
        () {
      expect(source, contains('hasWorkingInternet()'));
      expect(source,
          contains('internet ? OutageKind.server : OutageKind.connection'));
    });

    test('the radio check runs first, because it is free and definitive', () {
      // No interface at all means we are certainly not the problem, and it
      // costs nothing to establish.
      expect(
          source,
          contains(
              'if (!await _deviceOnline()) return OutageKind.connection;'));
    });

    test('signup routes are recognised so the copy can differ', () {
      expect(source, contains('_signUpRoutes'));
      expect(source, contains('AppRoutes.phoneEmailVerification'),
          reason:
              'the reported screen was the email step of the signup wizard');
    });
  });
}
