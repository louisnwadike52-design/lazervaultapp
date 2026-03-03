import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_obligation_entity.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';

class TaxObligationsScreen extends StatefulWidget {
  const TaxObligationsScreen({super.key});

  @override
  State<TaxObligationsScreen> createState() => _TaxObligationsScreenState();
}

class _TaxObligationsScreenState extends State<TaxObligationsScreen> {
  String _selectedFilter = 'All';

  static const _filterLabels = ['All', 'VAT', 'PAYE', 'WHT', 'CIT'];
  static const _filterToType = <String, int?>{
    'All': null,
    'VAT': 0,
    'PAYE': 1,
    'WHT': 2,
    'CIT': 3,
  };

  @override
  void initState() {
    super.initState();
    _loadObligations();
  }

  void _loadObligations() {
    final taxType = _filterToType[_selectedFilter];
    context.read<TaxCubit>().listObligations(taxType: taxType);
  }

  void _onFilterSelected(String label) {
    setState(() => _selectedFilter = label);
    _loadObligations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Tax Obligations',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildFilterChips(),
            SizedBox(height: 4.h),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(),
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Filter Chips
  // ---------------------------------------------------------------------------

  Widget _buildFilterChips() {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _filterLabels.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final label = _filterLabels[index];
          final isSelected = label == _selectedFilter;

          return GestureDetector(
            onTap: () => _onFilterSelected(label),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    return BlocConsumer<TaxCubit, TaxState>(
      listener: (context, state) {
        if (state is TaxError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
        if (state is ObligationCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Obligation created successfully'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadObligations();
        }
      },
      builder: (context, state) {
        if (state is TaxLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
            ),
          );
        }

        if (state is ObligationsLoaded) {
          if (state.obligations.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => _loadObligations(),
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemCount: state.obligations.length,
              itemBuilder: (context, index) =>
                  _buildObligationCard(state.obligations[index]),
            ),
          );
        }

        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Obligation Card
  // ---------------------------------------------------------------------------

  Widget _buildObligationCard(TaxObligationEntity obligation) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Colored left border
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                color: obligation.taxTypeColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: tax type + status badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              obligation.taxTypeDisplay,
                              style: GoogleFonts.inter(
                                color: obligation.taxTypeColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              obligation.period,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        _buildObligationStatusBadge(obligation),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // Amount
                    Text(
                      obligation.formattedAmount,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Due date row
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: const Color(0xFF9CA3AF),
                          size: 13.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Due ${_formatDate(obligation.dueDate)}',
                          style: GoogleFonts.inter(
                            color: obligation.isOverdue
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                            fontWeight: obligation.isOverdue
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        if (!obligation.isOverdue &&
                            obligation.status == TaxObligationStatus.pending) ...[
                          SizedBox(width: 8.w),
                          Text(
                            '\u2022',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            _daysLeftLabel(obligation.daysUntilDue),
                            style: GoogleFonts.inter(
                              color: obligation.daysUntilDue <= 7
                                  ? const Color(0xFFFB923C)
                                  : const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObligationStatusBadge(TaxObligationEntity obligation) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: obligation.statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        obligation.statusDisplay,
        style: GoogleFonts.inter(
          color: obligation.statusColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Create Obligation Dialog
  // ---------------------------------------------------------------------------

  void _showCreateDialog() {
    TaxType selectedType = TaxType.vat;
    final periodController = TextEditingController();
    final amountController = TextEditingController();
    final notesController = TextEditingController();
    DateTime? selectedDueDate;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                'New Obligation',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tax Type dropdown
                    Text(
                      'Tax Type',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFF2D2D2D)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<TaxType>(
                          value: selectedType,
                          isExpanded: true,
                          dropdownColor: const Color(0xFF1F1F1F),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: const Color(0xFF9CA3AF),
                            size: 20.sp,
                          ),
                          items: TaxType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(_taxTypeLabel(type)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => selectedType = value);
                            }
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Period
                    _buildDialogTextField(
                      label: 'Period',
                      hint: 'e.g. Q1 2026, Jan 2026',
                      controller: periodController,
                    ),

                    SizedBox(height: 16.h),

                    // Amount
                    _buildDialogTextField(
                      label: 'Amount (\u20A6)',
                      hint: '0.00',
                      controller: amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),

                    SizedBox(height: 16.h),

                    // Due Date
                    Text(
                      'Due Date',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: dialogContext,
                          initialDate:
                              selectedDueDate ?? DateTime.now().add(const Duration(days: 30)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 730)),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: const ColorScheme.dark(
                                  primary: Color(0xFF3B82F6),
                                  surface: Color(0xFF1F1F1F),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setDialogState(() => selectedDueDate = picked);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedDueDate != null
                                  ? _formatDate(selectedDueDate!)
                                  : 'Select date',
                              style: GoogleFonts.inter(
                                color: selectedDueDate != null
                                    ? Colors.white
                                    : const Color(0xFF6B7280),
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: const Color(0xFF9CA3AF),
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Notes
                    _buildDialogTextField(
                      label: 'Notes (optional)',
                      hint: 'Additional notes...',
                      controller: notesController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final period = periodController.text.trim();
                    final amountText = amountController.text.trim();
                    final amount = double.tryParse(amountText);

                    if (period.isEmpty ||
                        amount == null ||
                        amount <= 0 ||
                        selectedDueDate == null) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          content: const Text(
                              'Please fill in tax type, period, amount, and due date'),
                          backgroundColor: const Color(0xFFEF4444),
                        ),
                      );
                      return;
                    }

                    Navigator.of(dialogContext).pop();
                    context.read<TaxCubit>().createObligation(
                          taxType: selectedType.index,
                          period: period,
                          amount: (amount * 100).toInt(),
                          dueDate: '${selectedDueDate!.year}-${selectedDueDate!.month.toString().padLeft(2, '0')}-${selectedDueDate!.day.toString().padLeft(2, '0')}',
                          notes: notesController.text.trim(),
                        );
                  },
                  child: Text(
                    'Create',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDialogTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _taxTypeLabel(TaxType type) {
    switch (type) {
      case TaxType.vat:
        return 'VAT';
      case TaxType.paye:
        return 'PAYE';
      case TaxType.wht:
        return 'WHT';
      case TaxType.cit:
        return 'CIT';
    }
  }

  String _daysLeftLabel(int days) {
    if (days == 0) return 'Due today';
    if (days == 1) return '1 day left';
    return '$days days left';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadObligations(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.assignment_outlined,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No tax obligations',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap + to create a new obligation',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
