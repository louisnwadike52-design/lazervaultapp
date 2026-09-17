import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/card_acceptance/data/datasources/card_acceptance_data_source.dart';
import 'package:lazervault/src/features/card_acceptance/domain/entities/card_charge_entity.dart';
import 'package:lazervault/src/features/card_acceptance/services/card_reader.dart';

/// Taking a card payment with the merchant's phone.
///
/// The screen is deliberately one column of decisions: how much, then tap, then
/// what happened. A merchant runs this with a customer standing in front of
/// them, so anything that is not the amount, the state of the sale, or what to
/// do next does not belong on it.
class CardAcceptanceScreen extends StatefulWidget {
  const CardAcceptanceScreen({super.key});

  @override
  State<CardAcceptanceScreen> createState() => _CardAcceptanceScreenState();
}

class _CardAcceptanceScreenState extends State<CardAcceptanceScreen> {
  static const _bg = Color(0xFF121212);
  static const _card = Color(0xFF1C1C1E);
  static const _border = Color(0xFF2A2A2C);
  static const _accent = Color(0xFF0F9D58);
  static const _muted = Color(0xFF9CA3AF);
  static const _danger = Color(0xFFEF4444);

  final _amountController = TextEditingController();
  late final CardAcceptanceDataSource _data;
  late final CardReader _reader;

  CardAcceptanceStatusEntity? _status;
  CardReaderAvailability? _readerState;
  CardChargeEntity? _charge;

  bool _loading = true;
  bool _charging = false;
  String? _error;

