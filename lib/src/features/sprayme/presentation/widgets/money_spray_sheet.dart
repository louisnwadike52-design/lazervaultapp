import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet for setting up money spraying.
/// User selects total amount to spray and denomination per tap.
class MoneySpraySheet extends StatefulWidget {
  final double walletBalance; // major units
  final String currency;
  final void Function(int totalAmountKobo, int denominationKobo) onConfirm;

  const MoneySpraySheet({
    super.key,
    required this.walletBalance,
    required this.currency,
    required this.onConfirm,
  });

  @override
  State<MoneySpraySheet> createState() => _MoneySpraySheetState();
}

class _MoneySpraySheetState extends State<MoneySpraySheet> {
  int? _selectedAmount; // major units
  int? _selectedDenomination; // major units
  bool _isCustomAmount = false;
  final _customAmountController = TextEditingController();

  // Preset amounts (in major units)
  static const _amounts = [1000, 2000, 5000, 10000, 20000, 50000, 100000];

  // Denomination options (in major units)
  static const _denominations = [50, 100, 200, 500, 1000, 2000, 5000];

  int get _tapCount {
    if (_selectedAmount == null || _selectedDenomination == null || _selectedDenomination == 0) return 0;
    return _selectedAmount! ~/ _selectedDenomination!;
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LazerSpray Money',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Choose amount and denomination, then tap to spray!',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      '${widget.currency} ${widget.walletBalance.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: const Color(0xFFFFD700),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Total amount selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'How much to spray?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 44.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _amounts.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final amount = _amounts[index];
                  final isSelected = _selectedAmount == amount;
                  final canAfford = widget.walletBalance >= amount;
                  return GestureDetector(
                    onTap: () {
                      if (!canAfford) return;
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedAmount = isSelected ? null : amount;
                        // Reset denomination if it exceeds new amount
                        if (_selectedDenomination != null &&
                            _selectedAmount != null &&
                            _selectedDenomination! > _selectedAmount!) {
                          _selectedDenomination = null;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF10B981)
                            : const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF10B981)
                              : const Color(0xFF3D3D3D),
                        ),
                      ),
                      child: Opacity(
                        opacity: canAfford ? 1.0 : 0.4,
                        child: Text(
                          '${widget.currency} ${_formatAmount(amount)}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),

            // Custom amount toggle + input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _isCustomAmount = !_isCustomAmount;
                        if (!_isCustomAmount) {
                          _customAmountController.clear();
                        } else {
                          // Deselect preset
                          _selectedAmount = null;
                        }
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isCustomAmount ? Icons.check_box : Icons.check_box_outline_blank,
                          color: const Color(0xFF10B981),
                          size: 20.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Enter custom amount',
                          style: TextStyle(
                            color: _isCustomAmount ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isCustomAmount) ...[
                    SizedBox(height: 8.h),
                    Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
                      ),
                      child: TextField(
                        controller: _customAmountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintText: 'Amount in ${widget.currency}',
                          hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 14.sp),
                          prefixText: '${widget.currency} ',
                          prefixStyle: TextStyle(color: const Color(0xFF10B981), fontSize: 14.sp, fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        ),
                        onChanged: (value) {
                          final amount = int.tryParse(value);
                          setState(() {
                            if (amount != null && amount > 0 && amount <= widget.walletBalance) {
                              _selectedAmount = amount;
                            } else {
                              _selectedAmount = null;
                            }
                            // Reset denomination if it exceeds new amount
                            if (_selectedDenomination != null &&
                                _selectedAmount != null &&
                                _selectedDenomination! > _selectedAmount!) {
                              _selectedDenomination = null;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Denomination selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Note denomination (per tap)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Each tap sprays one note of this amount',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _denominations.where((d) {
                  return _selectedAmount == null || d <= _selectedAmount!;
                }).map((denom) {
                  final isSelected = _selectedDenomination == denom;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedDenomination = isSelected ? null : denom;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF3D3D3D),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${widget.currency} $denom',
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.h),

            // Summary
            if (_selectedAmount != null && _selectedDenomination != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_tapCount taps available',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${widget.currency} $_selectedDenomination per tap',
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${widget.currency} ${_formatAmount(_selectedAmount!)}',
                            style: TextStyle(
                              color: const Color(0xFF10B981),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Show remainder warning when amount is not evenly divisible
                      if (_selectedAmount! % _selectedDenomination! != 0) ...[
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: const Color(0xFFFB923C), size: 14.sp),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  '${widget.currency} ${_selectedAmount! % _selectedDenomination!} will remain unsprayed',
                                  style: TextStyle(color: const Color(0xFFFB923C), fontSize: 11.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
            // Insufficient balance message when all presets disabled
            if (_selectedAmount == null && !_isCustomAmount && widget.walletBalance < _amounts.first)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: const Color(0xFFFB923C), size: 18.sp),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Wallet balance too low. Fund your wallet to start spraying.',
                          style: TextStyle(color: const Color(0xFFFB923C), fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 16.h),

            // Confirm button
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedAmount != null && _selectedDenomination != null && _tapCount > 0
                      ? () {
                          HapticFeedback.mediumImpact();
                          // Only spray the amount that divides evenly
                          final effectiveAmount = _tapCount * _selectedDenomination!;
                          widget.onConfirm(
                            effectiveAmount * 100, // to kobo
                            _selectedDenomination! * 100, // to kobo
                          );
                          Navigator.of(context).pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    disabledBackgroundColor: const Color(0xFF2D2D2D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: Text(
                    'Start Spraying',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(int amount) {
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    }
    return amount.toString();
  }
}
