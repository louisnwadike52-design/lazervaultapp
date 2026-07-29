import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/currency_exchange/domain/repositories/i_exchange_repository.dart';

/// The confirmed conversion the payer agreed to when paying a tagged invoice
/// from an account whose currency differs from the invoice currency.
class InvoiceFxQuote {
  /// Live rate: 1 [fromCurrency] = [rate] [toCurrency].
  final double rate;

  /// The amount debited from the payer's account, in [toCurrency].
  final double convertedAmount;

  /// The invoice currency (what the invoice is denominated in).
  final String fromCurrency;

  /// The payer's account currency (what is actually debited).
  final String toCurrency;

  /// The invoice amount, in [fromCurrency].
  final double fromAmount;

  const InvoiceFxQuote({
    required this.rate,
    required this.convertedAmount,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromAmount,
  });
}

/// Bottom sheet shown BEFORE the PIN step when the invoice currency differs
/// from the payer's selected account currency. It fetches a live rate from
/// exchange-service, shows "X FROM = Y TO at rate R", and returns the confirmed
/// [InvoiceFxQuote] (or null if the payer cancels / the rate can't be fetched).
///
/// The backend independently re-resolves the rate at settlement time — this
/// quote is for informed consent + receipt display, never the source of truth
/// for the money move.
class InvoiceFxConfirmSheet extends StatefulWidget {
  final String fromCurrency;
  final String toCurrency;
  final double fromAmount;
  final double availableBalance;

  const InvoiceFxConfirmSheet({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromAmount,
    required this.availableBalance,
  });

  /// Presents the sheet and resolves to the confirmed quote, or null when the
  /// payer cancels or the rate could not be loaded.
  static Future<InvoiceFxQuote?> show(
    BuildContext context, {
    required String fromCurrency,
    required String toCurrency,
    required double fromAmount,
    required double availableBalance,
  }) {
    return showModalBottomSheet<InvoiceFxQuote>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => InvoiceFxConfirmSheet(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        fromAmount: fromAmount,
        availableBalance: availableBalance,
      ),
    );
  }

  @override
  State<InvoiceFxConfirmSheet> createState() => _InvoiceFxConfirmSheetState();
}

class _InvoiceFxConfirmSheetState extends State<InvoiceFxConfirmSheet> {
  bool _loading = true;
  String? _error;
  ExchangeRate? _rate;

  @override
  void initState() {
    super.initState();
    _fetchRate();
  }

  Future<void> _fetchRate() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await GetIt.I<IExchangeRepository>().getExchangeRate(
      fromCurrency: widget.fromCurrency,
      toCurrency: widget.toCurrency,
      amount: widget.fromAmount,
    );
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        _loading = false;
        _error = failure.message;
      }),
      (rate) => setState(() {
        _loading = false;
        _rate = rate;
      }),
    );
  }

  String _symbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'ZAR':
        return 'R';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'INR':
        return '₹';
      case 'JPY':
        return '¥';
      case 'USD':
        return '\$';
      default:
        return '';
    }
  }

  String _fmt(String currency, double amount) =>
      '${_symbol(currency)}${NumberFormat('#,##0.00').format(amount)}';

  @override
  Widget build(BuildContext context) {
    final rate = _rate;
    final converted =
        rate != null ? rate.calculateToAmount(widget.fromAmount) : 0.0;
    final insufficient = rate != null && converted > widget.availableBalance;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.currency_exchange,
                    color: const Color(0xFF3B82F6), size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Currency conversion',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'This invoice is in ${widget.fromCurrency}. You are paying from a ${widget.toCurrency} account.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          if (_loading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 28.h),
              child: LazerVaultLoader.small(),
            )
          else if (_error != null)
            _buildError()
          else
            _buildQuote(converted, insufficient),
          SizedBox(height: 20.h),
          _buildActions(rate, converted, insufficient),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Column(
      children: [
        Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 32.sp),
        SizedBox(height: 12.h),
        Text(
          _error ?? 'Could not load the exchange rate',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 12.h),
        TextButton(
          onPressed: _fetchRate,
          child: Text(
            'Retry',
            style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuote(double converted, bool insufficient) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              _row('You pay', _fmt(widget.toCurrency, converted),
                  highlight: true),
              SizedBox(height: 12.h),
              _row('Invoice amount',
                  _fmt(widget.fromCurrency, widget.fromAmount)),
              SizedBox(height: 12.h),
              _row('Exchange rate', _rate?.formatForDisplay() ?? '--'),
            ],
          ),
        ),
        if (insufficient) ...[
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: const Color(0xFFEF4444), size: 16.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Insufficient balance in your ${widget.toCurrency} account for this conversion.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _row(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: highlight ? 14.sp : 13.sp,
            fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: highlight ? const Color(0xFF3B82F6) : Colors.white,
            fontSize: highlight ? 18.sp : 13.sp,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(ExchangeRate? rate, double converted, bool insufficient) {
    final canConfirm = rate != null && !insufficient && converted > 0;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2D2D2D)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: canConfirm
                ? () => Navigator.of(context).pop(
                      InvoiceFxQuote(
                        rate: rate.rate,
                        convertedAmount: converted,
                        fromCurrency: widget.fromCurrency,
                        toCurrency: widget.toCurrency,
                        fromAmount: widget.fromAmount,
                      ),
                    )
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              disabledBackgroundColor:
                  const Color(0xFF3B82F6).withValues(alpha: 0.3),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Confirm & continue',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
