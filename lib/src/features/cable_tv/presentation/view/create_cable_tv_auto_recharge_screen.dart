import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/cable_tv_auto_recharge.dart';
import '../../domain/entities/cable_tv_beneficiary.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../cubit/cable_tv_auto_recharge_cubit.dart';
import '../cubit/cable_tv_auto_recharge_state.dart';
import '../cubit/cable_tv_beneficiary_cubit.dart';
import '../cubit/cable_tv_beneficiary_state.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';

/// Create / edit a cable TV auto-renew schedule. Package and amount are
/// loaded from the backend provider catalog — no free-text entry allowed.
class CreateCableTVAutoRechargeScreen extends StatefulWidget {
  const CreateCableTVAutoRechargeScreen({super.key});

  @override
  State<CreateCableTVAutoRechargeScreen> createState() =>
      _CreateCableTVAutoRechargeScreenState();
}

class _CreateCableTVAutoRechargeScreenState
    extends State<CreateCableTVAutoRechargeScreen> {
  CableTVBeneficiary? _beneficiary;
  TVPackageEntity? _selectedPackage;

  // Package loading state
  List<TVPackageEntity>? _loadedPackages;
  bool _packagesLoading = false;
  String? _packagesError;

  String _frequency = 'monthly';
  int _dayOfMonth = 1;
  int _dayOfWeek = 1;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  bool _saving = false;
  bool _locked = false;
  String? _editId;
  String _subscriptionType = 'change';

  // Synthetic package used in edit mode before real packages load.
  TVPackageEntity? _editFallbackPackage;

  @override
  void initState() {
    super.initState();
    context.read<CableTVBeneficiaryCubit>().load();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) return;

    _locked = args['locked'] == true;
    final ar = args['autoRecharge'];

    if (ar is CableTVAutoRecharge) {
      _editId = ar.id;
      _frequency = ar.frequency.isNotEmpty ? ar.frequency : 'monthly';
      _dayOfWeek = ar.dayOfWeek > 0 ? ar.dayOfWeek : 1;
      _dayOfMonth = ar.dayOfMonth > 0 ? ar.dayOfMonth : 1;
      _time = TimeOfDay(hour: ar.executionHour, minute: ar.executionMinute);
      _subscriptionType =
          ar.subscriptionType.isNotEmpty ? ar.subscriptionType : 'change';

      // Build a synthetic package from the stored AR so the UI is populated
      // immediately, before the real package list arrives.
      if (ar.variationCode.isNotEmpty) {
        _editFallbackPackage = TVPackageEntity(
          id: ar.variationCode,
          name: ar.packageName.isNotEmpty ? ar.packageName : ar.variationCode,
          variationCode: ar.variationCode,
          amount: ar.amount,
          providerId: ar.providerCode,
          validity: '',
        );
        _selectedPackage = _editFallbackPackage;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      CableTVBeneficiary? b = args['beneficiary'];
      if (b == null && ar is CableTVAutoRecharge && ar.beneficiary != null) {
        b = ar.beneficiary;
      }
      if (b != null) {
        setState(() => _beneficiary = b);
        _loadPackages(b.providerCode);
      }
    });
  }

  void _loadPackages(String providerCode) {
    if (providerCode.isEmpty) return;
    setState(() {
      _packagesLoading = true;
      _packagesError = null;
    });
    context.read<CableTVCubit>().getPackages(providerId: providerCode);
  }

  void _onBeneficiaryChanged(CableTVBeneficiary? b) {
    setState(() {
      _beneficiary = b;
      // Clear package selection when beneficiary changes — different provider.
      _selectedPackage = null;
      _loadedPackages = null;
      _packagesError = null;
    });
    if (b != null) _loadPackages(b.providerCode);
  }

  Future<void> _submit() async {
    if (_beneficiary == null) {
      _snack('Pick a saved smart card', error: true);
      return;
    }

    // Plans must be loaded from the backend so the variation code we send to
    // the timer worker is guaranteed to exist in the VTpass catalog. Blocking
    // here prevents silent auto-renew failures at execution time.
    if (_packagesLoading) {
      _snack('Still loading plans. Please wait a moment.', error: true);
      return;
    }
    if (_packagesError != null || _loadedPackages == null) {
      _snack(
          'Plans are not available. Tap retry on the plan picker before saving.',
          error: true);
      return;
    }
    if (_loadedPackages!.isEmpty) {
      _snack('No plans available for this provider. Cannot save.',
          error: true);
      return;
    }

    if (_selectedPackage == null) {
      _snack('Select a package plan', error: true);
      return;
    }
    if (_selectedPackage!.variationCode.isEmpty) {
      _snack('Selected package has no variation code. Please choose another',
          error: true);
      return;
    }
    if (_selectedPackage!.amount <= 0) {
      _snack('Selected package has no amount. Please choose another',
          error: true);
      return;
    }

    // Ensure the selected package exists in the freshly loaded catalog. Edit
    // mode starts with a synthetic fallback (built from stored values) so we
    // don't trust it until the catalog confirms it.
    final match = _loadedPackages!.where(
      (p) => p.variationCode == _selectedPackage!.variationCode,
    );
    if (match.isEmpty) {
      _snack(
          'Selected plan is no longer available. Please pick a plan from the list.',
          error: true);
      return;
    }
    // Pin to the catalog entry so name/amount match the current VTpass values
    // (protects against stale synthetic fallbacks where name == variationCode).
    _selectedPackage = match.first;

    // Frequency-specific sanity checks.
    if (_frequency == 'weekly' && (_dayOfWeek < 1 || _dayOfWeek > 7)) {
      _snack('Pick a valid day of the week', error: true);
      return;
    }
    if (_frequency == 'monthly' &&
        (_dayOfMonth < 1 || _dayOfMonth > 31)) {
      _snack('Pick a day of the month between 1 and 31', error: true);
      return;
    }
    if (_time.hour < 0 ||
        _time.hour > 23 ||
        _time.minute < 0 ||
        _time.minute > 59) {
      _snack('Invalid execution time', error: true);
      return;
    }

    setState(() => _saving = true);
    try {
      if (_editId != null) {
        await context.read<CableTVAutoRechargeCubit>().update(
              autoRechargeId: _editId!,
              variationCode: _selectedPackage!.variationCode,
              packageName: _selectedPackage!.name,
              amount: _selectedPackage!.amount,
              frequency: _frequency,
              dayOfWeek: _dayOfWeek,
              dayOfMonth: _dayOfMonth,
              executionHour: _time.hour,
              executionMinute: _time.minute,
            );
      } else {
        await context.read<CableTVAutoRechargeCubit>().create(
              beneficiaryId: _beneficiary!.id,
              variationCode: _selectedPackage!.variationCode,
              packageName: _selectedPackage!.name,
              amount: _selectedPackage!.amount,
              currency: 'NGN',
              subscriptionType: _subscriptionType,
              frequency: _frequency,
              dayOfWeek: _dayOfWeek,
              dayOfMonth: _dayOfMonth,
              executionHour: _time.hour,
              executionMinute: _time.minute,
            );
      }
      if (!mounted) return;
      Get.back(result: true);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            error ? const Color(0xFFEF4444) : const Color(0xFF10B981),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CableTVAutoRechargeCubit, CableTVAutoRechargeState>(
          listener: (context, state) {
            if (state is CableTVAutoRechargeError && _saving) {
              setState(() => _saving = false);
              _snack(state.message, error: true);
            }
          },
        ),
        BlocListener<CableTVCubit, CableTVState>(
          listener: (context, state) {
            if (state is TVPackagesLoaded) {
              if (!mounted) return;
              setState(() {
                _loadedPackages = state.packages;
                _packagesLoading = false;
                _packagesError = null;

                // In edit mode, try to match stored variationCode to a real
                // catalog entry; fall back to synthetic if not found.
                if (_editId != null && _editFallbackPackage != null) {
                  final match = state.packages.where(
                    (p) => p.variationCode == _editFallbackPackage!.variationCode,
                  );
                  _selectedPackage = match.isNotEmpty
                      ? match.first
                      : _editFallbackPackage;
                } else if (_selectedPackage != null) {
                  // Refresh selection if it's already pointing at a package
                  // from an earlier load (e.g., user changed beneficiary).
                  final match = state.packages.where(
                    (p) => p.variationCode == _selectedPackage!.variationCode,
                  );
                  _selectedPackage = match.isNotEmpty ? match.first : null;
                }
              });
            } else if (state is CableTVError) {
              if (!mounted) return;
              setState(() {
                _packagesLoading = false;
                _packagesError = state.message;
              });
            } else if (state is CableTVLoading) {
              if (!mounted) return;
              setState(() {
                _packagesLoading = true;
                _packagesError = null;
              });
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20.sp),
            onPressed: () => Get.back(),
          ),
          title: Text(
              _editId != null ? 'Edit Auto-Renew' : 'Create Auto-Renew',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Saved Smart Card'),
                SizedBox(height: 8.h),
                _beneficiarySelector(),
                SizedBox(height: 20.h),
                _label('Subscription Plan'),
                SizedBox(height: 8.h),
                _packageSelector(),
                SizedBox(height: 20.h),
                if (_selectedPackage != null) ...[
                  _label('Amount (₦)'),
                  SizedBox(height: 8.h),
                  _amountDisplay(),
                  SizedBox(height: 20.h),
                ],
                _label('Subscription Type'),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _typeChip('change', 'Change / Set'),
                    SizedBox(width: 8.w),
                    _typeChip('renew', 'Renew'),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '"Change / Set" replaces your current package. "Renew" extends the same package.',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: const Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16.h),
                _label('Frequency'),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _freqChip('daily', 'Daily'),
                    SizedBox(width: 8.w),
                    _freqChip('weekly', 'Weekly'),
                    SizedBox(width: 8.w),
                    _freqChip('monthly', 'Monthly'),
                  ],
                ),
                SizedBox(height: 16.h),
                if (_frequency == 'weekly') ...[
                  _label('Day of week'),
                  SizedBox(height: 8.h),
                  _dayOfWeekPicker(),
                  SizedBox(height: 16.h),
                ],
                if (_frequency == 'monthly') ...[
                  _label('Day of month'),
                  SizedBox(height: 8.h),
                  _dayOfMonthPicker(),
                  SizedBox(height: 16.h),
                ],
                _label('Execution time'),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                    if (picked != null) setState(() => _time = picked);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFF2D2D2D)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time,
                            color: const Color(0xFF4E03D0), size: 18.sp),
                        SizedBox(width: 10.w),
                        Text(_time.format(context),
                            style: TextStyle(
                                color: Colors.white, fontSize: 15.sp)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                      elevation: 0,
                    ),
                    child: _saving
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            _editId != null
                                ? 'Update Auto-Renew'
                                : 'Schedule Auto-Renew',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Package selector
  // ============================================================

  Widget _packageSelector() {
    if (_beneficiary == null) {
      return _disabledField(
        icon: Icons.tv,
        text: 'Select a smart card first',
      );
    }

    if (_packagesLoading && _loadedPackages == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Color(0xFF4E03D0)),
              ),
            ),
            SizedBox(width: 12.w),
            Text('Loading packages…',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ],
        ),
      );
    }

    if (_packagesError != null && _loadedPackages == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline,
                    color: const Color(0xFFEF4444), size: 18.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    _packagesError!,
                    style: TextStyle(
                        color: const Color(0xFFEF4444), fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          TextButton.icon(
            onPressed: () => _loadPackages(_beneficiary!.providerCode),
            icon: Icon(Icons.refresh, size: 16.sp),
            label: Text('Retry', style: TextStyle(fontSize: 13.sp)),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4E03D0),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      );
    }

    // Package selector tile.
    return GestureDetector(
      onTap: () => _showPackageSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _selectedPackage != null
                ? const Color(0xFF4E03D0)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.live_tv,
                color: _selectedPackage != null
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF6B7280),
                size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: _selectedPackage == null
                  ? Text(
                      'Select a plan',
                      style: TextStyle(
                          color: const Color(0xFF4B5563), fontSize: 15.sp),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedPackage!.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _selectedPackage!.variationCode,
                          style: TextStyle(
                              color: const Color(0xFF6B7280),
                              fontSize: 11.sp),
                        ),
                      ],
                    ),
            ),
            if (_packagesLoading)
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Color(0xFF4E03D0)),
                ),
              )
            else
              Icon(Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _amountDisplay() {
    final fmt = NumberFormat('#,##0', 'en_NG');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline,
              color: const Color(0xFF6B7280), size: 16.sp),
          SizedBox(width: 10.w),
          Text(
            '₦${fmt.format(_selectedPackage!.amount)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF10B981),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '(set by package)',
            style: TextStyle(
                color: const Color(0xFF6B7280), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  void _showPackageSheet() {
    final packages = _loadedPackages ?? const <TVPackageEntity>[];
    if (packages.isEmpty && !_packagesLoading) {
      _snack('No packages available for this provider', error: true);
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.92,
        expand: false,
        builder: (_, scrollCtrl) => Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4B5563),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Text(
                        'Select a Plan',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _beneficiary?.providerName ?? '',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: const Color(0xFF2D2D2D), height: 1),
                ],
              ),
            ),
            Expanded(
              child: packages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.tv_off,
                              color: const Color(0xFF4B5563),
                              size: 48.sp),
                          SizedBox(height: 12.h),
                          Text(
                            'No plans found for this provider.',
                            style: TextStyle(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      controller: scrollCtrl,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 8.h),
                      itemCount: packages.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: const Color(0xFF2D2D2D), height: 1),
                      itemBuilder: (_, i) {
                        final pkg = packages[i];
                        final isSelected =
                            _selectedPackage?.variationCode ==
                                pkg.variationCode;
                        final fmt = NumberFormat('#,##0', 'en_NG');
                        return InkWell(
                          onTap: () {
                            setState(() => _selectedPackage = pkg);
                            Navigator.of(ctx).pop();
                          },
                          borderRadius: BorderRadius.circular(10.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 12.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF4E03D0)
                                            .withValues(alpha: 0.15)
                                        : const Color(0xFF0A0A0A),
                                    borderRadius:
                                        BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF4E03D0)
                                          : const Color(0xFF2D2D2D),
                                    ),
                                  ),
                                  child: Icon(Icons.live_tv,
                                      color: isSelected
                                          ? const Color(0xFF4E03D0)
                                          : const Color(0xFF6B7280),
                                      size: 18.sp),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pkg.name,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        children: [
                                          Text(
                                            pkg.variationCode,
                                            style: TextStyle(
                                              color: const Color(0xFF6B7280),
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                          if (pkg.validity.isNotEmpty) ...[
                                            Text(' · ',
                                                style: TextStyle(
                                                    color: const Color(
                                                        0xFF4B5563),
                                                    fontSize: 11.sp)),
                                            Text(
                                              pkg.validity,
                                              style: TextStyle(
                                                color: const Color(0xFF6B7280),
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₦${fmt.format(pkg.amount)}',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF10B981),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(Icons.check_circle,
                                          color: const Color(0xFF4E03D0),
                                          size: 16.sp),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Beneficiary selector
  // ============================================================

  Widget _beneficiarySelector() {
    if (_locked && _beneficiary != null) {
      final b = _beneficiary!;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(Icons.lock_outline,
                color: const Color(0xFF6B7280), size: 16.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                '${b.nickname ?? b.smartCardNumber} · ${b.providerName}',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<CableTVBeneficiaryCubit, CableTVBeneficiaryState>(
      buildWhen: (_, s) =>
          s is CableTVBeneficiariesLoaded ||
          s is CableTVBeneficiariesLoading ||
          s is CableTVBeneficiaryError,
      builder: (context, state) {
        if (state is CableTVBeneficiariesLoading) {
          return _loadingField();
        }
        if (state is! CableTVBeneficiariesLoaded) {
          return _loadingField();
        }
        final list = state.beneficiaries;
        if (list.isEmpty) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Text(
              'No saved smart cards. Save one from a cable TV receipt first.',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CableTVBeneficiary>(
              isExpanded: true,
              value: _beneficiary,
              hint: Text('Select a smart card',
                  style: TextStyle(
                      color: const Color(0xFF4B5563), fontSize: 15.sp)),
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF9CA3AF)),
              dropdownColor: const Color(0xFF1F1F1F),
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              items: list
                  .map((b) => DropdownMenuItem<CableTVBeneficiary>(
                        value: b,
                        child: Text(
                          '${b.nickname ?? b.smartCardNumber} · ${b.providerName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: _onBeneficiaryChanged,
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // Small helpers
  // ============================================================

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          fontSize: 13.sp,
          color: const Color(0xFF9CA3AF),
          fontWeight: FontWeight.w500));

  Widget _disabledField({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4B5563), size: 18.sp),
          SizedBox(width: 10.w),
          Text(text,
              style: TextStyle(
                  color: const Color(0xFF4B5563), fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _loadingField() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Color(0xFF4E03D0)),
          ),
        ),
      ),
    );
  }

  Widget _typeChip(String value, String label) {
    final selected = _subscriptionType == value;
    return GestureDetector(
      onTap: () => setState(() => _subscriptionType = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4E03D0) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                selected ? const Color(0xFF4E03D0) : const Color(0xFF2D2D2D),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : const Color(0xFF9CA3AF))),
      ),
    );
  }

  Widget _freqChip(String value, String label) {
    final selected = _frequency == value;
    return GestureDetector(
      onTap: () => setState(() => _frequency = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4E03D0) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                selected ? const Color(0xFF4E03D0) : const Color(0xFF2D2D2D),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : const Color(0xFF9CA3AF))),
      ),
    );
  }

  Widget _dayOfWeekPicker() => Row(
        children: List.generate(7, (i) {
          final day = i + 1;
          final selected = _dayOfWeek == day;
          const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _dayOfWeek = day),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF4E03D0)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: selected
                          ? const Color(0xFF4E03D0)
                          : const Color(0xFF2D2D2D)),
                ),
                child: Text(names[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF9CA3AF))),
              ),
            ),
          );
        }),
      );

  Widget _dayOfMonthPicker() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 1.2,
        ),
        itemCount: 31,
        itemBuilder: (_, i) {
          final day = i + 1;
          final selected = _dayOfMonth == day;
          return GestureDetector(
            onTap: () => setState(() => _dayOfMonth = day),
            child: Container(
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: selected
                        ? const Color(0xFF4E03D0)
                        : const Color(0xFF2D2D2D)),
              ),
              child: Center(
                child: Text('$day',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF9CA3AF))),
              ),
            ),
          );
        },
      );
}
