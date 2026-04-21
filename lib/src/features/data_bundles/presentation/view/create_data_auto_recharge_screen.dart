import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/entities/data_auto_recharge.dart';
import '../../domain/entities/data_beneficiary.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../cubit/data_auto_recharge_cubit.dart';
import '../cubit/data_auto_recharge_state.dart';
import '../cubit/data_beneficiary_cubit.dart';
import '../cubit/data_beneficiary_state.dart';
import '../cubit/data_bundles_cubit.dart';
import '../cubit/data_bundles_state.dart';

/// Create a new data Rollover schedule. Mirrors
/// `AirtimeAutoRechargeCreateSheet` but as a full screen since data
/// rollovers are variation-locked — the user must pick BOTH a saved
/// contact and a specific data plan, plus the cadence + execution time.
class CreateDataAutoRechargeScreen extends StatefulWidget {
  const CreateDataAutoRechargeScreen({super.key});

  @override
  State<CreateDataAutoRechargeScreen> createState() =>
      _CreateDataAutoRechargeScreenState();
}

class _CreateDataAutoRechargeScreenState
    extends State<CreateDataAutoRechargeScreen> {
  DataBeneficiary? _beneficiary;
  DataPlanEntity? _plan;
  String _frequency = 'monthly';
  int _dayOfMonth = 1;
  int _dayOfWeek = 1;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  bool _saving = false;

  /// When true the beneficiary picker is disabled (pre-filled from caller).
  bool _locked = false;

  /// Non-null when editing an existing auto-recharge.
  String? _editId;

  @override
  void initState() {
    super.initState();
    context.read<DataBeneficiaryCubit>().load();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _locked = args['locked'] == true;
      // Edit mode: pre-fill all fields from existing auto-recharge.
      final ar = args['autoRecharge'];
      if (ar is DataAutoRecharge) {
        _editId = ar.id;
        _frequency = ar.frequency.isNotEmpty ? ar.frequency : 'monthly';
        _dayOfWeek = ar.dayOfWeek > 0 ? ar.dayOfWeek : 1;
        _dayOfMonth = ar.dayOfMonth > 0 ? ar.dayOfMonth : 1;
        _time = TimeOfDay(hour: ar.executionHour, minute: ar.executionMinute);
        _locked = true; // editing always locks the beneficiary
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final b = args['beneficiary'];
        if (b is DataBeneficiary) setState(() => _beneficiary = b);
        // For edit mode, resolve beneficiary from the auto-recharge's linked
        // beneficiary object (if present).
        if (ar is DataAutoRecharge && ar.beneficiary != null) {
          setState(() => _beneficiary = ar.beneficiary);
        }
      });
    }
  }

  static const _validNetworks = ['mtn-data', 'airtel-data', 'glo-data', 'etisalat-data', 'mtn', 'airtel', 'glo', '9mobile', 'etisalat'];

  bool _isValidNetwork(String code) =>
      _validNetworks.contains(code.toLowerCase());

  Future<String?> _pickNetwork() async {
    const networks = [
      ('MTN', 'mtn-data'),
      ('Airtel', 'airtel-data'),
      ('Glo', 'glo-data'),
      ('9mobile', 'etisalat-data'),
    ];
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Network',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 16.h),
            ...networks.map((n) => ListTile(
                  leading: Icon(Icons.cell_tower,
                      color: const Color(0xFF4E03D0)),
                  title: Text(n.$1,
                      style: TextStyle(
                          color: Colors.white, fontSize: 15.sp)),
                  onTap: () => Navigator.of(ctx).pop(n.$2),
                )),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Future<void> _selectPlan() async {
    if (_beneficiary == null) {
      _snack('Pick a saved contact first', error: true);
      return;
    }

    String networkCode = _beneficiary!.networkCode;
    if (!_isValidNetwork(networkCode)) {
      final picked = await _pickNetwork();
      if (picked == null) return;
      networkCode = picked;
    }

    // Load plans for the beneficiary's network and present a picker.
    final cubit = context.read<DataBundlesCubit>();
    cubit.getDataPlans(network: networkCode);
    if (!mounted) return;
    final picked = await showModalBottomSheet<DataPlanEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _PlanPickerSheet(),
      ),
    );
    if (picked != null) setState(() => _plan = picked);
  }

  Future<void> _submit() async {
    if (_beneficiary == null) {
      _snack('Pick a saved contact', error: true);
      return;
    }
    if (_plan == null && _editId == null) {
      _snack('Pick a data plan', error: true);
      return;
    }
    setState(() => _saving = true);
    try {
      if (_editId != null) {
        await context.read<DataAutoRechargeCubit>().update(
              autoRechargeId: _editId!,
              variationId: _plan?.variationId,
              planName: _plan?.name,
              amount: _plan?.price,
              frequency: _frequency,
              dayOfWeek: _dayOfWeek,
              dayOfMonth: _dayOfMonth,
              executionHour: _time.hour,
              executionMinute: _time.minute,
            );
      } else {
        await context.read<DataAutoRechargeCubit>().create(
              beneficiaryId: _beneficiary!.id,
              variationId: _plan!.variationId,
              planName: _plan!.name,
              amount: _plan!.price,
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
    return BlocListener<DataAutoRechargeCubit, DataAutoRechargeState>(
      listener: (context, state) {
        if (state is DataAutoRechargeError && _saving) {
          setState(() => _saving = false);
          _snack(state.message, error: true);
        }
      },
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
          title: Text(_editId != null ? 'Edit Rollover' : 'Create Rollover',
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
                _label('Saved Contact'),
                SizedBox(height: 8.h),
                _beneficiarySelector(),
                SizedBox(height: 16.h),
                _label('Data Plan'),
                SizedBox(height: 8.h),
                _planSelector(),
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
                      color: const Color(0xFF0A0A0A),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFF2D2D2D)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time,
                            color: const Color(0xFF10B981), size: 18.sp),
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
                      backgroundColor: const Color(0xFF10B981),
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
                                ? 'Update Rollover'
                                : 'Schedule Rollover',
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

  Widget _label(String t) => Text(t,
      style: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFF9CA3AF),
          fontWeight: FontWeight.w500));

  Widget _beneficiarySelector() {
    // Locked mode: show a non-editable display of the pre-filled beneficiary.
    if (_locked && _beneficiary != null) {
      final b = _beneficiary!;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
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
                '${b.nickname ?? b.phoneNumber} \u00B7 ${b.networkName}',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    return BlocBuilder<DataBeneficiaryCubit, DataBeneficiaryState>(
      buildWhen: (_, s) => s is DataBeneficiariesLoaded,
      builder: (context, state) {
        if (state is! DataBeneficiariesLoaded) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
                ),
              ),
            ),
          );
        }
        final list = state.beneficiaries;
        if (list.isEmpty) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Text(
              'No saved contacts. Save one from a data purchase receipt first.',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DataBeneficiary>(
              isExpanded: true,
              value: _beneficiary,
              hint: Text('Select a contact',
                  style: TextStyle(
                      color: const Color(0xFF4B5563), fontSize: 15.sp)),
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF9CA3AF)),
              dropdownColor: const Color(0xFF1F1F1F),
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              items: list
                  .map((b) => DropdownMenuItem<DataBeneficiary>(
                        value: b,
                        child: Text(
                          '${b.nickname ?? b.phoneNumber} \u00B7 ${b.networkName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (v) => setState(() {
                _beneficiary = v;
                _plan = null;
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _planSelector() {
    return InkWell(
      onTap: _selectPlan,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(Icons.data_usage,
                color: const Color(0xFF10B981), size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                _plan == null
                    ? 'Choose a data plan'
                    : '${_plan!.name} \u00B7 ${_plan!.displayPrice}',
                style: TextStyle(
                  color: _plan == null
                      ? const Color(0xFF4B5563)
                      : Colors.white,
                  fontSize: 15.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
          ],
        ),
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
          color: selected ? const Color(0xFF10B981) : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                selected ? const Color(0xFF10B981) : const Color(0xFF2D2D2D),
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
                      ? const Color(0xFF10B981)
                      : const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: selected
                          ? const Color(0xFF10B981)
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
                    ? const Color(0xFF10B981)
                    : const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: selected
                        ? const Color(0xFF10B981)
                        : const Color(0xFF2D2D2D)),
              ),
              child: Center(
                child: Text('$day',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            selected ? Colors.white : const Color(0xFF9CA3AF))),
              ),
            ),
          );
        },
      );
}

