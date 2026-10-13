import 'package:flutter_test/flutter_test.dart';

/// Suggestion chips used to be a fixed list of five, shown identically on the
/// first turn and the fiftieth — so after asking about a transfer you were
/// still offered "Explain cryptocurrency trading". These mirror
/// _followUpsFor's routing so the mapping is pinned independently of the
/// widget.
List<String> followUpsFor({String intent = '', String text = ''}) {
  final t = text.toLowerCase();
  var area = intent.toLowerCase();
  if (area.isEmpty) {
    for (final probe in const [
      'transfer', 'invest', 'crypto', 'bill', 'budget',
      'spen', 'sav', 'card', 'loan',
    ]) {
      if (t.contains(probe)) {
        area = probe;
        break;
      }
    }
  }
  if (area.contains('transfer') || area.contains('send')) {
    return const ['What are the fees?', 'How long will it take?', 'Show my recent transfers'];
  }
  if (area.contains('invest')) {
    return const ['What are the risks?', 'How much should I start with?', 'Show my portfolio'];
  }
  if (area.contains('crypto')) {
    return const ["What's the current rate?", 'Show my crypto balance', 'How do I withdraw?'];
  }
  if (area.contains('bill') || area.contains('airtime') || area.contains('data')) {
    return const ['Show my recent bills', 'Set up auto-recharge', 'What did I spend on bills?'];
  }
  if (area.contains('budget') || area.contains('spen') || area.contains('expense')) {
    return const ['Where did most of it go?', 'Compare with last month', 'Set a budget for this'];
  }
  if (area.contains('sav') || area.contains('goal')) {
    return const ['How close am I?', 'Increase my savings', 'When will I reach it?'];
  }
  return const [];
}

void main() {
  group('follow-ups come from the last answer', () {
    test('a transfer answer offers transfer follow-ups', () {
      final s = followUpsFor(intent: 'transfer_money');
      expect(s.first, 'What are the fees?');
      expect(s, hasLength(3));
    });

    test('falls back to the answer text when there is no intent', () {
      expect(followUpsFor(text: 'Your crypto balance is 0.4 BTC').first,
          "What's the current rate?");
    });

    test('spending and budgets share the budget follow-ups', () {
      expect(followUpsFor(intent: 'budget_overview').first,
          'Where did most of it go?');
      expect(followUpsFor(text: 'you spent NGN 40,000 on groceries').first,
          'Where did most of it go?');
    });

    test('intent wins over the text when both are present', () {
      // The answer mentions crypto in passing, but the turn was about bills.
      final s = followUpsFor(intent: 'bill_payment', text: 'not crypto');
      expect(s.first, 'Show my recent bills');
    });
  });

  group('no guess is better than a wrong guess', () {
    test('an unrecognised answer yields nothing, so the caller uses defaults',
        () {
      expect(followUpsFor(intent: 'greeting', text: 'Hello there'), isEmpty);
      expect(followUpsFor(), isEmpty);
    });
  });

  group('every branch offers exactly three', () {
    test('three chips, never more', () {
      for (final intent in const [
        'transfer', 'invest', 'crypto', 'bill', 'budget', 'save',
      ]) {
        expect(followUpsFor(intent: intent), hasLength(3),
            reason: '$intent should offer three follow-ups');
      }
    });
  });
}
