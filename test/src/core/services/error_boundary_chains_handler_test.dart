import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/core/services/error_boundary.dart';

/// ErrorBoundary must not steal the global error handler.
///
/// main.dart installs a FlutterError.onError that prints the exception and
/// ships it, with its stack, to Loki. On a real device that is the only
/// readable crash channel — logcat carries nothing but an analytics counter.
///
/// This widget used to assign FlutterError.onError outright, so mounting one
/// anywhere would have silently destroyed crash reporting app-wide. It is
/// currently mounted nowhere, which is the only reason the bug never fired;
/// a test is what keeps that from being luck.
void main() {
  testWidgets('chains to the handler that was already installed',
      (tester) async {
    final original = FlutterError.onError;
    final seen = <FlutterErrorDetails>[];
    FlutterError.onError = seen.add;

    await tester.pumpWidget(
      const MaterialApp(home: ErrorBoundary(child: SizedBox())),
    );

    // The boundary has installed its own handler by now. Firing it must still
    // reach the one that was there first.
    final installed = FlutterError.onError;
    expect(installed, isNotNull);
    expect(identical(installed, seen.add), isFalse,
        reason: 'the boundary should have wrapped the prior handler');

    installed!(FlutterErrorDetails(exception: StateError('boom')));
    await tester.pump();

    expect(seen, hasLength(1),
        reason: 'the prior handler (main.dart -> Loki) must still run; '
            'replacing it outright is what blinded crash reporting');
    expect(seen.single.exception, isA<StateError>());

    FlutterError.onError = original;
  });

  testWidgets('gives the handler back when it is disposed', (tester) async {
    final original = FlutterError.onError;
    void sentinel(FlutterErrorDetails d) {}
    FlutterError.onError = sentinel;

    await tester.pumpWidget(
      const MaterialApp(home: ErrorBoundary(child: SizedBox())),
    );
    expect(identical(FlutterError.onError, sentinel), isFalse);

    // Unmount it.
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));

    expect(identical(FlutterError.onError, sentinel), isTrue,
        reason: 'a boundary that unmounts must leave the handler as it '
            'found it, or crash reporting stays broken after it is gone');

    FlutterError.onError = original;
  });
}
