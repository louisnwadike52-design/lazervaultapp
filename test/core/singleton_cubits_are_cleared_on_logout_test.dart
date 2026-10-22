import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// A lazy-singleton cubit outlives the session that filled it.
///
/// On 2026-10-22 an account switch on one phone (Praiz → Chris) left
/// StatisticsCubit holding the previous user's wallet ids. The statistics
/// screen fans out one analytics call per cached wallet, so every call went to
/// accounts-service for somebody else's accounts and was refused —
/// "account does not belong to user" — and the page never loaded.
///
/// Fixing it turned up FOUR MORE of the same shape: BudgetCubit, MandateCubit,
/// NotificationBadgeCubit and SplitBillCountCubit each already had a reset
/// method and nothing called any of them. That is the recurring defect here —
/// written, reachable, consulted by nothing — so this makes it fail loudly
/// instead of showing up as one user seeing another's numbers.
///
/// The rule: every `registerLazySingleton<...Cubit>` either gets cleared in
/// AuthenticationCubit.logout(), or is named below with the reason it holds no
/// user data.
void main() {
  // Singletons that are deliberately NOT cleared, with why. Anything here is a
  // claim that the cubit holds nothing belonging to a signed-in user.
  const notUserScoped = <String, String>{
    'CryptoConfigCubit':
        'platform fee configuration — mode, bps, caps, min order sizes, '
            'currency decimals. Identical for every user.',
  };

  String stripComments(String src) {
    final noBlock = src.replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '');
    return noBlock
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
  }

  test('every singleton cubit is cleared on logout, or justified here', () {
    final di = File('lib/core/services/injection_container.dart');
    final auth = File(
        'lib/src/features/authentication/cubit/authentication_cubit.dart');
    expect(di.existsSync(), isTrue, reason: 'DI container moved');
    expect(auth.existsSync(), isTrue, reason: 'AuthenticationCubit moved');

    final registered = RegExp(r'registerLazySingleton<\s*([A-Za-z0-9_]*Cubit)\s*>')
        .allMatches(stripComments(di.readAsStringSync()))
        .map((m) => m.group(1)!)
        .toSet();

    expect(registered, isNotEmpty,
        reason: 'found no singleton cubits — the registration shape changed '
            'and this guard is now blind; re-point it');

    // COMMENTS ARE STRIPPED FIRST. logout() explains this very bug at length
    // and names the cubits in prose, so a raw scan would match its own
    // explanation and pass while the wiring was gone.
    final logout = stripComments(auth.readAsStringSync());

    final unhandled = <String>[];
    for (final cubit in registered) {
      if (notUserScoped.containsKey(cubit)) continue;
      if (!logout.contains('$cubit>()')) unhandled.add(cubit);
    }

    expect(
      unhandled,
      isEmpty,
      reason: 'these singleton cubits survive logout with the previous '
          "user's data and nothing clears them:\n  ${unhandled.join('\n  ')}\n"
          'Either call their reset from AuthenticationCubit.logout(), or add '
          'them to notUserScoped above with the reason they hold no user data.',
    );
  });

  test('the justified exceptions carry a real reason', () {
    notUserScoped.forEach((cubit, why) {
      expect(why.trim().length, greaterThan(30),
          reason: '$cubit is exempted without a reason anyone can check');
    });
  });
}