/// Compact picker showing the data plans loaded for the selected
/// beneficiary's network. Wraps `DataBundlesCubit` (already in DI as a
/// factory) — caller passes a freshly-created instance via
/// `BlocProvider.value` so this sheet doesn't double-init network
/// requests.
class _PlanPickerSheet extends StatelessWidget {
  const _PlanPickerSheet();

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
          Text('Choose a Data Plan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 12.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 360.h),
            child: BlocBuilder<DataBundlesCubit, DataBundlesState>(
              buildWhen: (_, s) =>
                  s is DataBundlesLoading ||
                  s is DataPlansLoaded ||
                  s is DataBundlesError,
              builder: (context, state) {
                if (state is DataBundlesLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation(Color(0xFF10B981))));
                }
                if (state is DataBundlesError) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text(state.message,
                        style: TextStyle(
                            color: const Color(0xFFEF4444),
                            fontSize: 13.sp)),
                  );
                }
                final plans = state is DataPlansLoaded ? state.plans : const [];
                if (plans.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text('No plans available for this network',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp)),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: plans.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) {
                    final p = plans[i];
                    return InkWell(
                      onTap: () => Navigator.of(context).pop(p),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(10.r),
                          border:
                              Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(p.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(width: 12.w),
                            // displayPrice is already a formatted string
                            // ("₦500" / "₦500.50") — no numeric coercion.
                            Text(p.displayPrice,
                                style: TextStyle(
                                    color: const Color(0xFF10B981),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700)),
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

