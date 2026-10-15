import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every service LANDING screen offers both assistants, and every pin it uses
/// resolves to a real route.
///
/// Lazerspray was the case that motivated this: chat-sprayme-service exposes
/// 32 tools including two money paths, DIRECT_ROUTES carried both `lazerspray`
/// and `sprayme`, a chat-sprayme-service process was online — and the screen
/// had neither button, so none of it was reachable. Nothing failed; the
/// feature simply did not exist on the only screen it belonged to.
///
/// LazerPoints was the same shape with a twist: its tools live in the ACCOUNTS
/// agent, so pinning the obvious-looking `lifestyle` would have routed it to
/// the travel agent, which knows nothing about points.
void main() {
  /// `serviceName` means two different things and conflating them invents
  /// dozens of phantom failures:
  ///   * ServiceVoiceButton(serviceName:) → the VOICE routing key
  ///   * MicroserviceChatIcon(serviceName:) → a DISPLAY TITLE; its routing
  ///     key is `sourceContext:`
  String? argOf(String src, String widget, String arg) {
    final start = src.indexOf('$widget(');
    if (start < 0) return null;
    var i = start + widget.length + 1;
    var depth = 1;
    while (i < src.length && depth > 0) {
      if (src[i] == '(') depth++;
      if (src[i] == ')') depth--;
      i++;
    }
    final blob = src.substring(start, i);
    final m = RegExp("$arg\\s*:\\s*'([\\w]+)'").firstMatch(blob);
    return m?.group(1);
  }

  /// The routes the gateway will actually resolve. Read from the gateway, not
  /// transcribed — a list copied here is a second place to forget.
  Set<String>? gatewayRoutes() {
    var dir = Directory.current;
    for (var i = 0; i < 6; i++) {
      final f = File('${dir.path}/../chat-agent-gateway/main.py');
      if (f.existsSync()) {
        final src = f.readAsStringSync();
        final start = src.indexOf('DIRECT_ROUTES = {');
        if (start < 0) return null;
        final end = src.indexOf('\n}\n', start);
        return RegExp(r"'([a-z0-9_]+)'\s*:\s*\{'primary'")
            .allMatches(src.substring(start, end))
            .map((m) => m.group(1)!)
            .toSet();
      }
      final parent = dir.parent;
      if (parent.path == dir.path) break;
      dir = parent;
    }
    return null;
  }

  /// screen path → (voice pin, chat sourceContext)
  const landings = <String, List<String>>{
    'lib/src/features/sprayme/presentation/screens/sprayme_home_screen.dart':
        ['sprayme', 'sprayme'],
    'lib/src/features/referral/presentation/screens/lazer_points_screen.dart':
        ['accounts', 'accounts'],
    'lib/src/features/crowdfund/presentation/views/crowdfund_home_screen.dart':
        ['crowdfund', 'financial_products'],
    'lib/src/features/uplift/presentation/views/uplift_home_screen.dart':
        ['uplift', 'uplift'],
    'lib/src/features/id_pay/presentation/view/id_pay_home_screen.dart':
        ['idpay', 'idpay'],
    'lib/src/features/crypto/presentation/view/crypto_screen.dart':
        ['crypto', 'crypto'],
    'lib/src/features/lock_funds/presentation/screens/lock_funds_list_screen.dart':
        ['lockfunds', 'lockfunds'],
  };

  group('every service landing offers both assistants', () {
    landings.forEach((path, pins) {
      test('${path.split('/').last} pins voice=${pins[0]} chat=${pins[1]}', () {
        final f = File(path);
        expect(f.existsSync(), isTrue, reason: '$path moved');
        final src = f.readAsStringSync();

        expect(argOf(src, 'ServiceVoiceButton', 'serviceName'), pins[0],
            reason: 'the mic is missing or pinned elsewhere — a service '
                'landing without it strands its whole voice agent');
        expect(argOf(src, 'MicroserviceChatIcon', 'sourceContext'), pins[1],
            reason: 'the chat icon is missing or pinned elsewhere; note the '
                'routing key is sourceContext, NOT serviceName');
      });
    });

    test('every pin resolves to a real gateway route', () {
      final routes = gatewayRoutes();
      if (routes == null) {
        markTestSkipped('chat-agent-gateway not checked out beside the app');
        return;
      }
      final unresolved = <String>[];
      landings.forEach((path, pins) {
        for (final pin in pins) {
          if (!routes.contains(pin)) unresolved.add('$path → $pin');
        }
      });
      expect(unresolved, isEmpty,
          reason: 'a pin with no DIRECT_ROUTES key does NOT error — it '
              'silently falls back to classification and the screen behaves '
              'like the general assistant:\n${unresolved.join('\n')}');
    });

    test('lazerpoints is not pinned at the travel agent', () {
      // `lifestyle` looks right and is wrong: that agent is flights, hotels
      // and tours. The points tools live in chat-accounts-service.
      final src = File(
              'lib/src/features/referral/presentation/screens/lazer_points_screen.dart')
          .readAsStringSync();
      expect(argOf(src, 'MicroserviceChatIcon', 'sourceContext'), 'accounts');
      expect(src.contains("sourceContext: 'lifestyle'"), isFalse);
    });
  });
}
