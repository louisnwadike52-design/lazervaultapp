import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/group_entities.dart';
import '../../cubit/create_contribution_cubit.dart';
import '../../cubit/create_contribution_state.dart';

/// Step 3: Schedule Settings (Frequency, Regular Amount, Start Date, Cycles)
class Step3Schedule extends StatefulWidget {
  const Step3Schedule({super.key});

  @override
  State<Step3Schedule> createState() => _Step3ScheduleState();
}

class _Step3ScheduleState extends State<Step3Schedule> {
  late TextEditingController _regularAmountController;
  late TextEditingController _totalCyclesController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateContributionCubit>();
    _regularAmountController = TextEditingController(
      text: cubit.regularAmount?.toStringAsFixed(2) ?? '',
    );
    _totalCyclesController = TextEditingController(
      text: cubit.totalCycles?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _regularAmountController.dispose();
    _totalCyclesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContributionCubit, CreateContributionState>(
      builder: (context, state) {
        final cubit = context.read<CreateContributionCubit>();
        final formState = state is CreateContributionFormUpdated ? state : null;
        final isRotatingSavings = formState?.type == ContributionType.rotatingSavings;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Schedule',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Set up how often members will contribute',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 32.h),

              // Payment Frequency
              _buildSectionLabel('Payment Frequency *'),
              SizedBox(height: 8.h),
              _buildFrequencySelector(
                selectedFrequency: formState?.frequency,
                onChanged: (frequency) => cubit.updateFrequency(frequency),
              ),
              SizedBox(height: 24.h),

              // Regular Payment Amount
              _buildSectionLabel('Regular Payment Amount *'),
              SizedBox(height: 8.h),
              _buildAmountField(
                controller: _regularAmountController,
                hint: 'Amount per member per cycle',
                onChanged: (value) {
                  final amount = double.tryParse(value);
                  cubit.updateRegularAmount(amount);
                },
              ),
              SizedBox(height: 24.h),

              // Start Date (Optional)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('Start Date'),
                        SizedBox(height: 8.h),
                        _buildDatePicker(
                          selectedDate: formState?.startDate ?? DateTime.now(),
                          onDateSelected: (date) => cubit.updateStartDate(date),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('Total Cycles'),
                        SizedBox(height: 8.h),
                        _buildIntegerField(
                          controller: _totalCyclesController,
                          hint: 'e.g., 12',
                          onChanged: (value) {
                            final cycles = int.tryParse(value);
                            cubit.updateTotalCycles(cycles);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (isRotatingSavings) ...[
                SizedBox(height: 32.h),
                Divider(color: Colors.grey[800], height: 1),
                SizedBox(height: 32.h),

                // Payout Rotation Order
                Text(
                  'Payout Rotation Order',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Drag to reorder who receives the payout each cycle',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildRotationOrderList(cubit, formState?.memberRotationOrder ?? []),
              ],

              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildFrequencySelector({
    ContributionFrequency? selectedFrequency,
    required ValueChanged<ContributionFrequency?> onChanged,
  }) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: ContributionFrequency.values.map((frequency) {
        final isSelected = frequency == selectedFrequency;
        return GestureDetector(
          onTap: () => onChanged(frequency),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF6366F1)
                    : const Color(0xFF2D2D2D),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              frequency.displayName,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF6366F1) : Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        color: Colors.white,
      ),
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
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
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
    );
  }

  Widget _buildIntegerField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        color: Colors.white,
      ),
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
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
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
    );
  }

  Widget _buildDatePicker({
    required DateTime selectedDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF6366F1),
                  surface: Color(0xFF1F1F1F),
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.grey[400],
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                DateFormat('MMM dd').format(selectedDate),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRotationOrderList(
    CreateContributionCubit cubit,
    List<String> memberOrder,
  ) {
    final groupMembers = cubit.groupMembers;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: memberOrder.length,
        onReorder: (oldIndex, newIndex) => cubit.reorderMember(oldIndex, newIndex),
        itemBuilder: (context, index) {
          final userId = memberOrder[index];
          final member = groupMembers.firstWhere(
            (m) => m.userId == userId,
            orElse: () => groupMembers.first,
          );

          return Container(
            key: ValueKey(userId),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: index < memberOrder.length - 1
                  ? Border(
                      bottom: BorderSide(
                        color: const Color(0xFF2D2D2D),
                        width: 1,
                      ),
                    )
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.drag_handle,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                CircleAvatar(
                  radius: 16.r,
                  backgroundColor: const Color(0xFF6366F1),
                  child: Text(
                    member.userName.isNotEmpty
                        ? member.userName[0].toUpperCase()
                        : 'U',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.userName,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        index == 0 ? 'First to receive payout' : 'Position ${index + 1}',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
