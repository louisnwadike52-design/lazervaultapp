import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/models/voice_transfer_context.dart';

/// After the first transfer, a voice session carried the previous one forward.
///
/// `VoiceTransferContext.copyWith` preserves every field it is not given — by
/// design, because the context is accumulated piece by piece across chunked
/// WebSocket events. The reset that cleared it between transfers ran on
/// `failed` and `cancelled` only, NOT on `success`. So the second transfer of a
/// session inherited the first one's amount, fee, total, destination, receipt
/// reference and closing balance, and the HUD showed the new recipient beside
/// the old money.
void main() {
  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  const cubit =
      'lib/src/features/voice_session/cubit/voice_session_cubit.dart';
  const hud = 'lib/src/features/voice_session/widgets/voice_transfer_hud.dart';
  const sheet =
      'lib/src/features/voice_session/widgets/voice_command_sheet.dart';

  group('a second transfer starts clean', () {
    test('copyWith really does carry the old money forward', () {
      // The premise, stated as a test so the reset below is understood as
      // load-bearing rather than defensive.
      const done = VoiceTransferContext(
        status: VoiceTransferStatus.success,
        recipientName: 'Chris',
        amountNaira: 500,
        feeNaira: 10,
        totalNaira: 510,
        reference: 'TRF-FIRST',
        newBalance: '4,490.00',
      );
      final next = done.copyWith(
        status: VoiceTransferStatus.reviewing,
        recipientName: 'Ada',
      );
      expect(next.amountNaira, 500, reason: 'inherited, as copyWith promises');
      expect(next.reference, 'TRF-FIRST',
          reason: 'the PREVIOUS receipt, now attached to a live review');
    });

    test('every terminal state resets, not just failure', () {
      final src = code(cubit);
      expect(src, contains('if (_transferContext.isTerminal) {'),
          reason: 'resetting on failed/cancelled only leaves a SUCCESSFUL '
              'transfer to contaminate the next one');
      expect(
          src,
          isNot(contains('if (_transferContext.status == VoiceTransferStatus.failed ||')),
          reason: 'the narrow status check is the defect');
    });

    test('every door into a second transfer is guarded', () {
      // Three of them: a new user search; a summary arriving with no search at
      // all (a saved beneficiary, or "send another 500 to the same person");
      // and a request_pin_entry that skips the summary event entirely.
      final src = code(cubit);
      expect(src.split('if (_transferContext.isTerminal) {').length - 1,
          greaterThanOrEqualTo(3),
          reason: 'show_user_search, _applyTransferSummary AND '
              '_applyPinPayload must each reset a terminal context');
    });

    test('isTerminal covers all three endings', () {
      for (final s in [
        VoiceTransferStatus.success,
        VoiceTransferStatus.failed,
        VoiceTransferStatus.cancelled,
      ]) {
        expect(VoiceTransferContext(status: s).isTerminal, isTrue, reason: '$s');
      }
      for (final s in [
        VoiceTransferStatus.idle,
        VoiceTransferStatus.recipientSelected,
        VoiceTransferStatus.amountSet,
        VoiceTransferStatus.reviewing,
        VoiceTransferStatus.awaitingPin,
      ]) {
        expect(VoiceTransferContext(status: s).isTerminal, isFalse,
            reason: '$s is mid-flight and must NOT be reset under the user');
      }
    });
  });

  group('the HUD can be put away', () {
    test('it is dismissible when finished, never mid-payment', () {
      final src = code(hud);
      // The X next to "AUTHORIZE • ENTER PIN" would read as "cancel the
      // payment", which it is not.
      final i = src.indexOf('static bool _canDismiss(');
      expect(i, greaterThan(-1), reason: 'no dismissal rule at all');
      final body = src.substring(i, src.indexOf('\n  }', i));
      // The FIRST return after each case label is what that label actually
      // does. Searching the whole remainder for `return false` passed a
      // mutation that flipped these to true, because the `idle` arm further
      // down still said false.
      String firstReturnAfter(String label) {
        final at = body.indexOf('VoiceTransferStatus.$label:');
        expect(at, greaterThan(-1), reason: '$label is unhandled');
        final rest = body.substring(at);
        final t = rest.indexOf('return true');
        final f = rest.indexOf('return false');
        if (t < 0) return 'false';
        if (f < 0) return 'true';
        return t < f ? 'true' : 'false';
      }

      for (final live in ['amountSet', 'reviewing', 'awaitingPin', 'idle']) {
        expect(firstReturnAfter(live), 'false',
            reason: '$live is a live step the agent is waiting on — an X '
                'beside it reads as "cancel the payment", which it is not');
      }
      for (final done in [
        'success',
        'failed',
        'cancelled',
        'recipientSelected'
      ]) {
        expect(firstReturnAfter(done), 'true',
            reason: '$done has nothing in flight, so the HUD should be '
                'dismissible');
      }
    });

    test('dismissing is UI-only and never cancels with the agent', () {
      final src = code(cubit);
      final i = src.indexOf('void dismissTransferHud()');
      expect(i, greaterThan(-1), reason: 'the X has nothing to call');
      final body = src.substring(i, src.indexOf('\n  }', i));
      expect(body, contains('_resetTransferContext()'));
      expect(body, isNot(contains('sendToVoiceAgent')),
          reason: 'a close button must not move money or cancel a flow');
    });

    test('it re-emits, because the HUD is read through a getter', () {
      // Mutating _transferContext paints nothing on its own, and `emit(state)`
      // is swallowed by Equatable — the context cleared and the HUD stayed.
      final src = code(cubit);
      final i = src.indexOf('void dismissTransferHud()');
      final body = src.substring(i, src.indexOf('\n  }', i));
      expect(body, contains('emit(_rebuildCurrentState())'));
    });

    test('the sheet wires the X and the compact mode', () {
      final src = code(sheet);
      expect(src, contains('onDismiss: () =>'));
      expect(src, contains('dismissTransferHud()'));
      expect(
          src,
          contains(
              'compact: transfer.status == VoiceTransferStatus.recipientSelected'),
          reason: 'the longest-lived state is the one that should be small');
    });
  });

  group('the WebSocket keeps trying', () {
    test('the attempt counter is not reset at dial time', () {
      // IOWebSocketChannel.connect is LAZY: it returns before the handshake.
      // Zeroing the counter there made the backoff INERT — every attempt reset
      // it before the failure arrived, the counter never passed 1, the ceiling
      // was unreachable, and the cubit hammered a dead endpoint every 2
      // seconds for the life of the session.
      final src = code(cubit);
      expect(src, isNot(contains('_wsReconnectAttempts = 0; // Reset on')),
          reason: 'the reset must follow PROOF the socket opened');
      expect(src, contains('_wsHandshakeConfirmed = false;'));
      final i = src.indexOf('void _onWebSocketMessage(');
      final body = src.substring(i, i + 700);
      expect(body, contains('_wsHandshakeConfirmed = true;'));
      expect(body, contains('_wsReconnectAttempts = 0;'),
          reason: 'the first message is the only evidence of a live socket');
    });

    test('a degraded notice does not stop the retries', () {
      final src = code(cubit);
      final i = src.indexOf('void _scheduleWebSocketReconnect()');
      expect(i, greaterThan(-1));
      final body = src.substring(i, src.indexOf('\n  }', i));
      expect(body, contains('_wsDegradedAfterAttempts'));
      // The old code `return`ed right after emitting, permanently abandoning
      // every widget the agent wants to show for the rest of the session. The
      // property is that a timer is STILL SCHEDULED past the notice — not the
      // absence of `return` anywhere, since the timer callback has its own
      // legitimate early-outs.
      final emitAt = body.indexOf('VoiceSessionWebSocketFailed');
      expect(emitAt, greaterThan(-1));
      final afterEmit = body.substring(emitAt);
      expect(afterEmit, contains('_wsReconnectTimer = Timer('),
          reason: 'telling the user visuals are behind must not also give up');
      // And nothing bails out of the method itself between the two.
      final upToTimer =
          afterEmit.substring(0, afterEmit.indexOf('_wsReconnectTimer = Timer('));
      expect(upToTimer.contains('\n      return;'), isFalse,
          reason: 'a method-level return after the notice is the old give-up');
      expect(body, contains('_wsDegradedNotified'),
          reason: 'a long outage should notify once, not on every attempt');
    });

    test('the backoff is capped and jittered', () {
      final src = code(cubit);
      final i = src.indexOf('void _scheduleWebSocketReconnect()');
      final body = src.substring(i, src.indexOf('\n  }', i));
      expect(body, contains('.clamp(2, 20)'),
          reason: 'retrying indefinitely with an uncapped doubling reaches '
              'minutes, and the session looks dead long after the network '
              'came back');
      expect(body, contains('_wsJitter.nextInt'),
          reason: 'a fleet retrying in lockstep after a gateway restart is a '
              'thundering herd');
    });

    test('retries stop only when the voice session itself is over', () {
      final src = code(cubit);
      final i = src.indexOf('void _scheduleWebSocketReconnect()');
      final body = src.substring(i, src.indexOf('\n  }', i));
      expect(body, contains('ConnectionState.connected'),
          reason: 'a closed room means the call ended; anything else means '
              'the user is still talking and still needs the widgets');
    });

    test('a new session starts with clean retry state', () {
      // `_wsDegradedNotified` left true would make the NEXT session's first
      // real outage silent, because the flag that suppresses a repeat notice
      // is still set from the previous call. Same class of stale-flag bug as
      // the transfer context above.
      final src = code(cubit);
      final i = src.indexOf('void _disconnectWebSocket()');
      expect(i, greaterThan(-1));
      final body = src.substring(i, src.indexOf('\n  }', i));
      expect(body, contains('_wsReconnectAttempts = 0;'));
      expect(body, contains('_wsDegradedNotified = false;'));
      expect(body, contains('_wsHandshakeConfirmed = false;'));
      // And no timer survives the session.
      expect(body, contains('_wsReconnectTimer?.cancel()'));
    });

    test('the user is told it is reconnecting, not that it is gone', () {
      // This state used to be the end of the road — the cubit gave up after
      // five attempts — so the copy described a permanent condition. Telling
      // the user the visuals are gone when they are coming back invites them
      // to hang up and start over.
      final src = code(
          'lib/src/features/voice_session/widgets/voice_command_sheet.dart');
      final i = src.indexOf('state is VoiceSessionWebSocketFailed');
      expect(i, greaterThan(-1));
      final block = src.substring(i, i + 500);
      expect(block, contains('Reconnecting'));
      expect(block, isNot(contains('Visual feedback unavailable')));
    });

    test('a synchronous dial failure still retries', () {
      // A throw from connect() never reaches onError, so without this a bad
      // URI or missing route would never retry at all.
      final src = code(cubit);
      final i = src.indexOf('void _connectWebSocket()');
      final body = src.substring(i, src.indexOf('\n  int _wsReconnectAttempts', i));
      final catchAt = body.indexOf('} catch (e) {');
      expect(catchAt, greaterThan(-1));
      expect(body.substring(catchAt), contains('_scheduleWebSocketReconnect()'));
    });
  });
}
