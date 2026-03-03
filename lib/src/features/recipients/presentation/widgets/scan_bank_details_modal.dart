import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart';

const Color _purple = Color.fromARGB(255, 78, 3, 208);

// ── Action types returned from the sheet ────────────────────────────────────

enum ScanActionType { bankTransfer, internalTransfer, phoneTransfer, retryCapture }

class ScanAction {
  final ScanActionType type;
  final String? accountNumber;
  final String? accountName;
  final String? bankName;
  final String? bankCode;
  final String? username;
  final String? phoneNumber;

  const ScanAction({
    required this.type,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.bankCode,
    this.username,
    this.phoneNumber,
  });
}

// ── SmartScanResultSheet ────────────────────────────────────────────────────

class SmartScanResultSheet extends StatefulWidget {
  final SmartScanResult scanResult;
  final String country;

  const SmartScanResultSheet({
    super.key,
    required this.scanResult,
    this.country = 'NG',
  });

  /// Show the sheet. Returns a [ScanAction] or null if dismissed.
  static Future<ScanAction?> show(
    BuildContext context, {
    required SmartScanResult scanResult,
    String country = 'NG',
  }) {
    return showModalBottomSheet<ScanAction>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SmartScanResultSheet(
        scanResult: scanResult,
        country: country,
      ),
    );
  }

  @override
  State<SmartScanResultSheet> createState() => _SmartScanResultSheetState();
}

class _SmartScanResultSheetState extends State<SmartScanResultSheet> {
  late TextEditingController _accountNumberController;
  String? _selectedBankCode;
  String? _selectedBankName;
  bool _isVerifying = false;

  // For ambiguous: user's chosen resolution
  String? _disambiguatedType;

  // 1.5: Track whether AccountVerificationCubit is available in the tree
  bool _hasVerificationCubit = false;

  @override
  void initState() {
    super.initState();
    _accountNumberController = TextEditingController(
      text: widget.scanResult.accountNumber ?? '',
    );
    _selectedBankName = widget.scanResult.bankName;
    _selectedBankCode = widget.scanResult.bankCode;

    // Try to resolve bank code from name if not provided
    if (_selectedBankCode == null && _selectedBankName != null) {
      _resolveBankCode(_selectedBankName!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 1.5: Probe for AccountVerificationCubit in widget tree
    try {
      context.read<AccountVerificationCubit>();
      _hasVerificationCubit = true;
    } catch (_) {
      _hasVerificationCubit = false;
    }
  }

  void _resolveBankCode(String bankName) {
    final banks = BanksData.getBanksForCountry(widget.country);
    final lower = bankName.toLowerCase();
    for (final bank in banks) {
      if (bank['name']!.toLowerCase().contains(lower) ||
          lower.contains(bank['name']!.toLowerCase())) {
        setState(() {
          _selectedBankCode = bank['code'];
          _selectedBankName = bank['name'];
        });
        return;
      }
    }
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  /// The resolved type — either user's disambiguation choice, or the original.
  /// 1.4: Only allow disambiguation to non-ambiguous types to prevent recursion.
  String get _effectiveType {
    final dt = _disambiguatedType;
    if (dt != null && dt != 'ambiguous') return dt;
    return widget.scanResult.extractionType;
  }

  @override
  Widget build(BuildContext context) {
    // 1.5: Conditionally wrap with BlocListener only if cubit is available
    Widget content = Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHandle(),
            SizedBox(height: 16.h),
            _buildHeader(),
            SizedBox(height: 24.h),
            Flexible(
              child: SingleChildScrollView(
                child: _buildBody(),
              ),
            ),
            SizedBox(height: 16.h),
            _buildActions(),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
          ],
        ),
      ),
    );

