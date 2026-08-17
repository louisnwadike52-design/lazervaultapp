part of 'create_reminder_screen.dart';

class _ReminderAddBeneficiarySheet extends StatefulWidget {
  final ElectricityBillCubit electricityBillCubit;
  final BeneficiaryCubit beneficiaryCubit;
  final AuthenticationCubit authCubit;
  final void Function(BillBeneficiaryEntity beneficiary) onSaved;

  const _ReminderAddBeneficiarySheet({
    required this.electricityBillCubit,
    required this.beneficiaryCubit,
    required this.authCubit,
    required this.onSaved,
  });

  @override
  State<_ReminderAddBeneficiarySheet> createState() => _ReminderAddBeneficiarySheetState();
}

class _ReminderAddBeneficiarySheetState extends State<_ReminderAddBeneficiarySheet> {
  final _meterController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();

  SmartMeterValidationResult? _smartResult;
  bool _isValidated = false;
  bool _isLookingUp = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final authState = widget.authCubit.state;
    if (authState is AuthenticationSuccess) {
      final phone = authState.profile.user.phoneNumber ?? '';
      if (phone.isNotEmpty) _phoneController.text = phone;
    }
  }

  @override
  void dispose() {
    _meterController.dispose();
    _nicknameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _lookUpMeter() async {
    final meter = _meterController.text.trim();
    if (meter.isEmpty) {
      Get.snackbar('Error', 'Please enter meter number',
          backgroundColor: Colors.red.withValues(alpha: 0.9), colorText: Colors.white);
      return;
    }
    setState(() => _isLookingUp = true);

    final result = await widget.electricityBillCubit.repository.smartValidateMeter(meterNumber: meter);

    if (!mounted) return;
    result.fold(
      (failure) {
        setState(() => _isLookingUp = false);
        Get.snackbar('Error', failure.message,
            backgroundColor: Colors.red.withValues(alpha: 0.9), colorText: Colors.white);
      },
      (smartResult) {
        setState(() {
          _isLookingUp = false;
          if (smartResult.isValid) {
            _smartResult = smartResult;
            _isValidated = true;
          } else {
            Get.snackbar('Error', 'Meter not found',
                backgroundColor: Colors.red.withValues(alpha: 0.9), colorText: Colors.white);
          }
        });
      },
    );
  }

  void _saveBeneficiary() async {
    if (!_isValidated || _smartResult == null) return;
    final nickname = _nicknameController.text.trim();
    if (nickname.isEmpty) {
      Get.snackbar('Error', 'Please enter a nickname',
          backgroundColor: Colors.red.withValues(alpha: 0.9), colorText: Colors.white);
      return;
    }

    setState(() => _isSaving = true);

    final meterType = _smartResult!.meterType.toLowerCase().contains('postpaid')
        ? MeterType.postpaid
        : MeterType.prepaid;

    final providersResult = await widget.electricityBillCubit.repository.getProviders(country: serviceLocator<LocaleManager>().currentCountry);
    String providerId = '';
    providersResult.fold((_) {}, (providers) {
      final matched = providers.where(
        (p) => p.providerCode.toLowerCase() == _smartResult!.providerCode.toLowerCase(),
      );
      if (matched.isNotEmpty) providerId = matched.first.id;
    });

    final result = await widget.beneficiaryCubit.repository.saveBeneficiary(
      providerId: providerId,
      meterNumber: _smartResult!.meterNumber,
      meterType: meterType,
      customerName: _smartResult!.customerName,
      customerAddress: _smartResult!.customerAddress,
      phoneNumber: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
      nickname: nickname,
      isDefault: false,
      providerCode: _smartResult!.providerCode,
      providerName: _smartResult!.providerName,
    );

    if (!mounted) return;
    result.fold(
      (failure) {
        setState(() => _isSaving = false);
        Get.snackbar('Error', failure.message,
            backgroundColor: Colors.red.withValues(alpha: 0.9), colorText: Colors.white);
      },
      (beneficiary) {
        widget.onSaved(beneficiary);
        Get.back();
        Get.snackbar('Success', 'Beneficiary saved',
            backgroundColor: Colors.green.withValues(alpha: 0.9), colorText: Colors.white);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F23),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, MediaQuery.of(context).viewInsets.bottom + 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text('Add New Beneficiary',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 20.h),
            Text('Meter Number',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: TextField(
                controller: _meterController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(kMeterNumberMaxLen),
                ],
                style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: 'Enter meter number',
                  hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.3), fontSize: 16.sp),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: _isLookingUp ? null : _lookUpMeter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color(0xFF4E03D0), const Color(0xFF6B21E0)]),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: _isLookingUp
                    ? Center(child: LazerVaultLoader.small())
                    : Text('Look Up Meter',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
              ),
            ),
            if (_isValidated && _smartResult != null) ...[
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF4E03D0).withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sheetInfoRow('Customer', _smartResult!.customerName),
                    _sheetInfoRow('Provider', _smartResult!.providerName),
                    _sheetInfoRow('Meter', _smartResult!.meterNumber),
                    _sheetInfoRow('Type', _smartResult!.meterType),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text('Nickname',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: TextField(
                  controller: _nicknameController,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                  decoration: InputDecoration(
                    hintText: 'e.g., Home, Office',
                    hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.3), fontSize: 16.sp),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text('Phone (Optional)',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                  decoration: InputDecoration(
                    hintText: '+234...',
                    hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.3), fontSize: 16.sp),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: _isSaving ? null : _saveBeneficiary,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [const Color(0xFF4E03D0), const Color(0xFF6B21E0)]),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _isSaving
                      ? Center(child: LazerVaultLoader.small())
                      : Text('Save Beneficiary',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _sheetInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Text(label, style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp)),
          ),
          Expanded(child: Text(value, style: GoogleFonts.inter(
            color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
