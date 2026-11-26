import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A SHARE LINK HAS FOUR SURFACES, AND THREE OF THEM FAIL SILENTLY.
///
/// For a shared URL to actually open the app, every one of these has to claim
/// it:
///
///  1. the OS — Android's `pathPrefix` allow-list in AndroidManifest.xml, and
///     the `paths` list in the website's apple-app-site-association (the iOS
///     entitlement claims the whole host, so that FILE is what restricts it);
///  2. DeepLinkService — a parse branch that recognises the shape and pulls the
///     id out;
///  3. main.dart — a case that routes it, through PendingDeepLink so it
///     survives the login gate;
///  4. the app's own route, so the id has somewhere to land.
///
/// Miss (1) and the OS opens a browser. Miss (2) and the app receives the link
/// and resolves it to `unknown`. Miss (3) and it parses and goes nowhere. NONE
/// of those fails a test near the feature, and the manifest's own comments
/// record four separate rounds of exactly this being found by hand — crowdfund,
/// lazerspray and groups had all been minting links that NEITHER platform
/// claimed, so every campaign, room and group ever shared sent people to a web
/// page.
///
/// So the lists are compared mechanically, and ticketing — whose shared link IS
/// its distribution — is pinned explicitly.
void main() {
  late String manifest;
  late String deepLinkService;
  late String main;
  late String appRoutes;
  late List<String> iosPaths;

  setUpAll(() {
    manifest =
        File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    deepLinkService =
        File('lib/src/core/services/deep_link_service.dart').readAsStringSync();
    main = File('lib/main.dart').readAsStringSync();
    appRoutes = File('lib/core/types/app_routes.dart').readAsStringSync();

    // The AASA lives in the WEBSITE repo, beside this one. Resolved by walking
    // up rather than with a counted "../", so moving either tree one level
    // does not turn this into a false pass.
    File? aasa;
    var dir = Directory.current;
    for (var i = 0; i < 6; i++) {
      final f = File(
          '${dir.path}/lazervault-website/public/.well-known/apple-app-site-association');
      if (f.existsSync()) {
        aasa = f;
        break;
      }
      final parent = dir.parent;
      if (parent.path == dir.path) break;
      dir = parent;
    }
    if (aasa == null) {
      // Not a pass: the iOS half of every share link is unverifiable without
      // it, and silently skipping is how it stays that way.
      fail('could not find the website apple-app-site-association by walking '
          'up from ${Directory.current.path}. It is the file that decides '
          'which paths open the app on iOS — repoint this test rather than '
          'deleting it.');
    }
    final decoded = jsonDecode(aasa.readAsStringSync()) as Map<String, dynamic>;
    iosPaths = ((decoded['applinks']['details'] as List).first['paths'] as List)
        .cast<String>();
  });

  /// Every share path the app mints, with the route it must reach.
  ///
  /// THE URL PATH AND THE ROUTE PATH ARE NOT THE SAME THING and must not be
  /// assumed to be. Every link here maps between them — /groups/<id> reaches
  /// AppRoutes.groupAccount — and an earlier version of this test asserted
  /// they matched, which is the assumption that led to minting ticketed events
  /// at /events/<id>, a path the WEBSITE already serves its own marketing
  /// events from.
  const claimed = <String, String>{
    '/tickets/': 'ticketingDetail',
    '/crowdfund/': 'crowdfundDetails',
    '/groups/': 'groupAccount',
    '/escrow/offer/': 'escrow',
    '/family/invite/': 'family',
  };

  test('Android claims every share path', () {
    for (final path in claimed.keys) {
      expect(
        manifest.contains('android:pathPrefix="$path"'),
        isTrue,
        reason: 'AndroidManifest.xml does not claim $path, so the OS opens a '
            'browser and the app never sees the link',
      );
    }
  });

  test('iOS claims every share path', () {
    for (final path in claimed.keys) {
      final wildcard = '$path*';
      expect(
        iosPaths.contains(wildcard),
        isTrue,
        reason: 'the website apple-app-site-association does not list '
            '$wildcard, so iOS hands the link to Safari. The entitlement '
            'claims the host; this file is what restricts the paths.',
      );
    }
  });

  test('the two allow-lists agree with each other', () {
    // A path claimed on one platform and not the other is the worst shape of
    // this bug: it works on the reviewer's phone and not on half the users'.
    final androidPrefixes = RegExp(r'android:pathPrefix="([^"]+)"')
        .allMatches(manifest)
        .map((m) => m.group(1)!)
        .where((p) => p.endsWith('/'))
        .toSet();
    for (final p in androidPrefixes) {
      expect(iosPaths.contains('$p*'), isTrue,
          reason: 'Android claims $p and iOS does not — the link opens the app '
              'on one platform and a web page on the other');
    }
  });

  group('a ticketed event, end to end', () {
    test('DeepLinkService parses it and pulls the id out', () {
      expect(deepLinkService.contains('ticketEvent'), isTrue,
          reason: 'DeepLinkType has no case for a shared event, so the app '
              'receives the link and resolves it to `unknown`');
      expect(deepLinkService.contains('ticketEventId'), isTrue,
          reason: 'the event id is parsed nowhere, so the route has nothing '
              'to open');
      expect(deepLinkService.contains("uri.host == 'tickets'"), isTrue,
          reason: 'the custom-scheme form (lazervault://tickets/<id>) puts the '
              "id in the host's first segment and is not handled");
    });

    test('the id is SHAPE-CHECKED before it reaches a gRPC call', () {
      // `/events-mine` and `/events-create` are app routes. If either ever
      // becomes a shared URL, a naive segments[0] opens an event whose id is
      // literally "mine" — the trap the donation-receipt branch above it
      // documents having already been hit once.
      expect(deepLinkService.contains('_looksLikeUuid'), isTrue,
          reason: 'an id that is not a uuid goes straight into a request that '
              'rejects it opaquely, and the user gets a permanent spinner');
    });

    test('main.dart routes it THROUGH the login gate', () {
      expect(main.contains('DeepLinkType.ticketEvent'), isTrue,
          reason: 'the link parses and then goes nowhere');
      final at = main.indexOf('case DeepLinkType.ticketEvent:');
      expect(at, greaterThan(-1));
      // SLICED TO THE NEXT `case`, not to a fixed character count. A count is
      // a guess about how much comment the branch carries — this branch's own
      // explanation is long enough that a 900-char window ended before the
      // code, so the test failed on correct code. The next case label is the
      // actual boundary.
      final next = main.indexOf('      case DeepLinkType.', at + 10);
      final body = next > at ? main.substring(at, next) : main.substring(at);
      expect(
        body.contains('PendingDeepLink.instance.push'),
        isTrue,
        reason: 'a bare Get.toNamed drops the event at the login gate — and '
            'for ticketing the person tapping a shared link is USUALLY signed '
            'out, because the link is how an event is distributed',
      );
      expect(
        body.contains("replaceFirst(':eventId'"),
        isTrue,
        reason: 'the route carries the id in its PATH, so passing it as an '
            'argument arrives as a null id and renders the error state',
      );
    });

    test('and the route it names exists', () {
      expect(appRoutes.contains('ticketingDetail'), isTrue);
      expect(appRoutes.contains("'/events/:eventId'"), isTrue,
          reason: 'the in-app route the handler substitutes into must exist, '
              'or the mapping lands nowhere');
    });

    test('and /events/ is NOT claimed, because the website owns it', () {
      // THE REGRESSION THIS PREVENTS: the website serves its own marketing
      // events at /events/[slug]. Claiming that prefix for the app would have
      // the OS intercept THOSE links, hand them to a parser with no such
      // event, and drop the visitor on the dashboard — breaking a feature this
      // one has nothing to do with.
      expect(manifest.contains('android:pathPrefix="/events/"'), isFalse,
          reason: 'Android claims /events/, which belongs to the website');
      expect(iosPaths.contains('/events/*'), isFalse,
          reason: 'iOS claims /events/*, which belongs to the website');
    });
  });
}
