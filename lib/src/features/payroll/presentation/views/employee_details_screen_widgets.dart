part of 'employee_details_screen.dart';

class _DetailRow {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);
}

/// An employee's pay history across all pay runs. Self-loads via the repository
/// (NOT the shared PayrollCubit that drives the details screen's remove/edit
/// states, so it can't clobber the surrounding screen). Each slip opens its
/// PaySlipDetailsScreen.
class _EmployeePayHistory extends StatefulWidget {
  final String employeeId;
  const _EmployeePayHistory({required this.employeeId});

  @override
  State<_EmployeePayHistory> createState() => _EmployeePayHistoryState();
}

class _EmployeePayHistoryState extends State<_EmployeePayHistory> {
  bool _loading = true;
  String? _error;
  List<PaySlipEntity> _slips = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await serviceLocator<PayrollRepository>()
          .listPaySlips(employeeId: widget.employeeId, limit: 50);
      if (!mounted) return;
      setState(() {
        _slips = result.paySlips;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _openSlip(PaySlipEntity slip) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<PayrollCubit>(),
          child: PaySlipDetailsScreen(paySlipId: slip.id),
        ),
      ),
    );
  }

  Color _statusColor(PaymentStatus s) {
    switch (s) {
      case PaymentStatus.paid:
        return InvoiceThemeColors.successGreen;
      case PaymentStatus.failed:
        return InvoiceThemeColors.errorRed;
      case PaymentStatus.pending:
        return InvoiceThemeColors.warningOrange;
    }
  }

  String _statusLabel(PaymentStatus s) {
    switch (s) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.pending:
        return 'Pending';
    }
  }

  String _fmtDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_outlined,
                  color: InvoiceThemeColors.primaryPurpleLight, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Pay History',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (!_loading && _error == null && _slips.isNotEmpty)
                Text(
                  '${_slips.length}',
                  style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400, fontSize: 13.sp),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          if (_loading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(child: LazerVaultLoader.small()),
            )
          else if (_error != null)
            Text(
              'Could not load pay history',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray500, fontSize: 13.sp),
            )
          else if (_slips.isEmpty)
            Text(
              'No pay slips yet',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray500, fontSize: 13.sp),
            )
          else
            ..._slips.asMap().entries.map(
                  (e) => _row(e.value, e.key == _slips.length - 1),
                ),
        ],
      ),
    );
  }

  Widget _row(PaySlipEntity slip, bool isLast) {
    final color = _statusColor(slip.paymentStatus);
    return GestureDetector(
      onTap: () => _openSlip(slip),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slip.formattedNet,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _fmtDate(slip.createdAt),
                    style: GoogleFonts.inter(
                        color: InvoiceThemeColors.textGray400, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                _statusLabel(slip.paymentStatus),
                style: GoogleFonts.inter(
                    color: color, fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right_rounded,
                color: InvoiceThemeColors.textGray500, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
