part of 'employee_list_screen.dart';

// ---------------------------------------------------------------------------
// Employee Details Bottom Sheet
// ---------------------------------------------------------------------------

class _EmployeeDetailsSheet extends StatelessWidget {
  final EmployeeEntity employee;

  const _EmployeeDetailsSheet({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.85.sh),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.tertiaryBackground,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          CircleAvatar(
            radius: 32.r,
            backgroundColor:
                InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
            child: Text(
              employee.fullName.isNotEmpty
                  ? employee.fullName[0].toUpperCase()
                  : '?',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.primaryPurpleLight,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            employee.fullName,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${employee.department}${employee.department.isNotEmpty && employee.jobTitle.isNotEmpty ? ' - ' : ''}${employee.jobTitle}',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Divider(color: InvoiceThemeColors.borderColor, height: 1.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  _buildDetailRow('Email', employee.email),
                  _buildDetailRow('Phone', employee.phone),
                  _buildDetailRow('NIN', employee.nin),
                  _buildDetailRow('Status', employee.statusDisplay),
                  _buildDetailRow(
                      'Employment Type', employee.employmentTypeDisplay),
                  _buildDetailRow('Pay Rate', employee.formattedPayRate),
                  _buildDetailRow('Pay Frequency', employee.payFrequencyDisplay),
                  _buildDetailRow('Payout',
                      employee.isInternalPayout ? 'Lazervault wallet' : 'Bank transfer'),
                  if (!employee.isInternalPayout) ...[
                    _buildDetailRow('Bank', employee.bankName),
                    _buildDetailRow('Account No.', employee.bankAccountNumber),
                    _buildDetailRow('Account Name', employee.bankAccountName),
                  ],
                  if (employee.startDate != null)
                    _buildDetailRow('Start Date', employee.startDate!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
