import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_recipient_card.dart';

/// A name search that matches several people ends in the user choosing. That
/// choice was offered as MARKDOWN — the agent wrote a numbered list into its
/// reply and waited for a typed answer. The structured list was emitted all
/// along (`_visual_feedback` with `user_search_results`) and NOTHING rendered
/// it: grep for that key across the app returns nothing, and the voice socket
/// handles no candidates event.
///
/// So the one moment where picking the wrong row sends money to a stranger was
/// the moment with no UI. These cover the list, and the shape of the pick that
/// goes back — which must be unambiguous, because two people in one list can
/// share a display name. That is the whole reason the list exists.
void main() {
  Widget host(Widget child) => ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            backgroundColor: const Color(0xFF1F1F1F),
            body: SingleChildScrollView(child: child),
          ),
        ),
      );

  Map<String, dynamic> payload({
    int total = 3,
    List<Map<String, dynamic>>? candidates,
    String query = 'wanne emmanuella',
  }) =>
      {
        'kind': 'candidates',
        'selectable': true,
        'query': query,
        'total': total,
        'candidates': candidates ??
            [
              {
                'index': 1,
                'display_name': 'Wanne Emmanuella',
                'username': 'forward_order',
                'avatar_url': '',
                'recipient_id': 'u1',
              },
              {
                'index': 2,
                'display_name': 'Emmanuella Wanne',
                'username': 'wanne_e',
                'avatar_url': '',
                'recipient_id': 'u2',
              },
              {
                'index': 3,
                'display_name': 'Chidi Wanne',
                'username': 'chidi_w',
                'avatar_url': '',
                'recipient_id': 'u3',
              },
            ],
      };

  testWidgets('renders one row per candidate, with names and handles',
      (tester) async {
    await tester.pumpWidget(host(ChatRecipientCard(data: payload())));
    await tester.pumpAndSettle();

    expect(find.text('Wanne Emmanuella'), findsOneWidget);
    expect(find.text('Emmanuella Wanne'), findsOneWidget);
    expect(find.text('Chidi Wanne'), findsOneWidget);
    // The handle is what distinguishes two people with the same name.
    expect(find.text('@wanne_e'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('says how many matched and what was searched', (tester) async {
    await tester.pumpWidget(host(ChatRecipientCard(data: payload())));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('matched "wanne emmanuella"'),
      findsOneWidget,
      reason: 'the user has to know this list answers THEIR query',
    );
  });

  testWidgets('a tap sends the @username, not the display name',
      (tester) async {
    String? sent;
    await tester.pumpWidget(host(ChatRecipientCard(
      data: payload(),
      onSelectCandidate: (i, u, d) =>
          sent = u.isNotEmpty ? '@$u' : (d.isNotEmpty ? d : '$i'),
    )));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Emmanuella Wanne'));
    await tester.pumpAndSettle();

    expect(sent, '@wanne_e',
        reason: 'a display name can be shared by two rows in this very list, '
            'so sending it back is ambiguous at exactly the wrong moment');
  });

  testWidgets('falls back to the index when a candidate has no handle',
      (tester) async {
    String? sent;
    await tester.pumpWidget(host(ChatRecipientCard(
      data: payload(
        total: 1,
        candidates: [
          {'index': 7, 'display_name': '', 'username': '', 'avatar_url': ''},
        ],
      ),
      onSelectCandidate: (i, u, d) =>
          sent = u.isNotEmpty ? '@$u' : (d.isNotEmpty ? d : '$i'),
    )));
    await tester.pumpAndSettle();

    // Never an unlabelled, untappable row.
    expect(find.text('Recipient'), findsOneWidget);
    await tester.tap(find.text('Recipient'));
    await tester.pumpAndSettle();
    expect(sent, '7',
        reason: 'the position is the last identifier that still works, and '
            'select_recipient accepts it');
  });

  testWidgets('tells the user when more matched than are shown',
      (tester) async {
    await tester.pumpWidget(host(ChatRecipientCard(data: payload(total: 11))));
    await tester.pumpAndSettle();
    expect(find.textContaining('8 more match'), findsOneWidget,
        reason: 'silently truncating lets someone conclude their person is '
            'not on the platform when they are just further down');
  });

  testWidgets('an empty candidate list renders nothing, not an empty box',
      (tester) async {
    await tester.pumpWidget(host(ChatRecipientCard(
      data: payload(total: 0, candidates: const []),
    )));
    await tester.pumpAndSettle();
    expect(find.byType(InkWell), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a normal single-recipient card still renders as a card',
      (tester) async {
    // The list mode must be opt-in on `candidates`; the confirmed-recipient
    // card is the common case and must be untouched.
    await tester.pumpWidget(host(ChatRecipientCard(
      data: const {
        'kind': 'internal',
        'display_name': 'Chris Ezeke',
        'username': 'chris',
        'verified': true,
      },
    )));
    await tester.pumpAndSettle();
    expect(find.text('Chris Ezeke'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('every chat surface passes a selection callback', () {
    // Four surfaces render this card. One that forgets the callback shows the
    // list with dead rows — visibly fine, completely unusable, and silent.
    const surfaces = <String>[
      'lib/src/features/ai_chats/presentation/widgets/ai_chat_content.dart',
      'lib/src/features/microservice_chat/presentation/widgets/general_chat_content.dart',
      'lib/src/features/microservice_chat/presentation/widgets/chat_structured_payloads.dart',
      'lib/src/features/microservice_chat/presentation/widgets/microservice_chat_content.dart',
      'lib/src/features/microservice_chat/presentation/widgets/service_chat_bottom_sheet.dart',
    ];
    for (final p in surfaces) {
      final f = File(p);
      expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
      expect(f.readAsStringSync().contains('onSelectCandidate'), isTrue,
          reason: '$p renders the recipient card without wiring '
              'onSelectCandidate, so a multi-match list appears with rows '
              'that do nothing when tapped');
    }
  });

  test('the backend emits the candidates payload', () {
    // The other end of the same contract: the renderer is useless if the
    // agent stops attaching the list.
    final emit = File('../chat_services_shared/protocol_emit.py');
    if (!emit.existsSync()) return; // app repo checked out alone
    final src = emit.readAsStringSync();
    expect(src.contains('def attach_recipient_candidates('), isTrue,
        reason: 'the emitter is gone — the chat list will never be populated');
    expect(src.contains('"candidates"'), isTrue,
        reason: 'the payload key the client switches on must stay');
  });
}
