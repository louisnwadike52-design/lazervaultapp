import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/entities/internet_auto_recharge.dart';
import '../../domain/entities/internet_beneficiary.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../cubit/internet_auto_recharge_cubit.dart';
import '../cubit/internet_auto_recharge_state.dart';
import '../cubit/internet_beneficiary_cubit.dart';
import '../cubit/internet_beneficiary_state.dart';
import '../cubit/internet_bill_cubit.dart';
import '../cubit/internet_bill_state.dart';

/// Create / edit an internet Rollover schedule. Mirrors the data
/// bundles' `CreateDataAutoRechargeScreen`:
///
/// * Pick a saved ISP contact (or inherit one from the caller)
/// * Pick a package for that ISP's service
/// * Pick cadence: daily / weekly (day-of-week) / monthly (day-of-month)
/// * Pick execution time (defaults to 09:00 local)
/// * Submit → `InternetAutoRechargeCubit.create` / `.update`
///
/// Package selection is ISP-locked: changing the beneficiary clears the
/// package. Backend rejects zero-amount rollovers so the submit button
/// is only enabled when package + beneficiary are both set.
class CreateInternetRolloverScreen extends StatefulWidget {
  const CreateInternetRolloverScreen({super.key});

  @override
  State<CreateInternetRolloverScreen> createState() =>
      _CreateInternetRolloverScreenState();
}

