part of 'sales_list_screen.dart';

/// Themed bottom sheet showing the full details of a single [SaleEntity].
class _SaleDetailSheet extends StatelessWidget {
  const _SaleDetailSheet({required this.sale});

  final SaleEntity sale;

  static const _card = InvoiceThemeColors.secondaryBackground;
  static const _border = InvoiceThemeColors.borderColor;
  static const _accent = InvoiceThemeColors.primaryPurple;
  static const _accentText = InvoiceThemeColors.primaryPurpleLight;
  static const _green = InvoiceThemeColors.successGreen;
  static const _amber = Color(0xFFFB923C);
  static const _label = InvoiceThemeColors.textGray400;

  String _money(int kobo) => '₦${(kobo / 100).toStringAsFixed(2)}';

  String _fmtDateTime(String iso) {
    final d = DateTime.tryParse(iso);
    if (d == null) return '';
    return DateFormat('d MMM y, h:mm a').format(d.toLocal());
  }

  String _prettyMethod(String m) {
    if (m.isEmpty) return '';
    final cleaned = m.replaceAll('_', ' ').trim();
    return cleaned
        .split(' ')
        .where((w) => w.isNotEmpty)
        .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final paid = sale.status == 'PAID';
    final chipColor = paid ? _green : _amber;
    final title = sale.itemName.isNotEmpty
        ? sale.itemName
        : (sale.description.isNotEmpty ? sale.description : 'Sale');
    final who = sale.customerName.isNotEmpty ? sale.customerName : 'Walk-in';
    final date = _fmtDateTime(sale.createdAt);
    final method = _prettyMethod(sale.paymentMethod);

    final rows = <Widget>[
      if (sale.quantity > 0) _row('Quantity', '${sale.quantity}'),
      if (sale.unitPrice > 0) _row('Unit price', _money(sale.unitPrice)),
      _row('Amount', _money(sale.amount), valueColor: _accentText, bold: true),
      _row('Customer', who),
      if (method.isNotEmpty) _row('Payment method', method),
      _row('Status', paid ? 'Paid' : 'Unpaid', valueColor: chipColor),
      if (date.isNotEmpty) _row('Date', date),
      if (sale.reference.isNotEmpty) _row('Reference', sale.reference),
    ];

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: _border,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.point_of_sale_rounded,
                        color: _accentText, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: chipColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(paid ? 'Paid' : 'Receivable',
                        style: GoogleFonts.inter(
                            color: chipColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.primaryBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: _border),
                ),
                child: Column(children: rows),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value,
      {Color valueColor = Colors.white, bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.inter(color: _label, fontSize: 13.sp)),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.right,
                style: GoogleFonts.inter(
                    color: valueColor,
                    fontSize: 13.5.sp,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
