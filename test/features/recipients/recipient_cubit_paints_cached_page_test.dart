// Send Funds → Saved recipients must paint the page the user saw last time
// INSTANTLY on re-open (no loader) and refresh behind it. The cubit is a
// factory, so the memory lives in `recipientsPageStore`; these tests pin
// that a fresh cubit paints it, that it never paints another view's rows,
// and that a failed refresh keeps the painted page rather than erroring.
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_user_id.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/delete_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/toggle_favorite_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/update_alias_usecase.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_page_store.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Get extends Mock implements GetRecipientsUseCase {}

class _Add extends Mock implements AddRecipientUseCase {}

class _Toggle extends Mock implements ToggleFavoriteUseCase {}

class _Alias extends Mock implements UpdateAliasUseCase {}

class _Delete extends Mock implements DeleteRecipientUseCase {}

RecipientModel _r(String id) => RecipientModel(
      id: id,
      name: 'R $id',
      accountNumber: '00$id',
      bankName: 'Bank',
      isFavorite: false,
      sortCode: '',
    );

PaginatedRecipientsResult _page(List<RecipientModel> rows) =>
    PaginatedRecipientsResult(
      recipients: rows,
      hasMore: false,
      currentPage: 1,
      totalItems: rows.length,
      totalPages: 1,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Get get;

  RecipientCubit build() => RecipientCubit(
        getRecipientsUseCase: get,
        addRecipientUseCase: _Add(),
        toggleFavoriteUseCase: _Toggle(),
        updateAliasUseCase: _Alias(),
        deleteRecipientUseCase: _Delete(),
      );

  void stubFetch(Either<Failure, PaginatedRecipientsResult> answer) {
    when(() => get.callPaginated(
          accessToken: any(named: 'accessToken'),
          countryCode: any(named: 'countryCode'),
          currency: any(named: 'currency'),
          favoritesOnly: any(named: 'favoritesOnly'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        )).thenAnswer((_) async => answer);
  }

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    recipientsPageStore.clear();
    SessionUserId.resolverForTest = () => 'user-1';
    get = _Get();
  });

  tearDown(() => SessionUserId.resolverForTest = null);

  test('first ever load shows the loader, then stores page one', () async {
    stubFetch(Right(_page([_r('1'), _r('2')])));
    final c = build();
    final seen = <RecipientState>[];
    c.stream.listen(seen.add);
    await c.getRecipients(accessToken: 't', countryCode: 'NG', currency: 'NGN');
    await Future<void>.delayed(Duration.zero);

    expect(seen.first, isA<RecipientLoading>());
    expect(seen.last, isA<RecipientLoaded>());
    expect(
      recipientsPageStore.peek(
        userId: 'user-1',
        scope: recipientsPageScope(countryCode: 'NG', currency: 'NGN'),
      ),
      hasLength(2),
    );
  });

  test('a fresh cubit paints the remembered page before fetching', () async {
    recipientsPageStore.put([_r('old')],
        userId: 'user-1',
        scope: recipientsPageScope(countryCode: 'NG', currency: 'NGN'));
    stubFetch(Right(_page([_r('fresh')])));
    final c = build();
    final seen = <RecipientState>[];
    c.stream.listen(seen.add);
    await c.getRecipients(accessToken: 't', countryCode: 'NG', currency: 'NGN');
    await Future<void>.delayed(Duration.zero);

    expect(seen.whereType<RecipientLoading>(), isEmpty,
        reason: 'no loader over a remembered page');
    final first = seen.first as RecipientLoaded;
    expect(first.recipients.single.id, 'old');
    expect(first.isRevalidating, isTrue);
    expect(first.hasMore, isFalse, reason: 'no load-more during the refresh');
    final last = seen.last as RecipientLoaded;
    expect(last.recipients.single.id, 'fresh');
    expect(last.isRevalidating, isFalse);
  });

  test('another view (currency) or another user never gets the page', () async {
    recipientsPageStore.put([_r('ngn')],
        userId: 'user-1',
        scope: recipientsPageScope(countryCode: 'NG', currency: 'NGN'));
    stubFetch(Right(_page([_r('usd')])));
    final c = build();
    final seen = <RecipientState>[];
    c.stream.listen(seen.add);
    await c.getRecipients(accessToken: 't', countryCode: 'NG', currency: 'USD');
    await Future<void>.delayed(Duration.zero);
    expect(seen.first, isA<RecipientLoading>());

    SessionUserId.resolverForTest = () => 'user-2';
    final c2 = build();
    final seen2 = <RecipientState>[];
    c2.stream.listen(seen2.add);
    await c2.getRecipients(
        accessToken: 't', countryCode: 'NG', currency: 'NGN');
    await Future<void>.delayed(Duration.zero);
    expect(seen2.first, isA<RecipientLoading>());
  });

  test('a failed refresh keeps the painted page, no error screen', () async {
    recipientsPageStore.put([_r('kept')],
        userId: 'user-1',
        scope: recipientsPageScope(countryCode: 'NG', currency: 'NGN'));
    stubFetch(Left(ServerFailure(message: 'boom', statusCode: 500)));
    final c = build();
    await c.getRecipients(accessToken: 't', countryCode: 'NG', currency: 'NGN');
    await Future<void>.delayed(Duration.zero);

    final s = c.state;
    expect(s, isA<RecipientLoaded>());
    expect((s as RecipientLoaded).recipients.single.id, 'kept');
    expect(s.isRevalidating, isFalse);
  });
}
