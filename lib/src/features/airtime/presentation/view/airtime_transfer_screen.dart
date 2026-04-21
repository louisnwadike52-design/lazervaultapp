import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart'; // ignore: unused_import (used by BlocBuilder)

class AirtimeTransferScreen extends StatefulWidget {
  const AirtimeTransferScreen({super.key});

  @override
  State<AirtimeTransferScreen> createState() => _AirtimeTransferScreenState();
}

class _AirtimeTransferScreenState extends State<AirtimeTransferScreen> {
  final _recipientPhoneController = TextEditingController();
  final _recipientNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _senderPhoneController = TextEditingController();

  NetworkProvider? _selectedProvider;
  bool _phoneValidated = false;
  String? _phoneError;
  /// True while a detection RPC is in flight for the current phone. The
  /// transfer screen always shows the manual grid below, so there's no
  /// "Pick a network" fallback button — when detection returns null the
  /// user just taps a tile.
  bool _isDetectingNetwork = false;
  /// Monotonic id so a fast typist's late callback can't overwrite the
  /// network they're now seeing for a different prefix.
  int _detectionRequestId = 0;

  @override
  void initState() {
    super.initState();
    context.read<AirtimeCubit>().loadNetworkProviders('NG');
  }

  @override
  void dispose() {
    _recipientPhoneController.dispose();
    _recipientNameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _senderPhoneController.dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_amountController.text) ?? 0;

  double get _commission {
    if (_amount <= 0 || _selectedProvider == null) return 0;
    final network = _selectedProvider!.type.name.toUpperCase();
    double rate = 0.05;
    if (network == 'GLO' || network == '9MOBILE') rate = 0.04;
    return (_amount * rate) + 25;
  }

  double get _totalCharged => _amount + _commission;

  bool get _canProceed =>
      _selectedProvider != null &&
      _phoneValidated &&
      _phoneError == null &&
      _amount >= 50 &&
      _amount <= 50000;

  /// Reactive phone-input handler. Re-runs detection on every change so
  /// the Detected Network card updates as the user types, and clears the
  /// stale network when the input shrinks. Mirrors the recipient_input
  /// flow used by buy-for-self.
  void _validatePhone(String phone) {
    final clean = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Clear network state on short / empty input. Without this, deleting
    // back from a complete number would leave the green Detected Network
    // card showing for the previous prefix.
    if (clean.length < 4) {
      setState(() {
        _phoneValidated = false;
        _phoneError = clean.isEmpty ? null : 'Enter 11 digits';
        _selectedProvider = null;
        _isDetectingNetwork = false;
      });
      return;
    }

    final isFullyValid = clean.length == 11 && clean.startsWith('0');
    setState(() {
      _phoneValidated = isFullyValid;
      if (!isFullyValid && clean.length == 11 && !clean.startsWith('0')) {
        _phoneError = 'Nigerian numbers must be 11 digits starting with 0';
      } else if (clean.length < 11) {
        _phoneError = null;
      } else {
        _phoneError = null;
      }
    });

    // Detect on every >=4-digit change so the Detected Network badge
    // tracks live as the user types. Stale callbacks are dropped via the
    // _detectionRequestId guard so a fast backspace doesn't get clobbered.
    _detectNetwork(clean);
  }

  Future<void> _detectNetwork(String phone) async {
    final requestId = ++_detectionRequestId;
    if (!_isDetectingNetwork) {
      setState(() => _isDetectingNetwork = true);
    }

    NetworkProvider? detected;
    try {
      detected = await context
          .read<AirtimeCubit>()
          .detectNetworkFromPhoneNumber(phone, 'NG');
    } catch (_) {
      detected = null;
    }
    if (!mounted) return;
    if (requestId != _detectionRequestId) return; // stale
    setState(() {
      _selectedProvider = detected;
      _isDetectingNetwork = false;
    });
  }

