import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/bill_auto_recharge_item.dart';
import '../../../../../core/widgets/bill_details_sheet.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../widgets/airtime_shimmer.dart';

/// Screen to manage auto-recharge schedules
class AirtimeAutoRechargeScreen extends StatefulWidget {
  const AirtimeAutoRechargeScreen({super.key});

  @override
  State<AirtimeAutoRechargeScreen> createState() => _AirtimeAutoRechargeScreenState();
}

class _AirtimeAutoRechargeScreenState extends State<AirtimeAutoRechargeScreen> {
  List<AirtimeAutoRecharge> _autoRecharges = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load beneficiaries first, then auto-recharges (via listener)
    context.read<AirtimeCubit>().loadBeneficiaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Auto-Recharge',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<AirtimeCubit, AirtimeState>(
        listener: (context, state) {
          if (state is AirtimeBeneficiariesLoaded) {
            // Beneficiaries loaded — now load auto-recharges.
            context.read<AirtimeCubit>().loadAutoRecharges();
          } else if (state is AirtimeAutoRechargesLoaded) {
            setState(() {
              _autoRecharges = state.autoRecharges;
              _isLoading = false;
            });
          } else if (state is AirtimeAutoRechargesLoading) {
            setState(() => _isLoading = true);
          } else if (state is AirtimeAutoRechargesError) {
            setState(() => _isLoading = false);
          } else if (state is AirtimeAutoRechargeUpdated) {
            // Patch the row in place — no full re-fetch / shimmer flash.
            // The cubit emits this immediately after the update RPC
            // resolves; we swap the old item out for the new one.
            setState(() {
              _autoRecharges = [
                for (final a in _autoRecharges)
                  if (a.id == state.autoRecharge.id)
                    state.autoRecharge
                  else
                    a,
              ];
            });
          } else if (state is AirtimeAutoRechargeStatusChanged) {
            // Pause/resume — patch the affected row's status only.
            setState(() {
              _autoRecharges = [
                for (final a in _autoRecharges)
                  if (a.id == state.id)
                    a.copyWith(status: state.status)
                  else
                    a,
              ];
            });
          } else if (state is AirtimeAutoRechargeDeleted) {
            // Filter the deleted id out — preserves scroll position.
            setState(() {
              _autoRecharges =
                  _autoRecharges.where((a) => a.id != state.id).toList();
            });
          } else if (state is AirtimeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        builder: (context, state) {
          if (_isLoading) {
            return AirtimeAutoRechargeShimmer(itemCount: 5);
          }

          if (state is AirtimeAutoRechargesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: const Color(0xFFEF4444),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () => context.read<AirtimeCubit>().loadAutoRecharges(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (_autoRecharges.isEmpty) {
            return _buildEmptyState();
          }

          return _buildAutoRechargesList();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.autorenew,
              size: 64.sp,
              color: const Color(0xFF4B5563),
            ),
            SizedBox(height: 16.h),
            Text(
              'No auto-recharge schedules',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Set up auto-recharge from an airtime purchase receipt, or open a saved contact and tap "Set Auto-Recharge".',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoRechargesList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _autoRecharges.length,
      itemBuilder: (context, index) {
        return _buildAutoRechargeItem(_autoRecharges[index]);
      },
    );
  }

  Widget _buildAutoRechargeItem(AirtimeAutoRecharge autoRecharge) {
    final isActive = autoRecharge.status.toLowerCase() == 'active';
    final networkColor = _getNetworkColor(autoRecharge.networkCode);

    // Parse execution time from nextRunDate
    int? execHour;
    int? execMinute;
    DateTime? nextRun;
    if (autoRecharge.nextRunDate.isNotEmpty) {
      try {
        final d = DateTime.parse(autoRecharge.nextRunDate).toLocal();
        nextRun = d;
        execHour = d.hour;
        execMinute = d.minute;
      } catch (_) {}
    }

    return BillAutoRechargeItem(
      title: autoRecharge.networkName.isNotEmpty
          ? autoRecharge.networkName
          : 'Unknown Network',
      subtitle: autoRecharge.phoneNumber,
      amount: autoRecharge.amount,
      frequency: autoRecharge.frequency,
      status: autoRecharge.status,
      nextRunDate: nextRun,
      executionHour: execHour,
      executionMinute: execMinute,
      leadingIcon: Icon(
        Icons.phone_android,
        color: isActive ? networkColor : networkColor.withValues(alpha: 0.5),
        size: 20.sp,
      ),
      // Tap on the row body opens the read-only details sheet
      // (shared with saved-contact "View Details") so the user can
      // see all the schedule metadata at a glance. Pause/Resume,
      // Edit, and Delete keep their own row actions.
      onTap: () => _showAutoRechargeDetailsSheet(autoRecharge),
      onPause: isActive
          ? () => context.read<AirtimeCubit>().pauseAutoRecharge(autoRecharge.id)
          : null,
      onResume: !isActive
          ? () => context.read<AirtimeCubit>().resumeAutoRecharge(autoRecharge.id)
          : null,
      onEdit: () => _showEditDialog(autoRecharge),
      onDelete: () => _showDeleteConfirmation(autoRecharge.id),
    );
  }

  /// Reuses the shared [BillDetailsSheet] so this screen and the saved
  /// contacts page show a visually identical sheet — the schedule
  /// payload (amount, frequency, schedule line, next run, status,
  /// failure count, etc.) is mapped into the same row format.
  void _showAutoRechargeDetailsSheet(AirtimeAutoRecharge ar) {
    final dateFormat = DateFormat('MMM dd, yyyy • HH:mm');
    final accent = _getNetworkColor(ar.networkCode);
    final isActive = ar.status.toLowerCase() == 'active';
    final statusColor = isActive
        ? const Color(0xFF10B981)
        : (ar.status.toLowerCase() == 'paused'
            ? const Color(0xFFFB923C)
            : const Color(0xFFEF4444));

    DateTime? parseIso(String iso) {
      try {
        return DateTime.parse(iso).toLocal();
      } catch (_) {
        return null;
      }
    }

    final nextRun = parseIso(ar.nextRunDate);
    final lastRun = ar.lastRunDate != null ? parseIso(ar.lastRunDate!) : null;

    String scheduleLine() {
      const days = [
        'Monday', 'Tuesday', 'Wednesday', 'Thursday',
        'Friday', 'Saturday', 'Sunday'
      ];
      switch (ar.frequency.toLowerCase()) {
        case 'weekly':
          final idx = ar.dayOfWeek.clamp(0, 6);
          return 'Every ${days[idx]}';
        case 'monthly':
          return 'Day ${ar.dayOfMonth} of each month';
        default:
          return 'Every day';
      }
    }

    final time =
        '${ar.executionHour.toString().padLeft(2, '0')}:${ar.executionMinute.toString().padLeft(2, '0')}';
    final cs = ar.currency == 'NGN' ? '₦' : '${ar.currency} ';

    BillDetailsSheet.show(
      context,
      title:
          ar.networkName.isNotEmpty ? ar.networkName : 'Auto-Recharge',
      subtitle: ar.phoneNumber,
      headerIcon: Icons.autorenew,
      headerColor: accent,
      rows: [
        BillDetailRow(
          icon: Icons.payments_outlined,
          label: 'Amount',
          value: '$cs${ar.amount.toStringAsFixed(0)}',
        ),
        BillDetailRow(
          icon: Icons.repeat,
          label: 'Schedule',
          value: '${scheduleLine()} at $time',
        ),
        if (nextRun != null)
          BillDetailRow(
            icon: Icons.event_outlined,
            label: 'Next run',
            value: dateFormat.format(nextRun),
          ),
        if (lastRun != null)
          BillDetailRow(
            icon: Icons.history,
            label: 'Last run',
            value: dateFormat.format(lastRun),
          ),
        BillDetailRow(
          icon: Icons.check_circle_outline,
          label: 'Status',
          value: ar.status[0].toUpperCase() + ar.status.substring(1),
          accent: statusColor,
        ),
        if (ar.failureCount > 0)
          BillDetailRow(
            icon: Icons.warning_amber_outlined,
            label: 'Failures',
            value: '${ar.failureCount} of ${ar.maxRetries} retries',
            accent: const Color(0xFFFB923C),
          ),
      ],
      primaryAction: BillDetailAction(
        icon: Icons.edit_outlined,
        label: 'Manage schedule',
        onTap: () {
          Get.back(); // close details sheet first
          _showEditDialog(ar);
        },
      ),
    );
  }

  Color _getNetworkColor(String? networkCode) {
    switch (networkCode?.toUpperCase()) {
      case 'MTN':
        return const Color(0xFFFFCB05);
      case 'AIRTEL':
        return const Color(0xFFED1C24);
      case 'GLO':
        return const Color(0xFF006634);
      case '9MOBILE':
        return const Color(0xFF00A651);
      default:
        return const Color(0xFF4E03D0);
    }
  }


  void _showEditDialog(AirtimeAutoRecharge autoRecharge) {
    final amountController = TextEditingController(
      text: autoRecharge.amount.toStringAsFixed(0),
    );
    String selectedFrequency = autoRecharge.frequency.isNotEmpty
        ? autoRecharge.frequency
        : 'monthly';

    // Parse execution time from nextRunDate or default to midnight
    TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);
    try {
      if (autoRecharge.nextRunDate.isNotEmpty) {
        final date = DateTime.parse(autoRecharge.nextRunDate);
        selectedTime = TimeOfDay(hour: date.hour, minute: date.minute);
      }
    } catch (e) {
      // Keep default midnight time
    }

    bool isLoading = false;

    final frequencies = [
      {'value': 'daily', 'label': 'Daily'},
      {'value': 'weekly', 'label': 'Weekly'},
      {'value': 'monthly', 'label': 'Monthly'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24.h,
          ),
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
              SizedBox(height: 20.h),
              Text(
                'Edit Auto-Recharge',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${autoRecharge.networkName} · ${autoRecharge.phoneNumber}',
                style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
              ),
              SizedBox(height: 24.h),
              // Amount field
              Text(
                'Amount (₦)',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Color(0xFF10B981)),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                    child: Text('₦', style: TextStyle(color: const Color(0xFF6B7280), fontSize: 16.sp)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
              ),
              SizedBox(height: 16.h),
              // Frequency selector
              Text(
                'Frequency',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: frequencies.map((f) {
                  final isSelected = selectedFrequency == f['value'];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setModalState(() => selectedFrequency = f['value']!),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: f['value'] != 'monthly' ? 8.w : 0,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF10B981).withValues(alpha: 0.15)
                              : const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF10B981)
                                : const Color(0xFF2D2D2D),
                          ),
                        ),
                        child: Text(
                          f['label']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? const Color(0xFF10B981)
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.h),
              // Time selector - NEW!
              Text(
                'Execution Time',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: ctx,
                    initialTime: selectedTime,
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Color(0xFF10B981),
                            surface: Color(0xFF1F1F1F),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setModalState(() => selectedTime = picked);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: const Color(0xFF10B981),
                        size: 20.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        _formatTime(selectedTime),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: const Color(0xFF9CA3AF),
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Auto-recharge will execute at this time on the scheduled frequency',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF6B7280),
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final amountStr = amountController.text.trim();
                          final amount = double.tryParse(amountStr);
                          if (amount == null || amount <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter a valid amount')),
                            );
                            return;
                          }
                          setModalState(() => isLoading = true);
                          try {
                            await context.read<AirtimeCubit>().updateAutoRecharge(
                              autoRechargeId: autoRecharge.id,
                              amount: amount,
                              frequency: selectedFrequency,
                              executionHour: selectedTime.hour,
                              executionMinute: selectedTime.minute,
                            );
                            if (ctx.mounted) Navigator.of(ctx).pop();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Auto-recharge updated'),
                                  backgroundColor: Color(0xFF10B981),
                                ),
                              );
                            }
                          } catch (e) {
                            setModalState(() => isLoading = false);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Delete Auto-Recharge',
          style: TextStyle(color: Colors.white, fontSize: 17.sp),
        ),
        content: Text(
          'Are you sure you want to delete this auto-recharge schedule?',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AirtimeCubit>().deleteAutoRecharge(id);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
