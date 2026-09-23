import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/data/repositories/chat_widget_metadata_hydration.dart';

/// Rich chat widgets survive a reload only if the history mapper copies their metadata
/// forward. Whatever it drops degrades silently to a plain grey bubble — no error, no
/// log, just a receipt that stopped looking like a receipt.
///
/// Two history paths exist (session and per-service direct) and they HAD drifted: the
/// session one hydrated pin_prompt and the V2 receipt_card, the direct one carried only
/// the legacy receipt_data. These tests pin the shared behaviour both now use.

/// A stand-in message, so the strip helper can be exercised without the entity types.
class _Msg {
  final bool isUser;
  final Map<String, dynamic>? metadata;
  _Msg(this.isUser, this.metadata);
}

void main() {
  group('hydrateChatWidgetMetadata', () {
    test('carries the confirm-transfer prompt forward', () {
      // The widget in the screenshot. Losing it means re-entering a chat mid-transfer
      // shows the text "enter your PIN" above no card and no pad.
      final out = hydrateChatWidgetMetadata(
        storedMetadata: {
          'pin_prompt': {'transaction_id': 'tx-1', 'amount': '500'},
        },
      );
      expect(out?[kChatMetaPinPrompt], isA<Map>());
      expect((out![kChatMetaPinPrompt] as Map)['transaction_id'], 'tx-1');
    });

    test('carries a single V2 receipt forward', () {
      final out = hydrateChatWidgetMetadata(
        storedMetadata: {
          'receipt_card': {'reference': 'REF-1'},
        },
      );
      expect(out?[kChatMetaReceiptCard], isA<Map>());
    });

    test('carries a BATCH receipt forward', () {
      // receipt_card is a Map for one receipt and a List for a batch. A type check that
      // only accepted Map would drop every batch receipt — which is why the production
      // check is deliberately loose.
      final out = hydrateChatWidgetMetadata(
        storedMetadata: {
          'receipt_card': [
            {'reference': 'REF-1'},
            {'reference': 'REF-2'},
          ],
        },
      );
      expect(out?[kChatMetaReceiptCard], isA<List>());
      expect((out![kChatMetaReceiptCard] as List).length, 2);
    });

    test('reads the legacy receipt out of entities', () {
      // Older conversations stored the receipt in the entity bag before it moved into
      // metadata. Those transcripts must still render.
      final out = hydrateChatWidgetMetadata(
        entities: {
          '_receipt_data': {'reference': 'OLD-1'},
        },
      );
      expect(out?[kChatMetaReceiptData], isA<Map>());
    });

    test('metadata wins over the legacy entity copy', () {
      // A migrated message carries both. Metadata is the current one; preferring
      // entities would render a stale copy of the same receipt.
      final out = hydrateChatWidgetMetadata(
        storedMetadata: {
          'receipt_data': {'reference': 'NEW'},
        },
        entities: {
          '_receipt_data': {'reference': 'OLD'},
        },
      );
      expect((out![kChatMetaReceiptData] as Map)['reference'], 'NEW');
    });

    test('a plain text turn gains no metadata', () {
      // Returning an empty map instead of null would make every bubble look like it
      // carries a widget to any caller doing a null check.
      expect(hydrateChatWidgetMetadata(storedMetadata: {'foo': 'bar'}), isNull);
      expect(hydrateChatWidgetMetadata(), isNull);
    });

    test('hydrates several widgets on one message', () {
      // A turn can both confirm and receipt. Copying only the first one found was the
      // shape of the original bug.
      final out = hydrateChatWidgetMetadata(
        storedMetadata: {
          'pin_prompt': {'transaction_id': 'tx-1'},
          'receipt_card': {'reference': 'REF-1'},
          'receipt_data': {'reference': 'REF-0'},
        },
      );
      expect(out?.keys, containsAll([
        kChatMetaPinPrompt,
        kChatMetaReceiptCard,
        kChatMetaReceiptData,
      ]));
    });
  });

  group('markSupersededPinPrompts', () {
    test('a superseded prompt STAYS, stamped inactive', () {
      // The card is part of what happened. Deleting it left a completed transfer showing
      // only its receipt, with no record of what the user actually approved.
      final msgs = [
        _Msg(false, {'pin_prompt': {'transaction_id': 'old'}}),
        _Msg(true, null),
        _Msg(false, {'pin_prompt': {'transaction_id': 'latest'}}),
      ];
      markSupersededPinPrompts<_Msg>(
        msgs,
        isUser: (m) => m.isUser,
        metadataOf: (m) => m.metadata,
      );
      final old = msgs[0].metadata!['pin_prompt'] as Map;
      expect(old['transaction_id'], 'old', reason: 'the card must not be removed');
      expect(old[kPinPromptHistoryState], kPinPromptStateInactive);
      // The live one is untouched, so it stays interactive.
      expect((msgs[2].metadata!['pin_prompt'] as Map)[kPinPromptHistoryState], isNull);
    });

    test('stamps completed only when a receipt references that transaction', () {
      // Evidence, not position: the platform reference embeds the chat intent id.
      final msgs = [
        _Msg(false, {'pin_prompt': {'transaction_id': 'transfer-abc123'}}),
        _Msg(false, {'receipt_card': {'reference': 'TRF-CHAT-transfer-abc123'}}),
        _Msg(false, {'pin_prompt': {'transaction_id': 'latest'}}),
      ];
      markSupersededPinPrompts<_Msg>(
        msgs,
        isUser: (m) => m.isUser,
        metadataOf: (m) => m.metadata,
      );
      expect(
        (msgs[0].metadata!['pin_prompt'] as Map)[kPinPromptHistoryState],
        kPinPromptStateCompleted,
      );
    });

    test('an unmatched prompt is never claimed as completed', () {
      // It may simply have been abandoned. Telling someone a transfer completed when it
      // did not is the one error worth avoiding on a money card.
      final msgs = [
        _Msg(false, {'pin_prompt': {'transaction_id': 'transfer-abc123'}}),
        _Msg(false, {'receipt_card': {'reference': 'TRF-CHAT-transfer-SOMETHINGELSE'}}),
        _Msg(false, {'pin_prompt': {'transaction_id': 'latest'}}),
      ];
      markSupersededPinPrompts<_Msg>(
        msgs,
        isUser: (m) => m.isUser,
        metadataOf: (m) => m.metadata,
      );
      expect(
        (msgs[0].metadata!['pin_prompt'] as Map)[kPinPromptHistoryState],
        kPinPromptStateInactive,
      );
    });

    test('matches a receipt delivered as a BATCH list', () {
      final msgs = [
        _Msg(false, {'pin_prompt': {'transaction_id': 'transfer-xyz'}}),
        _Msg(false, {
          'receipt_card': [
            {'reference': 'TRF-CHAT-other'},
            {'reference': 'TRF-CHAT-transfer-xyz'},
          ]
        }),
        _Msg(false, {'pin_prompt': {'transaction_id': 'latest'}}),
      ];
      markSupersededPinPrompts<_Msg>(
        msgs,
        isUser: (m) => m.isUser,
        metadataOf: (m) => m.metadata,
      );
      expect(
        (msgs[0].metadata!['pin_prompt'] as Map)[kPinPromptHistoryState],
        kPinPromptStateCompleted,
      );
    });

    test('a trailing user message does not supersede the prompt', () {
      // Typing after a prompt does not settle it — "latest ASSISTANT turn" is the rule.
      final msgs = [
        _Msg(false, {'pin_prompt': {'transaction_id': 'live'}}),
        _Msg(true, null),
      ];
      markSupersededPinPrompts<_Msg>(
        msgs,
        isUser: (m) => m.isUser,
        metadataOf: (m) => m.metadata,
      );
      expect((msgs[0].metadata!['pin_prompt'] as Map)[kPinPromptHistoryState], isNull);
    });
  });
}
