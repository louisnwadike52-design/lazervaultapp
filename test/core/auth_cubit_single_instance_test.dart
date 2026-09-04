import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the "Guest User after login" bug structurally.
///
/// AuthenticationCubit holds the signed-in identity in memory
/// (`_currentProfile`). The bug was not a logic error anywhere in the auth
/// code, so no behavioural test would have caught it: the cubit was registered
/// with registerFactory, and the login screens each built their own with
/// BlocProvider(create:). Sign-in then set the identity on the login screen's
/// instance while the dashboard read the root instance, which never learned
/// about it. Tokens were in secure storage, so the tiles and API calls all
/// worked and only the identity was missing — the drawer rendered "Guest User"
/// and anything gated on the profile waited forever.
///
/// Both halves matter, which is why both are asserted:
///   * one registration, so every resolve is the same object;
///   * `.value` at every provider, because BlocProvider(create:) CLOSES the
///     bloc when its widget unmounts, and on a shared instance that would kill
///     the app-wide session the moment a login screen popped.
void main() {
  final libDir = Directory('lib');

  List<File> dartFiles() => libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  test('AuthenticationCubit is registered exactly once, as a singleton', () {
    final di = File('lib/core/services/injection_container.dart');
    expect(di.existsSync(), isTrue, reason: 'injection container moved');
    final src = di.readAsStringSync();

    expect(
      src.contains('registerLazySingleton(() => AuthenticationCubit('),
      isTrue,
      reason: 'AuthenticationCubit must be a lazy singleton so every resolve '
          'returns the object that actually holds the signed-in identity',
    );
    expect(
      src.contains('registerFactory(() => AuthenticationCubit('),
      isFalse,
      reason: 'registerFactory hands every caller a fresh cubit with a null '
          'profile, which is what produced "Guest User" after login',
    );
  });

  test('no widget creates its own AuthenticationCubit', () {
    final offenders = <String>[];
    final pattern = RegExp(
      r'BlocProvider(<AuthenticationCubit>)?\(\s*\n?\s*create:\s*\([^)]*\)\s*=>\s*serviceLocator<AuthenticationCubit>\(\)',
      multiLine: true,
    );

    for (final f in dartFiles()) {
      if (pattern.hasMatch(f.readAsStringSync())) offenders.add(f.path);
    }

    expect(
      offenders,
      isEmpty,
      reason: 'These provide AuthenticationCubit with create:, which both '
          'forks the identity and closes the shared cubit on dispose. Use '
          'BlocProvider<AuthenticationCubit>.value(value: serviceLocator<...>()) '
          'instead:\n  ${offenders.join("\n  ")}',
    );
  });
}
