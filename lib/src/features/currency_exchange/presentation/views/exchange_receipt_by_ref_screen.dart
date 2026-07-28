import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';
import 'exchange_receipt_screen.dart';

/// Deeplink target for the chat/voice "View receipt" action
/// (`/exchange/receipt/:id`). Unlike the in-app flow, a deeplink carries no
/// transaction object — only the id in the path — so this screen fetches the
/// full [CurrencyTransaction] via `GetTransactionStatus`, then renders the
/// shared [ExchangeReceiptScreen]. Async exchange rows can be briefly
/// not-found until the Kafka consumer replays the record, so a bounded retry
/// covers that window without an infinite loop.
class ExchangeReceiptByRefScreen extends StatefulWidget {
  final String reference;

  const ExchangeReceiptByRefScreen({super.key, required this.reference});

  @override
  State<ExchangeReceiptByRefScreen> createState() =>
      _ExchangeReceiptByRefScreenState();
}

class _ExchangeReceiptByRefScreenState
    extends State<ExchangeReceiptByRefScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  // gRPC NotFound; bounded so we never loop forever on a genuinely missing id.
  static const int _maxAttempts = 4;
  static const Duration _retryDelay = Duration(seconds: 2);

  CurrencyTransaction? _tx;
  String? _error;
  int _attempt = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _error = null;
    });
    final ref = widget.reference.trim();
    if (ref.isEmpty) {
      setState(() => _error = 'Missing receipt reference.');
      return;
    }
    _attempt++;
    final result = await serviceLocator<IExchangeRepository>()
        .getTransactionStatus(transactionId: ref);
    if (!mounted) return;
    result.fold(
      (failure) async {
        // NotFound (gRPC code 5) on an async row that hasn't landed yet —
        // retry a few times before surfacing an error.
        final isNotFound = failure.statusCode == 5 ||
            failure.message.toLowerCase().contains('not found');
        if (isNotFound && _attempt < _maxAttempts) {
          await Future.delayed(_retryDelay);
          if (mounted) _load();
        } else {
          setState(() => _error = failure.message);
        }
      },
      (tx) => setState(() => _tx = tx),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tx = _tx;
    if (tx != null) {
      return ExchangeReceiptScreen(transaction: tx);
    }
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Center(
          child: _error == null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LazerVaultLoader(),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading receipt…',
                      style: TextStyle(
                          color: _textSecondary, fontSize: 14.sp),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.receipt_long_outlined,
                          color: _textSecondary, size: 48.sp),
                      SizedBox(height: 16.h),
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 15.sp),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              _attempt = 0;
                              _load();
                            },
                            child: const Text('Retry'),
                          ),
                          SizedBox(width: 16.w),
                          TextButton(
                            onPressed: () =>
                                Get.offAllNamed(AppRoutes.exchangeHome),
                            child: Text(
                              'Back to exchange',
                              style: TextStyle(color: _textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