    if (_hasVerificationCubit) {
      return BlocListener<AccountVerificationCubit, AccountVerificationState>(
        listener: _onVerificationState,
        child: content,
      );
    }
    return content;
  }

  void _onVerificationState(BuildContext context, AccountVerificationState state) {
    if (state is AccountVerificationLoading) {
      setState(() => _isVerifying = true);
    } else if (state is AccountVerificationSuccess) {
      setState(() => _isVerifying = false);
      Navigator.pop(
        context,
        ScanAction(
          type: ScanActionType.bankTransfer,
          accountNumber: state.accountNumber,
          accountName: state.accountName,
          bankName: state.bankName,
          bankCode: state.bankCode,
        ),
      );
    } else if (state is AccountVerificationFailure) {
      setState(() => _isVerifying = false);
      Get.snackbar(
        'Verification Failed',
        state.userMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  // ── Handle bar ──────────────────────────────────────────────────────────

  Widget _buildHandle() => Center(
        child: Container(
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      );

  // ── Header ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    final (icon, title, subtitle) = switch (_effectiveType) {
      'bank_details' => (
        Icons.account_balance_outlined,
        'Bank Details Found',
        'Review and verify the extracted details',
      ),
      'internal_user' => (
        Icons.person_outline,
        'LazerVault User Found',
        'We detected a LazerVault username',
      ),
      'phone_number' => (
        Icons.phone_outlined,
        'Phone Number Found',
        'We detected a phone number',
      ),
      'ambiguous' => (
        Icons.help_outline,
        'What Did We Find?',
        widget.scanResult.disambiguationHint ?? 'Please help us identify this',
      ),
      _ => (
        Icons.image_not_supported_outlined,
        'No Details Found',
        'Could not find payment details in this image',
      ),
    };

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: _purple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: _purple, size: 24.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
              ),
            ],
          ),
        ),
        _buildConfidenceBadge(widget.scanResult.confidence),
      ],
    );
  }

  // ── Body: type-specific content ─────────────────────────────────────────

  Widget _buildBody() => switch (_effectiveType) {
        'bank_details' => _buildBankDetailsBody(),
        'internal_user' => _buildInternalUserBody(),
        'phone_number' => _buildPhoneNumberBody(),
        'ambiguous' => _buildAmbiguousBody(),
        _ => _buildNoDataBody(),
      };

  // ── Bank Details ────────────────────────────────────────────────────────

  Widget _buildBankDetailsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Account Number'),
        SizedBox(height: 8.h),
        TextField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          maxLength: 10,
          decoration: _inputDecoration(
            hint: 'Enter 10-digit account number',
            icon: Icons.numbers_outlined,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (_) => setState(() {}), // Rebuild to update button state
        ),
        SizedBox(height: 16.h),
        _buildFieldLabel('Bank'),
        SizedBox(height: 8.h),
        _buildBankSelector(),
        // 1.1: Show hint when account number is wrong length
        if (_accountNumberController.text.isNotEmpty &&
            _accountNumberController.text.length != 10) ...[
          SizedBox(height: 8.h),
          Text(
            'Account number must be 10 digits (currently ${_accountNumberController.text.length})',
            style: TextStyle(color: Colors.orange[700], fontSize: 12.sp),
          ),
        ],
        SizedBox(height: 16.h),
        if (widget.scanResult.accountName != null &&
            widget.scanResult.accountName!.isNotEmpty) ...[
          _buildFieldLabel('Account Name (from scan)'),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.person_outline, color: Colors.grey[600], size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.scanResult.accountName!,
                    style: TextStyle(color: Colors.black87, fontSize: 15.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ── Internal User ───────────────────────────────────────────────────────

  Widget _buildInternalUserBody() {
    final username = widget.scanResult.username;
    // 1.3: Handle null/empty username gracefully
    final hasUsername = username != null && username.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: _purple.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: _purple.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: _purple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: _purple, size: 28.sp),
              ),
              SizedBox(height: 12.h),
              if (hasUsername)
                Text(
                  '@$username',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else
                Text(
                  'Username not detected',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (widget.scanResult.displayName != null &&
                  widget.scanResult.displayName!.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  widget.scanResult.displayName!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                ),
              ],
            ],
          ),
        ),
        if (!hasUsername) ...[
          SizedBox(height: 12.h),
          Text(
            'The scan detected a LazerVault reference but could not read the username clearly. Try again with a clearer image.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ],
    );
  }

  // ── Phone Number ────────────────────────────────────────────────────────

  Widget _buildPhoneNumberBody() {
    final phone = widget.scanResult.phoneNumber;
    final carrier = widget.scanResult.phoneCarrier;
    // 1.2: Handle null/empty phone number
    final hasPhone = phone != null && phone.isNotEmpty;
    final isPhoneBank =
        carrier != null && ['opay', 'palmpay'].contains(carrier.toLowerCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.phone, color: Colors.blue, size: 28.sp),
              ),
              SizedBox(height: 12.h),
              if (hasPhone)
                Text(
                  phone,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                )
              else
                Text(
                  'Phone number not detected',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (carrier != null && carrier.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    carrier.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (isPhoneBank && hasPhone) ...[
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange[700], size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'This could be an ${carrier.substring(0, 1).toUpperCase()}${carrier.substring(1)} account number',
                    style: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (!hasPhone) ...[
          SizedBox(height: 12.h),
          Text(
            'Could not read the phone number clearly. Try again with a clearer image.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ],
    );
  }

  // ── Ambiguous ───────────────────────────────────────────────────────────

  Widget _buildAmbiguousBody() {
    final types = widget.scanResult.possibleTypes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.scanResult.disambiguationHint != null &&
            widget.scanResult.disambiguationHint!.isNotEmpty) ...[
          Text(
            widget.scanResult.disambiguationHint!,
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
        ],
        Text(
          'What is this?',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (types.contains('bank_details'))
          _buildDisambiguationOption(
            'bank_details',
            'Bank Account Number',
            Icons.account_balance_outlined,
          ),
        if (types.contains('phone_number'))
          _buildDisambiguationOption(
            'phone_number',
            'Phone Number (OPay / PalmPay)',
            Icons.phone_outlined,
          ),
        if (types.contains('internal_user'))
          _buildDisambiguationOption(
            'internal_user',
            'LazerVault Username',
            Icons.person_outline,
          ),
        // Fallback if possibleTypes is empty (shouldn't happen but handle it)
        if (types.isEmpty) ...[
          Text(
            'We found something but could not classify it. Please try again.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ],
    );
  }

  Widget _buildDisambiguationOption(String type, String label, IconData icon) {
    final selected = _disambiguatedType == type;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _disambiguatedType = type;
            // 1.1: When switching to bank_details, pre-fill account number
            // from whatever data we have (phone number or raw extracted number)
            if (type == 'bank_details') {
              final existing = _accountNumberController.text;
              if (existing.isEmpty) {
                // Try phone number as fallback
                final phone = widget.scanResult.phoneNumber ?? '';
                final local = phone.startsWith('234')
                    ? '0${phone.substring(3)}'
                    : phone;
                if (local.length == 10 &&
                    RegExp(r'^\d+$').hasMatch(local)) {
                  _accountNumberController.text = local;
                }
              }
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: selected ? _purple.withValues(alpha: 0.05) : Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? _purple : Colors.grey[200]!,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: selected ? _purple : Colors.grey[600], size: 22.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? _purple : Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, color: _purple, size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }

  // ── No Data ─────────────────────────────────────────────────────────────

  Widget _buildNoDataBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Icon(Icons.image_not_supported_outlined,
                  color: Colors.grey[400], size: 48.sp),
              SizedBox(height: 12.h),
              Text(
                'No payment details found',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Make sure the text is clearly visible and try with better lighting.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Action buttons ──────────────────────────────────────────────────────

  // 1.4: Use _effectiveType directly (not _buildAmbiguousActions calling
  // _buildActions) to guarantee no recursion.
  Widget _buildActions() => switch (_effectiveType) {
        'bank_details' => _buildBankDetailsActions(),
        'internal_user' => _buildInternalUserActions(),
        'phone_number' => _buildPhoneNumberActions(),
        'ambiguous' => _buildAmbiguousActions(),
        _ => _buildNoDataActions(),
      };

  Widget _buildBankDetailsActions() {
    final canVerify = !_isVerifying &&
        _accountNumberController.text.length == 10 &&
        _selectedBankCode != null &&
        _hasVerificationCubit; // 1.5: Only enable if cubit exists

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: canVerify ? _onVerifyAccount : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: _isVerifying
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text('Verifying...', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                    ],
                  )
                : Text('Verify Account', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          ),
        ),
        // 1.5: Show warning if verification cubit not available
        if (!_hasVerificationCubit &&
            _accountNumberController.text.length == 10 &&
            _selectedBankCode != null) ...[
          SizedBox(height: 8.h),
          Text(
            'Account verification is not available. Please go back and try again.',
            style: TextStyle(color: Colors.orange[700], fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildInternalUserActions() {
    final hasUsername = widget.scanResult.username != null &&
        widget.scanResult.username!.isNotEmpty;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            // 1.3: Disable if username is empty
            onPressed: hasUsername
                ? () {
                    Navigator.pop(
                      context,
                      ScanAction(
                        type: ScanActionType.internalTransfer,
                        username: widget.scanResult.username,
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.search),
            label: Text('Search User', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // Always offer retry
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(
                context,
                const ScanAction(type: ScanActionType.retryCapture),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: _purple,
              side: BorderSide(color: _purple),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text('Scan Again', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberActions() {
    final hasPhone = widget.scanResult.phoneNumber != null &&
        widget.scanResult.phoneNumber!.isNotEmpty;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            // 1.2: Disable if phone number is empty
            onPressed: hasPhone
                ? () {
                    Navigator.pop(
                      context,
                      ScanAction(
                        type: ScanActionType.phoneTransfer,
                        phoneNumber: widget.scanResult.phoneNumber,
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
            label: Text('Send via Phone Transfer', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        if (hasPhone) ...[
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // 1.1: Switch to bank details view with phone number as account
                setState(() {
                  _disambiguatedType = 'bank_details';
                  final phone = widget.scanResult.phoneNumber ?? '';
                  final local = phone.startsWith('234')
                      ? '0${phone.substring(3)}'
                      : phone;
                  _accountNumberController.text = local;
                });
              },
              icon: const Icon(Icons.account_balance_outlined),
              label: Text('Use as Bank Account', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: _purple,
                side: BorderSide(color: _purple),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
        if (!hasPhone) ...[
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  const ScanAction(type: ScanActionType.retryCapture),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: _purple,
                side: BorderSide(color: _purple),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text('Scan Again', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ],
    );
  }

  // 1.4: _buildAmbiguousActions no longer calls _buildActions() recursively.
  // When disambiguated, _effectiveType changes → _buildActions() dispatches
  // to the correct non-ambiguous handler directly.
  Widget _buildAmbiguousActions() {
    if (_disambiguatedType != null && _disambiguatedType != 'ambiguous') {
      // Disambiguation resolved — render the appropriate action directly
      return switch (_disambiguatedType!) {
        'bank_details' => _buildBankDetailsActions(),
        'internal_user' => _buildInternalUserActions(),
        'phone_number' => _buildPhoneNumberActions(),
        _ => _buildNoDataActions(),
      };
    }

    // Not yet disambiguated — disabled button
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Select an option above',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildNoDataActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Enter Manually',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                const ScanAction(type: ScanActionType.retryCapture),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  // ── Verify button handler ───────────────────────────────────────────────

  void _onVerifyAccount() {
    if (!_hasVerificationCubit) return;
    context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _selectedBankCode!,
          accountNumber: _accountNumberController.text,
          bankName: _selectedBankName ?? '',
        );
  }

  // ── Shared widgets ──────────────────────────────────────────────────────

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildConfidenceBadge(double confidence) {
    final percent = (confidence * 100).round();
    final color = confidence >= 0.8
        ? Colors.green
        : confidence >= 0.5
            ? Colors.orange
            : Colors.red;
    final icon = confidence >= 0.8
        ? Icons.check_circle
        : confidence >= 0.5
            ? Icons.warning_amber_rounded
            : Icons.error_outline;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            '$percent%',
            style: TextStyle(
              color: color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[50],
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[500]),
      prefixIcon: Icon(icon, color: Colors.grey[600]),
      counterText: '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: _purple, width: 2),
      ),
    );
  }

  Widget _buildBankSelector() {
    final banks = BanksData.getBanksForCountry(widget.country);

    return GestureDetector(
      onTap: () => _showBankPicker(banks),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            if (_selectedBankCode != null)
              BankLogo(
                bankName: _selectedBankName ?? '',
                bankCode: _selectedBankCode,
                country: widget.country,
                size: 28,
                borderRadius: 6,
              )
            else
              Icon(Icons.account_balance_outlined,
                  color: Colors.grey[600], size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _selectedBankName ?? 'Select bank',
                style: TextStyle(
                  color: _selectedBankName != null
                      ? Colors.black87
                      : Colors.grey[500],
                  fontSize: 15.sp,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  void _showBankPicker(List<Map<String, String>> banks) {
    final searchController = TextEditingController();
    List<Map<String, String>> filtered = List.from(banks);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setPickerState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: TextField(
                      controller: searchController,
                      decoration: _inputDecoration(
                        hint: 'Search banks...',
                        icon: Icons.search,
                      ),
                      onChanged: (query) {
                        setPickerState(() {
                          filtered = banks
                              .where((b) => b['name']!
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (ctx, index) {
                        final bank = filtered[index];
                        return ListTile(
                          leading: BankLogo(
                            bankName: bank['name'] ?? '',
                            bankCode: bank['code'],
                            country: widget.country,
                            size: 36,
                            borderRadius: 8,
                          ),
                          title: Text(
                            bank['name'] ?? '',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedBankCode = bank['code'];
                              _selectedBankName = bank['name'];
                            });
                            Navigator.pop(ctx);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
