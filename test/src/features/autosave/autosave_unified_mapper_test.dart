import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/utils/autosave_unified_mapper.dart';

// The autosave receipt rendered an EMPTY "FROM" box, a beneficiary of
// "Savings" with no account on either side, and a type of "Fund Transfer".
// The unified transfer PDF fills those blocks from specific metadata keys, and
// the mapper wrote none of them — so the document could not say who saved,
// which account funded it, or where it landed.
//
// These pin the keys the PDF actually reads (tag_pay_pdf_service
// generateUnifiedTransferReceipt). Renaming one silently blanks a block again.

AutoSaveTransactionEntity txn({
  String source = 'src-acct',
  String destination = 'dst-acct',
}) =>
    AutoSaveTransactionEntity(
      id: 'txn-1',
      ruleId: 'rule-1',
      userId: 'user-1',
      sourceAccountId: source,
      destinationAccountId: destination,
      amount: 100,
      currency: 'NGN',
      triggerType: TriggerType.roundUp,
      triggerReason: 'manual_trigger',
      success: true,
      createdAt: DateTime(2026, 9, 10),
      metadata: '',
    );

void main() {
  test('the saver fills the FROM heading', () {
    final u = autoSaveTxnToUnified(txn(), userName: 'Praiz Onah');
    // 'Source Account' is the first key generateUnifiedTransferReceipt checks
    // for sourceAccountName, which the PDF prints as the FROM heading.
    expect(u.metadata!['Source Account'], 'Praiz Onah');
  });

  test('the funding account fills the line under FROM', () {
    final u = autoSaveTxnToUnified(txn(), sourceDetail: 'Personal (••••2268)');
    expect(u.metadata!['sender_account'], 'Personal (••••2268)');
  });

  test('a bank-funded save names the BANK, not a wallet account', () {
    // The wallet account id on a Direct Debit row is not the funding source,
    // so printing it would misdescribe where the money came from.
    final u = autoSaveTxnToUnified(txn(), sourceDetail: 'GTBank · Direct Debit');
    expect(u.metadata!['sender_account'], contains('GTBank'));
  });

  test('destination fills the beneficiary, and is NOT the source', () {
    final u = autoSaveTxnToUnified(
      txn(),
      sourceLabel: 'Personal',
      destinationLabel: 'Savings',
      destinationAccount: 'Savings (••••4410)',
    );
    expect(u.metadata!['recipient_name'], 'Savings');
    expect(u.metadata!['recipient_account'], 'Savings (••••4410)');
    // counterpartyAccount feeds the beneficiary account line. It used to be
    // handed the SOURCE, naming the account the money LEFT as the one it
    // arrived in.
    expect(u.counterpartyAccount, 'Savings (••••4410)');
    expect(u.counterpartyAccount, isNot('Personal'));
  });

  test('the type names AutoSave and its trigger, not "Fund Transfer"', () {
    final u = autoSaveTxnToUnified(txn());
    final type = u.metadata!['Transfer Type'] as String;
    expect(type, startsWith('AutoSave'));
    expect(type.toLowerCase(), isNot(contains('fund transfer')));
  });

  test('absent details are omitted, never blank or placeholder', () {
    // A receipt can be forwarded to someone else, so an unresolved name must
    // not print as an empty row or "Unknown" — the key is simply absent and
    // the PDF omits the line.
    final u = autoSaveTxnToUnified(txn());
    expect(u.metadata!.containsKey('Source Account'), isFalse);
    expect(u.metadata!.containsKey('sender_account'), isFalse);
    expect(u.metadata!.containsKey('recipient_account'), isFalse);
  });

  test('an empty string is treated as absent', () {
    final u = autoSaveTxnToUnified(txn(), userName: '', sourceDetail: '');
    expect(u.metadata!.containsKey('Source Account'), isFalse);
    expect(u.metadata!.containsKey('sender_account'), isFalse);
  });
}
