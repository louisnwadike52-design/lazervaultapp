import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/recipients/data/datasources/recipient_verification_remote_datasource.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_suggestion.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_verification_result.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';

/// A datasource that answers nothing. These tests are about the LOCAL half of
/// the suggestion list — the half that must resolve without a network at all.
class _SilentSource implements RecipientVerificationRemoteDataSource {
  int suggestCalls = 0;

  @override
  Future<List<AccountSuggestion>> suggestAccounts({
    required String accountNumber,
    String country = 'NG',
  }) async {
    suggestCalls++;
    return const <AccountSuggestion>[];
  }

  @override
  Future<AccountVerificationResult> verifyAccount({
    required String bankCode,
    required String accountNumber,
    String country = 'NG',
  }) async =>
      throw UnimplementedError();

  @override
  Future<List<Map<String, String>>> getSupportedBanks({String country = 'NG'}) async =>
      const <Map<String, String>>[];

  @override
  void dispose() {}
}

RecipientModel _payee(
  String name,
  String number, {
  String bank = 'GTBank',
  String code = '058',
  String? alias,
}) {
  return RecipientModel(
    id: number,
    name: name,
    accountNumber: number,
    bankName: bank,
    isFavorite: false,
    sortCode: code,
    alias: alias,
  );
}

void main() {
  late _SilentSource source;

  AccountVerificationCubit cubitWith(List<RecipientModel> saved) {
    source = _SilentSource();
    return AccountVerificationCubit(
      dataSource: source,
      savedRecipients: () => saved,
    );
  }

  group('savedRecipientMatches', () {
    test('matches from the first digits typed, before any number is complete',
        () {
      final c = cubitWith([
        _payee('Ada Obi', '0123456789'),
        _payee('Bisi Lawal', '9876543210'),
      ]);
      final hits = c.savedRecipientMatches('012');
      expect(hits, hasLength(1));
      expect(hits.single.accountName, 'Ada Obi');
      expect(hits.single.isSavedRecipient, isTrue);
      expect(source.suggestCalls, 0,
          reason: 'a saved-payee match must cost no network call at all — '
              'that is the whole reason it can answer on the keystroke');
    });

    test('a PREFIX match outranks a mid-number one', () {
      // "345" starts Chidi's number and sits in the middle of Ada's.
      final c = cubitWith([
        _payee('Ada Obi', '0123456789'),
        _payee('Chidi Eze', '3456789012'),
      ]);
      final hits = c.savedRecipientMatches('345');
      expect(hits.map((h) => h.accountName).toList(),
          ['Chidi Eze', 'Ada Obi'],
          reason: 'a number is typed from the left, so the prefix is what the '
              'payer is doing; the contains match is the "I remember the last '
              'four digits" case and belongs behind it');
    });

    test('compares on DIGITS ONLY, both sides', () {
      final c = cubitWith([_payee('Ada Obi', '0123-456-789')]);
      expect(c.savedRecipientMatches('0123'), hasLength(1),
          reason: 'saved rows written by older builds carry spaces and dashes');
    });

    test('caps the rows so the overlay cannot outgrow the screen', () {
      final c = cubitWith([
        for (int i = 0; i < 12; i++) _payee('Payee $i', '01234567${i}0'),
      ]);
      expect(c.savedRecipientMatches('012', limit: 3), hasLength(3));
    });

    test('the payer\'s own alias leads the row when they set one', () {
      final c = cubitWith([
        _payee('ADAEZE N OBI', '0123456789', alias: 'Mum'),
      ]);
      expect(c.savedRecipientMatches('012').single.displayName, 'Mum');
    });

    test('an empty query matches nothing — not everything', () {
      final c = cubitWith([_payee('Ada Obi', '0123456789')]);
      expect(c.savedRecipientMatches(''), isEmpty);
      expect(c.savedRecipientMatches('  '), isEmpty);
    });

    test('a provider that throws costs the convenience, never the flow', () {
      final c = AccountVerificationCubit(
        dataSource: _SilentSource(),
        savedRecipients: () => throw StateError('cache not ready'),
      );
      expect(c.savedRecipientMatches('012'), isEmpty);
    });

    test('no provider wired at all behaves as it did before this existed', () {
      final c = AccountVerificationCubit(dataSource: _SilentSource());
      expect(c.savedRecipientMatches('012'), isEmpty);
    });
  });

  group('suggestBanks accepts every number the field does', () {
    // THE GUARD READ `length != 10`.
    //
    // The account field had already been widened to 11 digits for the wallets
    // that assign phone-number-based accounts (OPay, PalmPay, Moniepoint), and
    // the surface reads an empty result as "could not resolve" — so a valid
    // wallet number returned no saved payee, no internal match and no bank,
    // and dropped the payer into manual bank selection.
    test('an 11-digit wallet number still resolves a saved payee', () async {
      final c = cubitWith([_payee('Ada Obi', '08012345678', bank: 'OPay')]);
      final hits = await c.suggestBanks(accountNumber: '08012345678');
      expect(hits, isNotEmpty,
          reason: 'an 11-digit wallet number used to return nothing at all');
      expect(hits.first.accountName, 'Ada Obi');
    });

    test('a 10-digit NUBAN is unchanged', () async {
      final c = cubitWith([_payee('Ada Obi', '0123456789')]);
      expect(await c.suggestBanks(accountNumber: '0123456789'), isNotEmpty);
    });

    test('a short or malformed number still costs no network call', () async {
      final c = cubitWith([_payee('Ada Obi', '0123456789')]);
      expect(await c.suggestBanks(accountNumber: '012'), isEmpty);
      // 11 digits WITHOUT the leading zero is not a wallet form.
      expect(await c.suggestBanks(accountNumber: '12345678901'), isEmpty);
      expect(source.suggestCalls, 0);
    });
  });
}
