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

/// Bottom sheet modal showing OCR-extracted bank details with editing + verification.
class ScanBankDetailsModal extends StatefulWidget {
  final BankScanResult scanResult;
  final String country;

  const ScanBankDetailsModal({
    super.key,
    required this.scanResult,
    this.country = 'NG',
  });

  /// Show the modal as a bottom sheet. Returns verified account data or null.
  static Future<Map<String, String>?> show(
    BuildContext context, {
    required BankScanResult scanResult,
    String country = 'NG',
  }) {
    return showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ScanBankDetailsModal(
        scanResult: scanResult,
        country: country,
      ),
    );
  }

  @override
  State<ScanBankDetailsModal> createState() => _ScanBankDetailsModalState();
}

class _ScanBankDetailsModalState extends State<ScanBankDetailsModal> {
  late TextEditingController _accountNumberController;
  late TextEditingController _accountNameController;
  String? _selectedBankCode;
  String? _selectedBankName;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _accountNumberController = TextEditingController(
      text: widget.scanResult.accountNumber,
    );
    _accountNameController = TextEditingController(
      text: widget.scanResult.accountName ?? '',
    );
    _selectedBankName = widget.scanResult.bankName;
    _selectedBankCode = widget.scanResult.bankCode;

    // If we have a bank name but no code, try to resolve it
    if (_selectedBankCode == null && _selectedBankName != null) {
      _resolveBankCode(_selectedBankName!);
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
    _accountNameController.dispose();
    super.dispose();
  }

  Color _confidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.5) return Colors.orange;
    return Colors.red;
  }

  IconData _confidenceIcon(double confidence) {
    if (confidence >= 0.8) return Icons.check_circle;
    if (confidence >= 0.5) return Icons.warning_amber_rounded;
    return Icons.error_outline;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountVerificationCubit, AccountVerificationState>(
      listener: (context, state) {
        if (state is AccountVerificationLoading) {
          setState(() => _isVerifying = true);
        } else if (state is AccountVerificationSuccess) {
          setState(() => _isVerifying = false);
          Navigator.pop(context, {
            'accountNumber': state.accountNumber,
            'accountName': state.accountName,
            'bankName': state.bankName,
            'bankCode': state.bankCode,
            'verificationStatus': state.verificationStatus,
          });
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
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: _purple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.document_scanner_outlined,
                      color: _purple,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scanned Bank Details',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Review and verify the extracted details',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Overall confidence badge
                  _buildConfidenceBadge(widget.scanResult.confidenceScore),
                ],
              ),
              SizedBox(height: 24.h),

              // Scrollable fields
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Account Number
                      _buildFieldLabel(
                        'Account Number',
                        widget.scanResult.fieldConfidence['account_number'] ?? 0,
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _accountNumberController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: _inputDecoration(
                          hint: 'Enter account number',
                          icon: Icons.numbers_outlined,
                        ),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      SizedBox(height: 16.h),

                      // Bank Name
                      _buildFieldLabel(
                        'Bank',
                        widget.scanResult.fieldConfidence['bank_name'] ?? 0,
                      ),
                      SizedBox(height: 8.h),
                      _buildBankSelector(),
                      SizedBox(height: 16.h),

                      // Account Name (read-only from OCR, updated after verification)
                      if (widget.scanResult.accountName != null &&
                          widget.scanResult.accountName!.isNotEmpty) ...[
                        _buildFieldLabel(
                          'Account Name',
                          widget.scanResult.fieldConfidence['account_name'] ?? 0,
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _accountNameController,
                          decoration: _inputDecoration(
                            hint: 'Account holder name',
                            icon: Icons.person_outline,
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],

                      // Routing / Sort Code
                      if (widget.scanResult.routingNumber != null) ...[
                        _buildFieldLabel(
                          'Sort Code / Routing Number',
                          widget.scanResult.fieldConfidence['routing_number'] ?? 0,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.route_outlined,
                                  color: Colors.grey[600], size: 20.sp),
                              SizedBox(width: 12.w),
                              Text(
                                widget.scanResult.routingNumber!,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ],
                  ),
                ),
              ),

              // Verify button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canVerify() ? _onVerify : null,
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
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Verifying...',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Verify Account',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
            ],
          ),
        ),
      ),
    );
  }

  bool _canVerify() {
    return !_isVerifying &&
        _accountNumberController.text.length == 10 &&
        _selectedBankCode != null;
  }

  void _onVerify() {
    context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _selectedBankCode!,
          accountNumber: _accountNumberController.text,
          bankName: _selectedBankName ?? '',
        );
  }

  Widget _buildFieldLabel(String label, double confidence) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8.w),
        if (confidence > 0)
          Icon(
            _confidenceIcon(confidence),
            color: _confidenceColor(confidence),
            size: 16.sp,
          ),
      ],
    );
  }

  Widget _buildConfidenceBadge(double confidence) {
    final percent = (confidence * 100).round();
    final color = _confidenceColor(confidence);
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
          Icon(_confidenceIcon(confidence), color: color, size: 14.sp),
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
        borderSide: BorderSide(color: _purple, width: 2),
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
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