  void _proceedToReview() {
    if (!_canProceed) return;

    Get.toNamed(
      AppRoutes.airtimeTransferReview,
      arguments: {
        'provider': _selectedProvider,
        'recipientPhone': _recipientPhoneController.text.trim(),
        'recipientName': _recipientNameController.text.trim(),
        'senderPhone': _senderPhoneController.text.trim(),
        'amount': _amount,
        'commission': _commission,
        'totalCharged': _totalCharged,
        'transferNote': _noteController.text.trim(),
        'country': const Country(
          id: 'ng',
          name: 'Nigeria',
          code: 'NG',
          dialCode: '+234',
          flag: '🇳🇬',
          currency: 'NGN',
          currencySymbol: '₦',
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _buildRecipientSection(),
                    SizedBox(height: 16.h),
                    // Mirrors the buy-for-self/recipient-input layout: as
                    // soon as the phone number resolves to a known network
                    // (auto-detected from prefix), surface a green-check
                    // "Detected Network" card above the manual selector so
                    // the user can confirm at a glance instead of hunting
                    // through the grid for the highlighted tile.
                    if (_selectedProvider != null)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _buildDetectedNetworkCard(),
                      ),
                    if (_selectedProvider != null) SizedBox(height: 16.h),
                    _buildNetworkSelector(),
                    SizedBox(height: 20.h),
                    _buildAmountSection(),
                    SizedBox(height: 16.h),
                    _buildNoteField(),
                    SizedBox(height: 16.h),
                    if (_amount >= 50) _buildCommissionBreakdown(),
                    SizedBox(height: 24.h),
                    _buildProceedButton(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transfer Airtime',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Send airtime to any number',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient Phone Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
            border: _phoneError != null
                ? Border.all(color: const Color(0xFFEF4444))
                : null,
          ),
          child: TextField(
            controller: _recipientPhoneController,
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            onChanged: _validatePhone,
            decoration: InputDecoration(
              hintText: '08012345678',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 16.sp),
              prefixIcon: Icon(Icons.phone, color: const Color(0xFF9CA3AF), size: 20.sp),
              suffixIcon: _phoneValidated
                  ? Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 20.sp)
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
        if (_phoneError != null) ...[
          SizedBox(height: 4.h),
          Text(
            _phoneError!,
            style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
          ),
        ],
        SizedBox(height: 12.h),
        // Recipient name (optional)
        Text(
          'Recipient Name (optional)',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _recipientNameController,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: 'Enter name',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 16.sp),
              prefixIcon: Icon(Icons.person_outline, color: const Color(0xFF9CA3AF), size: 20.sp),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }

  /// Detected-network confirmation card. Same shape as the equivalent
  /// widget on `recipient_input_screen.dart` so users see identical
  /// feedback whether they're buying for themselves, sending airtime to
  /// a contact, or transferring airtime here.
  Widget _buildDetectedNetworkCard() {
    final provider = _selectedProvider!;
    return Container(
      key: ValueKey('detected-${provider.id}'),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: provider.type.color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                provider.name.isNotEmpty ? provider.name[0] : '?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detected Network',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                Text(
                  provider.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: const Color(0xFF10B981),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Network Provider',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        BlocBuilder<AirtimeCubit, AirtimeState>(
          builder: (context, state) {
            if (state is AirtimeNetworkProvidersLoaded) {
              return _buildProviderGrid(state.providers);
            }
            if (state is AirtimeNetworkProvidersLoading) {
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildProviderGrid(List<NetworkProvider> providers) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: providers.map((provider) {
        final isSelected = _selectedProvider?.id == provider.id;
        return GestureDetector(
          onTap: () => setState(() => _selectedProvider = provider),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: (MediaQuery.of(context).size.width - 70.w) / 2,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? provider.type.color.withValues(alpha: 0.15)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? provider.type.color : const Color(0xFF2D2D2D),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: provider.type.color,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      provider.name.substring(0, 1),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    provider.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: provider.type.color, size: 18.sp),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w700),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 24.sp, fontWeight: FontWeight.w700),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 8.w),
                child: Text(
                  '\u20A6',
                  style: TextStyle(
                    color: const Color(0xFFFB923C),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Quick amount buttons
        Row(
          children: [100, 200, 500, 1000, 5000].map((amt) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: GestureDetector(
                  onTap: () {
                    _amountController.text = amt.toString();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: _amount == amt.toDouble()
                          ? const Color(0xFFFB923C).withValues(alpha: 0.15)
                          : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: _amount == amt.toDouble()
                            ? const Color(0xFFFB923C)
                            : const Color(0xFF2D2D2D),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\u20A6$amt',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: _amount == amt.toDouble()
                              ? const Color(0xFFFB923C)
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_amount > 0 && _amount < 50) ...[
          SizedBox(height: 4.h),
          Text('Minimum transfer is \u20A650',
              style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp)),
        ],
        if (_amount > 50000) ...[
          SizedBox(height: 4.h),
          Text('Maximum transfer is \u20A650,000',
              style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp)),
        ],
      ],
    );
  }

  Widget _buildNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transfer Note (optional)',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _noteController,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            maxLines: 2,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'e.g. For airtime top-up',
              hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 14.sp),
              counterStyle: TextStyle(color: const Color(0xFF6B7280)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommissionBreakdown() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fee Breakdown',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          _feeRow('Airtime to deliver', '\u20A6${_amount.toStringAsFixed(0)}'),
          SizedBox(height: 8.h),
          _feeRow('Commission', '\u20A6${_commission.toStringAsFixed(2)}', valueColor: const Color(0xFFFB923C)),
          SizedBox(height: 8.h),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 8.h),
          _feeRow('Total charge', '\u20A6${_totalCharged.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _feeRow(String label, String value, {Color? valueColor, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? (isTotal ? Colors.white : Colors.white.withValues(alpha: 0.8)),
          ),
        ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _canProceed ? _proceedToReview : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFB923C),
          disabledBackgroundColor: const Color(0xFF2D2D2D),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Review Transfer',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
