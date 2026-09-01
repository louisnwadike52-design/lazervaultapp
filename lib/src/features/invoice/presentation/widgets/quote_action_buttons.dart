import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';

/// Quote lifecycle actions for the details screen. Quotes are documents, not
/// payables: the receiver Accepts/Declines, the creator Converts to a payable
/// invoice (the backend rejects payment on quotes either way).
class QuoteActionButtons extends StatefulWidget {
  final Invoice invoice;
  final bool isSender;
  final bool isReceiver;
  final VoidCallback onChanged;

  const QuoteActionButtons({
    super.key,
    required this.invoice,
    required this.isSender,
    required this.isReceiver,
    required this.onChanged,
  });

  @override
  State<QuoteActionButtons> createState() => _QuoteActionButtonsState();
}

class _QuoteActionButtonsState extends State<QuoteActionButtons> {
  bool _busy = false;

  Future<void> _run(Future<Invoice> Function(InvoiceRepository repo) op, String successMessage) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await op(serviceLocator<InvoiceRepository>());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(successMessage), backgroundColor: InvoiceThemeColors.successGreen),
      );
      widget.onChanged();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_friendlyError(e)), backgroundColor: InvoiceThemeColors.errorRed),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _friendlyError(Object e) {
    final s = e.toString();
    if (s.contains('QUOTE_CONVERTED')) return 'This quote is already an invoice';
    if (s.contains('NOT_TAGGED')) return 'Only a tagged payer can respond to this quote';
    return 'Something went wrong. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;
    if (!invoice.isQuote) return const SizedBox.shrink();

    final children = <Widget>[_statusChip(invoice)];

    if (widget.isSender) {
      children.add(SizedBox(height: 12.h));
      children.add(SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _busy
              ? null
              : () => _run((repo) => repo.convertQuoteToInvoice(invoice.id), 'Quote converted to invoice'),
          icon: const Icon(Icons.receipt_long),
          label: Text(_busy ? 'Converting…' : 'Convert to Invoice'),
          style: ElevatedButton.styleFrom(
            backgroundColor: InvoiceThemeColors.primaryPurple,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
      ));
    }

    if (widget.isReceiver) {
      children.add(SizedBox(height: 12.h));
      children.add(Row(children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _busy || invoice.quoteStatus == 'accepted'
                ? null
                : () => _run((repo) => repo.respondToQuote(invoice.id, 'accept'), 'Quote accepted'),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Accept'),
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.successGreen,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _busy || invoice.quoteStatus == 'declined'
                ? null
                : () => _run((repo) => repo.respondToQuote(invoice.id, 'decline'), 'Quote declined'),
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Decline'),
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.errorRed,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
        ),
      ]));
    }

    children.add(SizedBox(height: 12.h));
    return Column(children: children);
  }

  Widget _statusChip(Invoice invoice) {
    final (label, color) = switch (invoice.quoteStatus) {
      'accepted' => ('Quote accepted - awaiting conversion', InvoiceThemeColors.successGreen),
      'declined' => ('Quote declined', InvoiceThemeColors.errorRed),
      _ => ('Quote - not payable until converted', InvoiceThemeColors.warningOrange),
    };
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(children: [
        Icon(Icons.request_quote, color: color, size: 18.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(color: color, fontSize: 13.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ]),
    );
  }
}