  /// Polls a pending sale until it reaches a terminal state.
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _data = serviceLocator<CardAcceptanceDataSource>();
    // Until a certified SDK is integrated this reports the capability as
    // absent, which the UI states plainly. See CardReader.
    _reader = const UnavailableCardReader();
    _load();
  }

  @override
  void dispose() {
    _poll?.cancel();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      // Server first: it decides whether this market has a certified rail at
      // all. Asking the device before asking the server would offer a reader on
      // a phone in a country we cannot settle in.
      final status = await _data.status();
      final reader = await _reader.availability();
      if (!mounted) return;
      setState(() {
        _status = status;
        _readerState = reader;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = _friendly(e);
        _loading = false;
      });
    }
  }

  int? get _amountMinor {
    final raw = _amountController.text.trim().replaceAll(',', '');
    if (raw.isEmpty) return null;
    final major = double.tryParse(raw);
    if (major == null || major <= 0) return null;
    // Rounded, not truncated: 35.99 * 100 is 3598.9999... in binary floating
    // point, and truncating charges the customer a kobo less than the receipt.
    return (major * 100).round();
  }

  String _money(int minor, [String currency = 'NGN']) {
    final symbol = currency == 'NGN' ? '₦' : '$currency ';
    return NumberFormat.currency(symbol: symbol, decimalDigits: 2)
        .format(minor / 100.0);
  }

  Future<void> _takePayment() async {
    final minor = _amountMinor;
    if (minor == null || _charging) return;

    setState(() {
      _charging = true;
      _error = null;
      _charge = null;
    });

    // ONE reference for this sale, generated before the card is read. The
    // server is idempotent on it, which is what stops a retry on a bad
    // connection from charging the customer twice for one tap.
    final reference = 'POS-${const Uuid().v4()}';
    final currency = 'NGN';

    try {
      final read = await _reader.readCard(
        amountMinor: minor,
        currency: currency,
        reference: reference,
      );
      if (!mounted) return;

      if (read.cancelled) {
        // Backing out is not a failure; the UI should not apologise for it.
        setState(() => _charging = false);
        return;
      }
      if (!read.success) {
        setState(() {
          _charging = false;
          _error = read.error.isEmpty ? 'Could not read the card.' : read.error;
        });
        return;
      }

      final charge = await _data.createCharge(
        reference: reference,
        amountMinor: minor,
        currency: currency,
        devicePayload: read.encryptedPayload,
      );
      if (!mounted) return;
      setState(() {
        _charge = charge;
        _charging = false;
      });
      // A sale can stay pending while the provider finishes; the webhook
      // usually resolves it first, and this is the backstop the merchant sees.
      if (!charge.isTerminal) _startPolling(reference);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _charging = false;
        _error = _friendly(e);
      });
    }
  }

  void _startPolling(String reference) {
    _poll?.cancel();
    _poll = Timer.periodic(const Duration(seconds: 3), (t) async {
      if (!mounted) {
        t.cancel();
        return;
      }
      try {
        final latest = await _data.chargeStatus(reference);
        if (!mounted) return;
        setState(() => _charge = latest);
        if (latest.isTerminal) t.cancel();
      } catch (_) {
        // Keep polling: a transient failure mid-sale must not strand the
        // merchant on a spinner with no resolution.
      }
    });
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst('Exception: ', '').trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        title: Text('Accept Cards',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: LazerVaultLoader())
            : SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_unavailableReason != null) _unavailableCard(),
                    if (_unavailableReason == null) ...[
                      _amountField(),
                      SizedBox(height: 20.h),
                      _tapButton(),
                    ],
                    if (_error != null) ...[
                      SizedBox(height: 16.h),
                      _errorCard(_error!),
                    ],
                    if (_charge != null) ...[
                      SizedBox(height: 20.h),
                      _resultCard(_charge!),
                    ],
                  ],
                ),
              ),
      ),
    );
  }

  /// The single reason card payments cannot be taken right now, or null.
  ///
  /// Server before device: a market with no certified rail is a harder stop
  /// than a phone without a reader, and showing the device problem first would
  /// send the merchant chasing a fix that changes nothing.
  String? get _unavailableReason {
    final s = _status;
    if (s != null && !s.available) {
      return s.unavailableReason.isEmpty
          ? 'Card payments aren\'t available on your account yet.'
          : s.unavailableReason;
    }
    final r = _readerState;
    if (r != null && !r.available) {
      return r.reason;
    }
    return null;
  }

  Widget _unavailableCard() => Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: _border),
        ),
        child: Column(
          children: [
            Icon(Icons.credit_card_off_rounded, color: _muted, size: 34.sp),
            SizedBox(height: 12.h),
            Text('Card payments aren\'t available yet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text(_unavailableReason!,
                textAlign: TextAlign.center,
                style: TextStyle(color: _muted, fontSize: 13.sp, height: 1.5)),
            SizedBox(height: 14.h),
            TextButton(
              onPressed: _load,
              child:
                  const Text('Check again', style: TextStyle(color: _accent)),
            ),
          ],
        ),
      );

  Widget _amountField() => Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: _border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount to charge',
                style: TextStyle(color: _muted, fontSize: 12.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixText: '₦ ',
                prefixStyle: TextStyle(
                    color: _accent,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
                hintText: '0.00',
                hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.25),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none,
              ),
            ),
            if (_status?.activeProvider.isNotEmpty ?? false)
              Text('via ${_status!.activeProvider}',
                  style: TextStyle(color: _muted, fontSize: 11.sp)),
          ],
        ),
      );

  Widget _tapButton() {
    final ready = _amountMinor != null && !_charging;
    return SizedBox(
      height: 56.h,
      child: ElevatedButton.icon(
        onPressed: ready ? _takePayment : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          disabledBackgroundColor: _accent.withValues(alpha: 0.35),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
        icon: _charging
            ? SizedBox(
                height: 18.h,
                width: 18.h,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.contactless_rounded, color: Colors.white),
        label: Text(
          _charging ? 'Waiting for the card…' : 'Tap card to pay',
          style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _errorCard(String message) => Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _danger.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _danger.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: _danger, size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(message,
                  style: TextStyle(color: _danger, fontSize: 13.sp)),
            ),
          ],
        ),
      );

  Widget _resultCard(CardChargeEntity c) {
    final colour = c.isSucceeded
        ? _accent
        : c.isFailed
            ? _danger
            : _muted;
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colour.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Icon(
            c.isSucceeded
                ? Icons.check_circle_rounded
                : c.isFailed
                    ? Icons.cancel_rounded
                    : Icons.hourglass_top_rounded,
            color: colour,
            size: 38.sp,
          ),
          SizedBox(height: 10.h),
          Text(_money(c.amountMinor, c.currency),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 6.h),
          Text(
            c.isSucceeded
                // "Approved" is not "paid out" — saying so here avoids the
                // merchant asking later why the money has not landed.
                ? (c.awaitingSettlement
                    ? 'Approved — on its way to your wallet'
                    : 'Approved and settled')
                : c.isFailed
                    ? (c.failureReason.isEmpty
                        ? 'Declined — ask for another card'
                        : c.failureReason)
                    : 'Waiting for the payment to complete',
            textAlign: TextAlign.center,
            style: TextStyle(color: colour, fontSize: 13.sp),
          ),
          if (c.maskedCard.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(c.maskedCard,
                style: TextStyle(color: _muted, fontSize: 12.sp)),
          ],
          if (c.feeMinor > 0) ...[
            SizedBox(height: 10.h),
            Text(
                'You receive ${_money(c.netMinor, c.currency)} '
                'after a ${_money(c.feeMinor, c.currency)} fee',
                textAlign: TextAlign.center,
                style: TextStyle(color: _muted, fontSize: 12.sp)),
          ],
          SizedBox(height: 14.h),
          TextButton(
            onPressed: () => setState(() {
              _charge = null;
              _amountController.clear();
              _poll?.cancel();
            }),
            child: const Text('New sale', style: TextStyle(color: _accent)),
          ),
        ],
      ),
    );
  }
}
