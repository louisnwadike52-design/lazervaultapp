import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/support/data/support_models.dart';
import 'package:lazervault/src/features/support/presentation/support_message_time.dart';

/// A TICKET IS A RECORD. It gets quoted back in disputes and chargebacks, so
/// "when was this said" has to be answered the same way on the customer's
/// screen, the agent's desk, and the admin dashboard. These pin the rules the
/// three surfaces share.
SupportMessage msg(String id, DateTime? at) => SupportMessage(
      id: id,
      ticketId: 't1',
      senderType: 'user',
      senderName: 'Someone',
      body: 'hello',
      viaEmail: false,
      createdAt: at,
    );

void main() {
  test('day labels match the P2P chat the user already knows', () {
    final now = DateTime.now();
    expect(SupportMessageTime.dayLabel(now), 'Today');
    expect(
        SupportMessageTime.dayLabel(now.subtract(const Duration(days: 1))),
        'Yesterday');
    expect(SupportMessageTime.dayLabel(DateTime(2026, 3, 9)), 'March 9, 2026');
  });

  test('clock is 24h and zero-padded', () {
    expect(SupportMessageTime.clock(DateTime(2026, 3, 9, 7, 5)), '07:05');
    expect(SupportMessageTime.clock(DateTime(2026, 3, 9, 19, 42)), '19:42');
  });

  test('the first dated message introduces its day', () {
    final list = [msg('a', DateTime(2026, 3, 9, 10))];
    expect(SupportMessageTime.needsDivider(list, 0), isTrue);
  });

  test('a divider appears only when the day actually changes', () {
    final list = [
      msg('a', DateTime(2026, 3, 9, 10)),
      msg('b', DateTime(2026, 3, 9, 23, 59)),
      msg('c', DateTime(2026, 3, 10, 0, 1)),
    ];
    expect(SupportMessageTime.needsDivider(list, 0), isTrue);
    expect(SupportMessageTime.needsDivider(list, 1), isFalse,
        reason: 'same day — a divider here would split one conversation');
    expect(SupportMessageTime.needsDivider(list, 2), isTrue,
        reason: 'one minute later but a different day');
  });

  test('an undated message neither invents nor swallows a divider', () {
    final list = [
      msg('a', DateTime(2026, 3, 9, 10)),
      msg('undated', null),
      msg('c', DateTime(2026, 3, 10, 9)),
    ];
    expect(SupportMessageTime.needsDivider(list, 1), isFalse,
        reason: 'no date means no day to announce');
    expect(SupportMessageTime.needsDivider(list, 2), isTrue,
        reason: 'the undated row must not hide the real day change — the '
            'comparison has to skip back to the last DATED message');
  });

  test('a thread that opens with undated rows still labels its first day', () {
    final list = [
      msg('undated', null),
      msg('b', DateTime(2026, 3, 9, 10)),
    ];
    expect(SupportMessageTime.needsDivider(list, 0), isFalse);
    expect(SupportMessageTime.needsDivider(list, 1), isTrue);
  });

  test('out of range indices are safe', () {
    expect(SupportMessageTime.needsDivider(const [], 0), isFalse);
    expect(SupportMessageTime.needsDivider([msg('a', null)], -1), isFalse);
    expect(SupportMessageTime.needsDivider([msg('a', null)], 5), isFalse);
  });
}