class _CreateInternetRolloverScreenState
    extends State<CreateInternetRolloverScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _mutedDark = Color(0xFF4B5563);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);

  InternetBeneficiary? _beneficiary;
  InternetPackageEntity? _package;
  String _frequency = 'monthly';
  int _dayOfMonth = 1;
  int _dayOfWeek = 1;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  bool _saving = false;

  /// When true the beneficiary selector renders as a read-only chip.
  /// Set by callers who want to lock this schedule to a specific
  /// contact (e.g. from the saved-accounts sheet's "Set Rollover").
  bool _locked = false;

  /// Non-null when editing an existing auto-recharge.
  String? _editId;

  @override
  void initState() {
    super.initState();
    context.read<InternetBeneficiaryCubit>().load();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _locked = args['locked'] == true;
      final ar = args['autoRecharge'];
      if (ar is InternetAutoRecharge) {
        _editId = ar.id;
        _frequency = ar.frequency.isNotEmpty ? ar.frequency : 'monthly';
        _dayOfWeek = ar.dayOfWeek > 0 ? ar.dayOfWeek : 1;
        _dayOfMonth = ar.dayOfMonth > 0 ? ar.dayOfMonth : 1;
        _time = TimeOfDay(
          hour: ar.executionHour,
          minute: ar.executionMinute,
        );
        _locked = true; // editing always locks the beneficiary
        // Seed the package slot from the existing rollover so the
        // edit screen shows what the user is editing even before the
        // package-list RPC resolves (and covers the legacy case where
        // the ISP has retired the package — the user still sees the
        // original name + amount rather than an empty slot).
        if (ar.packageId.isNotEmpty) {
          _package = InternetPackageEntity(
            id: ar.packageId,
            name: ar.planName,
            variationCode: ar.packageId,
            amount: ar.amount,
            providerId: ar.providerCode.toLowerCase(),
            validity: '',
          );
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final b = args['beneficiary'];
        if (b is InternetBeneficiary) {
          setState(() => _beneficiary = b);
          _loadPackagesForBeneficiary(b);
        } else if (ar is InternetAutoRecharge && ar.beneficiary != null) {
          setState(() => _beneficiary = ar.beneficiary);
          _loadPackagesForBeneficiary(ar.beneficiary!);
        }
      });
    }
  }

  /// `InternetBeneficiary.providerCode` is the canonical uppercase ISP
  /// code (e.g. `SMILE`). VTpass's `getPackages` RPC wants the
  /// lowercased service ID (`smile`, `spectranet`, `ipnx`, `swift`).
  /// Best-effort reverse mapping — unknown codes fall back to
  /// lowercase which covers every other VTpass ISP by convention.
  String _serviceIdFor(String providerCode) {
    switch (providerCode.toUpperCase()) {
      case 'SMILE':
        return 'smile-direct';
      case 'SPECTRANET':
        return 'spectranet';
      case 'IPNX':
        return 'ipnx1515';
      case 'SWIFT':
        return 'swift4g';
      default:
        return providerCode.toLowerCase();
    }
  }

  void _loadPackagesForBeneficiary(InternetBeneficiary b) {
    final serviceId = _serviceIdFor(b.providerCode);
    context.read<InternetBillCubit>().getPackages(providerId: serviceId);
  }

  Future<void> _selectPackage() async {
    if (_beneficiary == null) {
      _snack('Pick a saved contact first', error: true);
      return;
    }
    final cubit = context.read<InternetBillCubit>();
    // Refresh in case the user switched beneficiary mid-session.
    cubit.getPackages(providerId: _serviceIdFor(_beneficiary!.providerCode));
    if (!mounted) return;
    final picked = await showModalBottomSheet<InternetPackageEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _PackagePickerSheet(),
      ),
    );
    if (picked != null) setState(() => _package = picked);
  }

  Future<void> _submit() async {
    if (_beneficiary == null) {
      _snack('Pick a saved contact', error: true);
      return;
    }
    if (_package == null && _editId == null) {
      _snack('Pick an internet package', error: true);
      return;
    }
    // The backend rejects amount <= 0. Catch the case locally so we
    // don't burn an RPC.
    final resolvedAmount = _package?.amount ?? 0;
    if (resolvedAmount <= 0 && _editId == null) {
      _snack('This package has no amount set', error: true);
      return;
    }
    setState(() => _saving = true);
    try {
      if (_editId != null) {
        await context.read<InternetAutoRechargeCubit>().update(
              autoRechargeId: _editId!,
              packageId: _package?.id,
              planName: _package?.name,
              amount: _package?.amount,
              frequency: _frequency,
              dayOfWeek: _dayOfWeek,
              dayOfMonth: _dayOfMonth,
              executionHour: _time.hour,
              executionMinute: _time.minute,
            );
      } else {
        await context.read<InternetAutoRechargeCubit>().create(
              beneficiaryId: _beneficiary!.id,
              packageId: _package!.id,
              planName: _package!.name,
              amount: _package!.amount,
              currency: 'NGN',
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
      // Cubit already emitted an error state → BlocListener surfaces
      // the message. Just restore the submit button.
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: error ? _red : _green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetAutoRechargeCubit, InternetAutoRechargeState>(
      listener: (context, state) {
        if (state is InternetAutoRechargeError && _saving) {
          setState(() => _saving = false);
          _snack(state.message, error: true);
        }
      },
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20.sp),
            onPressed: () => Get.back(),
          ),
          title: Text(
            _editId != null ? 'Edit Rollover' : 'Create Rollover',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Saved ISP Contact'),
                SizedBox(height: 8.h),
                _beneficiarySelector(),
                SizedBox(height: 16.h),
                _label('Internet Package'),
                SizedBox(height: 8.h),
                _packageSelector(),
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
                      color: _bg,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: _border),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: _green, size: 18.sp),
                        SizedBox(width: 10.w),
                        Text(
                          _time.format(context),
                          style: TextStyle(
                              color: Colors.white, fontSize: 15.sp),
                        ),
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
                      backgroundColor: _green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: _saving
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          )
                        : Text(
                            _editId != null
                                ? 'Update Rollover'
                                : 'Schedule Rollover',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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

  Widget _label(String t) => Text(
        t,
        style: TextStyle(
          fontSize: 13.sp,
          color: _muted,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _beneficiarySelector() {
    // Locked mode: pre-filled contact is non-editable.
    if (_locked && _beneficiary != null) {
      final b = _beneficiary!;
      final label = b.nickname?.isNotEmpty == true
          ? '${b.nickname!} · ${b.providerName}'
          : '${b.accountNumber} · ${b.providerName}';
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Icon(Icons.lock_outline, color: _mutedDark, size: 16.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    return BlocBuilder<InternetBeneficiaryCubit, InternetBeneficiaryState>(
      buildWhen: (_, s) =>
          s is InternetBeneficiariesLoaded ||
          s is InternetBeneficiariesLoading ||
          s is InternetBeneficiaryError,
      builder: (context, state) {
        if (state is InternetBeneficiariesLoading ||
            state is InternetBeneficiaryInitial) {
          return _selectorSkeleton();
        }
        if (state is InternetBeneficiaryError) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: _selectorBox(),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: _red, size: 18.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    state.message,
                    style: TextStyle(color: _muted, fontSize: 13.sp),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<InternetBeneficiaryCubit>().load(),
                  child: Text(
                    'Retry',
                    style: TextStyle(color: _green, fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is! InternetBeneficiariesLoaded) {
          return _selectorSkeleton();
        }
        final list = state.beneficiaries;
        if (list.isEmpty) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: _selectorBox(),
            child: Text(
              'No saved ISP accounts. Save one from a purchase receipt first, then come back.',
              style: TextStyle(color: _muted, fontSize: 13.sp),
            ),
          );
        }
        // Dropdown's `value` must be in the items list — if we came
        // from an edit and the stored beneficiary isn't in the freshly
        // loaded list (deleted from under us), fall back to null.
        final current = list.firstWhere(
          (b) => b.id == _beneficiary?.id,
          orElse: () => _beneficiary == null
              ? list.first
              : InternetBeneficiary(
                  id: '',
                  userId: '',
                  accountNumber: '',
                  providerCode: '',
                  providerName: '',
                  createdAt: '',
                ),
        );
        final selected = current.id.isEmpty ? null : current;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: _selectorBox(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<InternetBeneficiary>(
              isExpanded: true,
              value: selected,
              hint: Text(
                'Select a contact',
                style: TextStyle(color: _mutedDark, fontSize: 15.sp),
              ),
              icon: const Icon(Icons.keyboard_arrow_down, color: _muted),
              dropdownColor: _card,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              items: list
                  .map(
                    (b) => DropdownMenuItem<InternetBeneficiary>(
                      value: b,
                      child: Text(
                        b.nickname?.isNotEmpty == true
                            ? '${b.nickname!} · ${b.providerName}'
                            : '${b.accountNumber} · ${b.providerName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                // Changing ISP invalidates the current package.
                setState(() {
                  _beneficiary = v;
                  _package = null;
                });
                _loadPackagesForBeneficiary(v);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _packageSelector() {
    return InkWell(
      onTap: _selectPackage,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: _selectorBox(),
        child: Row(
          children: [
            Icon(Icons.wifi, color: _green, size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                _package == null
                    ? 'Choose an internet package'
                    : '${_package!.name} · ₦${_package!.displayAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: _package == null ? _mutedDark : Colors.white,
                  fontSize: 15.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.chevron_right, color: _muted),
          ],
        ),
      ),
    );
  }

  BoxDecoration _selectorBox() => BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      );

  Widget _selectorSkeleton() => Container(
        padding: EdgeInsets.all(16.w),
        decoration: _selectorBox(),
        child: const Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(_green),
            ),
          ),
        ),
      );

  Widget _freqChip(String value, String label) {
    final selected = _frequency == value;
    return GestureDetector(
      onTap: () => setState(() => _frequency = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? _green : _bg,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: selected ? _green : _border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : _muted,
          ),
        ),
      ),
    );
  }

  Widget _dayOfWeekPicker() {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      children: List.generate(7, (i) {
        final day = i + 1; // 1 = Monday per backend convention
        final selected = _dayOfWeek == day;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _dayOfWeek = day),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: selected ? _green : _bg,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: selected ? _green : _border),
              ),
              child: Text(
                names[i],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : _muted,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _dayOfMonthPicker() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 1.2,
        ),
        // 1..28 — day 29/30/31 would skip in months without them, so
        // the backend treats those as "last day of month". Keeping
        // the picker to 28 avoids presenting a value that silently
        // drifts for the user.
        itemCount: 28,
        itemBuilder: (_, i) {
          final day = i + 1;
          final selected = _dayOfMonth == day;
          return GestureDetector(
            onTap: () => setState(() => _dayOfMonth = day),
            child: Container(
              decoration: BoxDecoration(
                color: selected ? _green : _bg,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: selected ? _green : _border),
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : _muted,
                  ),
                ),
              ),
            ),
          );
        },
      );
}

/// Bottom sheet showing packages for the selected ISP. Reads from
/// `InternetBillCubit` which was seeded by the parent screen — we
/// reuse that same cubit instance via `BlocProvider.value` so this
/// sheet doesn't double-fire the RPC.
class _PackagePickerSheet extends StatelessWidget {
  const _PackagePickerSheet();

  static const _bg = Color(0xFF0A0A0A);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            'Choose a Package',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 360.h),
            child: BlocBuilder<InternetBillCubit, InternetBillState>(
              buildWhen: (_, s) =>
                  s is InternetBillLoading ||
                  s is InternetPackagesLoaded ||
                  s is InternetBillError,
              builder: (context, state) {
                if (state is InternetBillLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(_green),
                    ),
                  );
                }
                if (state is InternetBillError) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      state.message,
                      style: TextStyle(color: _red, fontSize: 13.sp),
                    ),
                  );
                }
                final packages = state is InternetPackagesLoaded
                    ? state.packages
                    : const <InternetPackageEntity>[];
                if (packages.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      'No packages available for this ISP right now.',
                      style: TextStyle(color: _muted, fontSize: 13.sp),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: packages.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) {
                    final p = packages[i];
                    return InkWell(
                      onTap: () => Navigator.of(context).pop(p),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: _bg,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: _border),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (p.validity.isNotEmpty) ...[
                                    SizedBox(height: 2.h),
                                    Text(
                                      p.validity,
                                      style: TextStyle(
                                        color: _muted,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '₦${p.displayAmount.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: _green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
