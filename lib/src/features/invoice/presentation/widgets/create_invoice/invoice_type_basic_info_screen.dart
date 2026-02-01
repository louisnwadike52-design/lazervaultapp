import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/invoice_entity.dart';
import '../../cubit/create_invoice_cubit.dart';

/// Screen 1: Invoice Type & Basic Information
///
/// Allows user to select invoice type, enter title, description, and due date
class InvoiceTypeBasicInfoScreen extends StatefulWidget {
  const InvoiceTypeBasicInfoScreen({super.key});

  @override
  State<InvoiceTypeBasicInfoScreen> createState() =>
      _InvoiceTypeBasicInfoScreenState();
}

class _InvoiceTypeBasicInfoScreenState
    extends State<InvoiceTypeBasicInfoScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    // Initialize controllers with current cubit values
    final cubit = context.read<CreateInvoiceCubit>();
    _titleController = TextEditingController(text: cubit.title);
    _descriptionController = TextEditingController(text: cubit.description);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 32.h),
            _buildInvoiceTypeSection(),
            SizedBox(height: 32.h),
            _buildBasicInfoSection(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invoice Type & Details',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Select the type of invoice and provide basic information',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildInvoiceTypeSection() {
    return BlocBuilder<CreateInvoiceCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreateInvoiceCubit>();
        final currentType = cubit.invoiceType;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                _buildTypeCard(
                  InvoiceType.invoice,
                  'Invoice',
                  Icons.receipt_long,
                  currentType,
                ),
                _buildTypeCard(
                  InvoiceType.quote,
                  'Quote',
                  Icons.request_quote,
                  currentType,
                ),
                _buildTypeCard(
                  InvoiceType.request,
                  'Request',
                  Icons.payment,
                  currentType,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeCard(
    InvoiceType type,
    String label,
    IconData icon,
    InvoiceType currentType,
  ) {
    final isSelected = type == currentType;

    return GestureDetector(
      onTap: () {
        context.read<CreateInvoiceCubit>().updateInvoiceType(type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 105.w,
        height: 105.w,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36.sp,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return BlocBuilder<CreateInvoiceCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreateInvoiceCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              controller: _titleController,
              label: 'Title *',
              hint: 'e.g., Website Development Services',
              onChanged: (value) => cubit.updateTitle(value),
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              controller: _descriptionController,
              label: 'Description *',
              hint: 'Brief description of the invoice',
              maxLines: 3,
              onChanged: (value) => cubit.updateDescription(value),
            ),
            SizedBox(height: 16.h),
            _buildDueDateField(cubit),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDueDateField(CreateInvoiceCubit cubit) {
    final dueDate = cubit.dueDate;
    final formattedDate = dueDate != null
        ? DateFormat('MMM dd, yyyy').format(dueDate)
        : 'Select due date';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date (Optional)',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _selectDueDate(context, cubit),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    formattedDate,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: dueDate != null ? Colors.white : Colors.grey[600],
                    ),
                  ),
                ),
                if (dueDate != null)
                  GestureDetector(
                    onTap: () => cubit.updateDueDate(null),
                    child: Icon(
                      Icons.clear,
                      size: 20.sp,
                      color: Colors.grey[400],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDueDate(
    BuildContext context,
    CreateInvoiceCubit cubit,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: cubit.dueDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ), dialogTheme: DialogThemeData(backgroundColor: const Color(0xFF1A1A1A)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      cubit.updateDueDate(picked);
    }
  }
}
