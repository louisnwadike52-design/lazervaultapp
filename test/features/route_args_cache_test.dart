import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/route_args.dart';

/// `Get.arguments` is one global that GetX overwrites on every push and pop,
/// and a modal sheet carries no arguments — so while one is open the global is
/// null and every screen underneath sees null. Screens that read it in
/// `build()` as a non-null cast threw there, which paints the blank screen
/// people reported after closing a share or format-picker sheet.
///
/// These pin the behaviour the fix depends on. `Get.testMode` keeps GetX from
/// needing a live navigator.
void main() {
  setUp(() {
    Get.testMode = true;
    Get.routing.args = null;
  });

  tearDown(() => Get.routing.args = null);

  test('returns the live arguments when GetX has them', () {
    Get.routing.args = {'provider': 'Spectranet', 'amount': 5000};
    final cache = RouteArgsCache();
    expect(cache.value['provider'], 'Spectranet');
    expect(cache.value['amount'], 5000);
  });

  test('keeps the last good arguments when a sheet nulls the global', () {
    final cache = RouteArgsCache();
    Get.routing.args = {'provider': 'Spectranet'};
    expect(cache.value['provider'], 'Spectranet');

    // A modal sheet pushes: GetX writes its (absent) arguments over the global.
    Get.routing.args = null;
    expect(
      cache.value['provider'],
      'Spectranet',
      reason: 'a rebuild while a sheet is open must not lose the screen',
    );

    // The sheet pops and GetX restores the page's arguments.
    Get.routing.args = {'provider': 'Spectranet'};
    expect(cache.value['provider'], 'Spectranet');
  });

  test('an empty map is never cached as if it were real', () {
    // A screen whose FIRST build lands while a sheet is open would otherwise
    // remember "no arguments" for the rest of its life.
    final cache = RouteArgsCache();
    expect(cache.value, isEmpty);
    expect(cache.isEmpty, isTrue);

    Get.routing.args = {'provider': 'Spectranet'};
    expect(cache.value['provider'], 'Spectranet');
    expect(cache.isEmpty, isFalse);
  });

  test('later arguments replace earlier ones', () {
    final cache = RouteArgsCache();
    Get.routing.args = {'provider': 'Spectranet'};
    expect(cache.value['provider'], 'Spectranet');
    Get.routing.args = {'provider': 'Smile'};
    expect(cache.value['provider'], 'Smile');
  });

  test('never throws on a non-map, unlike the cast it replaces', () {
    final cache = RouteArgsCache();
    Get.routing.args = 'a bare string';
    expect(cache.value, isEmpty);
    Get.routing.args = 42;
    expect(cache.value, isEmpty);
  });

  test('coerces a Map with non-string keys instead of failing the cast', () {
    final cache = RouteArgsCache();
    Get.routing.args = <dynamic, dynamic>{'provider': 'Smile', 1: 'one'};
    expect(cache.value['provider'], 'Smile');
    expect(cache.value['1'], 'one');
  });

  test('a non-map after good arguments keeps the good ones', () {
    final cache = RouteArgsCache();
    Get.routing.args = {'provider': 'Spectranet'};
    expect(cache.value['provider'], 'Spectranet');
    Get.routing.args = null;
    Get.routing.args = 'nonsense';
    expect(cache.value['provider'], 'Spectranet');
  });
}
