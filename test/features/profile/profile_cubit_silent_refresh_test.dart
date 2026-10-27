// Settings re-opened on a full-screen loader because every refresh emitted
// ProfileLoading over a profile the cubit already held. A silent refresh keeps
// the held ProfileLoaded until the fresh one lands; the very first load (no
// profile yet) still announces itself.
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/profile/domain/entities/user_preferences.dart';
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:mocktail/mocktail.dart';

class _Repo extends Mock implements IProfileRepository {}

class _Sync extends Mock implements CurrencySyncService {}

void main() {
  late _Repo repo;
  late ProfileCubit cubit;

  final user = User(
    id: 'u1',
    firstName: 'Ada',
    lastName: 'Okafor',
    email: 'ada@example.com',
    verified: true,
    isEmailVerified: true,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  );

  setUp(() {
    if (!serviceLocator.isRegistered<LocaleManager>()) {
      serviceLocator.registerSingleton<LocaleManager>(LocaleManager());
    }
    repo = _Repo();
    final locale = serviceLocator<LocaleManager>().currentCountry;
    // activeCountry already matches the locale, so the success branch has no
    // follow-up preference write to make.
    final prefs = UserPreferences(userId: 'u1', activeCountry: locale);
    when(() => repo.getUserProfile()).thenAnswer(
      (_) async => Right({'user': user, 'preferences': prefs}),
    );
    cubit = ProfileCubit(repository: repo, currencySyncService: _Sync());
  });

  tearDown(() => cubit.close());

  test('a silent refresh over a held profile never emits ProfileLoading',
      () async {
    await cubit.getUserProfile();
    expect(cubit.state, isA<ProfileLoaded>());

    final seen = <ProfileState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.getUserProfile(silent: true);
    // Stream delivery trails the synchronous emit by a microtask.
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();

    expect(seen.whereType<ProfileLoading>(), isEmpty);
    expect(cubit.state, isA<ProfileLoaded>());
  });

  test('the first load still announces itself, silent or not', () async {
    final seen = <ProfileState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.getUserProfile(silent: true);
    // Stream delivery trails the synchronous emit by a microtask.
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();

    expect(seen.first, isA<ProfileLoading>());
    expect(seen.last, isA<ProfileLoaded>());
  });

  test('a plain refresh keeps its original Loading emission', () async {
    await cubit.getUserProfile();
    final seen = <ProfileState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.getUserProfile();
    // Stream delivery trails the synchronous emit by a microtask.
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();
    expect(seen.first, isA<ProfileLoading>());
  });
}
