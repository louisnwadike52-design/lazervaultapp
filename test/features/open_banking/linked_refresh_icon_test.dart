import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/open_banking/presentation/mixins/linked_balance_refresh_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

import '../chat_pin_fakes.dart';

/// `linkedRefreshIcon` is the ONE refresh glyph every linked-bank surface
/// renders. It must flip to a disabled spinner the moment an account's id
/// enters `linkedRefreshPending` (fee quote / PIN sheet in flight) and back to
/// a tappable glyph when it leaves — for THAT account only.
class _Host extends StatefulWidget {
  const _Host({super.key, required this.account, required this.onPressed});
  final LinkedBankAccount account;
  final VoidCallback onPressed;

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host>
    with TransactionPinMixin, LinkedBalanceRefreshMixin {
  @override
  ITransactionPinService get transactionPinService => FakePinService();

  @override
  Widget build(BuildContext context) {
    return linkedRefreshIcon(
      widget.account,
      onPressed: widget.onPressed,
      size: 20,
      color: Colors.white,
    );
  }
}

LinkedBankAccount _account(String id) => LinkedBankAccount(
      id: id,
      userId: 'u1',
      provider: 'mono',
      bankName: 'Test Bank',
      bankCode: '000',
      accountNumber: '****1234',
      accountName: 'Test User',
      accountType: 'savings',
      currency: 'NGN',
      lastKnownBalance: 0,
      status: LinkedAccountStatus.active,
      isDefault: false,
      isVerified: true,
      linkedAt: DateTime(2026, 1, 1),
    );

void main() {
  testWidgets('shows a glyph at rest, a disabled spinner while pending',
      (tester) async {
    final key = GlobalKey<_HostState>();
    var taps = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: _Host(
            key: key, account: _account('acc-1'), onPressed: () => taps++),
      ),
    ));

    // At rest: refresh glyph, tappable.
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.tap(find.byType(IconButton));
    expect(taps, 1);

    // Pending for THIS account: spinner, tap ignored.
    key.currentState!.linkedRefreshPending.value = {'acc-1'};
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(Icons.refresh_rounded), findsNothing);
    expect(
        tester.widget<IconButton>(find.byType(IconButton)).onPressed, isNull);
    await tester.tap(find.byType(IconButton), warnIfMissed: false);
    expect(taps, 1);

    // Pending for ANOTHER account only: this icon is unaffected.
    key.currentState!.linkedRefreshPending.value = {'acc-2'};
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);

    // Cleared: glyph is back and tappable again.
    key.currentState!.linkedRefreshPending.value = const {};
    await tester.pump();
    await tester.tap(find.byType(IconButton));
    expect(taps, 2);
  });

  testWidgets('isLinkedRefreshPending tracks the notifier', (tester) async {
    final key = GlobalKey<_HostState>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: _Host(key: key, account: _account('acc-1'), onPressed: () {}),
      ),
    ));
    expect(key.currentState!.isLinkedRefreshPending('acc-1'), isFalse);
    key.currentState!.linkedRefreshPending.value = {'acc-1'};
    expect(key.currentState!.isLinkedRefreshPending('acc-1'), isTrue);
    expect(key.currentState!.isLinkedRefreshPending('acc-2'), isFalse);
  });
}
