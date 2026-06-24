import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/panic_balance_service.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Settings body for Panic Balance — a display-only decoy balance for unsafe
/// situations. Reactive to [PanicBalanceService] so the active/visible state and
/// preset list stay in sync. Editing here updates the service (which persists
/// locally and best-effort syncs the config to the backend).
class PanicBalanceSettings extends StatelessWidget {
  const PanicBalanceSettings({super.key});

  static const Color _primary = Color(0xFF3B82F6);
  static const Color _danger = Color(0xFFEF4444);
  static const Color _warn = Color(0xFFFB923C);

  PanicBalanceService get _panic => serviceLocator<PanicBalanceService>();

  String _currencySymbol() {
    try {
      return CurrencySymbols.getSymbol(
          serviceLocator<LocaleManager>().currentCurrency);
    } catch (_) {
      return '';
    }
  }

  String _formatAmount(double amount) =>
      NumberFormat('#,##0.##', 'en_US').format(amount);

  @override
  Widget build(BuildContext context) {
    final muted = Colors.grey[600];
    return ListenableBuilder(
      listenable: _panic,
      builder: (context, _) {
        final sym = _currencySymbol();
        final presets = _panic.presets;
        // Accordion bodies aren't padded by the container (each row self-pads),
        // so this raw-Column body must add its own horizontal padding to line
        // up with the other Settings sections.
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Show a fake balance to disguise your real money in unsafe "
              "situations. It's display-only — your real balance, transfers and "
              "limits are never affected, so a transfer still goes through normally.",
              style: GoogleFonts.inter(fontSize: 12.sp, color: muted, height: 1.4),
            ),
            SizedBox(height: 12.h),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Enable Panic Balance',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w600)),
              value: _panic.enabled,
              onChanged: (v) => _panic.setEnabled(v),
            ),
            if (_panic.enabled) ...[
              _infoBox(
                muted,
                Icons.info_outline,
                'To show or hide the decoy: long-press your balance, or shake '
                'your phone. It stays on until you toggle it off — even after '
                'closing and reopening the app.',
              ),
              if (_panic.isVisible)
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Row(
                    children: [
                      Icon(Icons.visibility_off_outlined,
                          size: 16.sp, color: _warn),
                      SizedBox(width: 6.w),
                      Text('Decoy is currently showing',
                          style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: _warn,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              SizedBox(height: 16.h),
              Text('Decoy amounts',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 2.h),
              Text('Pick which one shows when the decoy is triggered.',
                  style: GoogleFonts.inter(fontSize: 11.sp, color: muted)),
              SizedBox(height: 10.h),
              if (presets.isEmpty)
                _emptyState(context, muted)
              else ...[
                ...presets.map((p) => _presetRow(context, p, sym)),
                SizedBox(height: 6.h),
                OutlinedButton.icon(
                  onPressed: () => _showPresetDialog(context),
                  icon: Icon(Icons.add, size: 18.sp, color: _primary),
                  label: Text('Add decoy amount',
                      style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: _primary)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: _primary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                ),
              ],
            ],
          ],
          ),
        );
      },
    );
  }

  Widget _infoBox(Color? muted, IconData icon, String text) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: muted),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text,
                style:
                    GoogleFonts.inter(fontSize: 11.sp, color: muted, height: 1.4)),
          ),
        ],
      ),
    );
  }

  /// Empty state — makes it clear the feature is inert until a decoy exists
  /// (a stray shake/long-press does nothing with no presets).
  Widget _emptyState(BuildContext context, Color? muted) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _warn.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _warn.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, size: 16.sp, color: _warn),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Add at least one decoy amount so the panic balance can show '
                  'when you trigger it.',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: muted, height: 1.4),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showPresetDialog(context),
              icon: const Icon(Icons.add, size: 18),
              label: Text('Add decoy amount',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _presetRow(BuildContext context, PanicPreset p, String sym) {
    final active = _panic.activePreset?.label == p.label;
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: active ? _primary.withValues(alpha: 0.06) : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: active
              ? _primary.withValues(alpha: 0.5)
              : Colors.grey.withValues(alpha: 0.25),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () => _panic.setActivePreset(p.label),
        leading: Icon(
          active ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: active ? _primary : Colors.grey,
          size: 22.sp,
        ),
        title: Text(p.label,
            style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
        subtitle: Text('$sym${_formatAmount(p.amount)}',
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: Colors.grey[600])),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.edit_outlined, size: 18.sp),
              onPressed: () => _showPresetDialog(context, existing: p),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.delete_outline, size: 18.sp, color: _danger),
              onPressed: () => _confirmDelete(context, p),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, PanicPreset p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove decoy amount?'),
        content: Text('"${p.label}" will be removed from your decoy amounts.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Remove', style: TextStyle(color: _danger)),
          ),
        ],
      ),
    );
    if (ok == true) _panic.removePreset(p.label);
  }

  Future<void> _showPresetDialog(BuildContext context,
      {PanicPreset? existing}) async {
    final labelCtrl = TextEditingController(text: existing?.label ?? '');
    final amountCtrl = TextEditingController(
        text: existing != null ? _formatAmount(existing.amount) : '');
    final isEdit = existing != null;
    String? error;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(isEdit ? 'Edit decoy amount' : 'Add decoy amount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelCtrl,
                maxLength: 24,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Label',
                  hintText: 'e.g. Market, Travel',
                ),
              ),
              TextField(
                controller: amountCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Decoy amount',
                  hintText: 'e.g. 5000',
                ),
              ),
              if (error != null) ...[
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(error!,
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: _danger,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final label = labelCtrl.text.trim();
                final amount =
                    double.tryParse(amountCtrl.text.trim().replaceAll(',', ''));
                // Validation with inline feedback (no silent dismissal).
                if (label.isEmpty) {
                  setLocal(() => error = 'Enter a label.');
                  return;
                }
                if (amount == null || amount <= 0) {
                  setLocal(() => error = 'Enter an amount greater than 0.');
                  return;
                }
                // Block duplicate labels (case-insensitive), except the one
                // being edited.
                final clash = _panic.presets.any((e) =>
                    e.label.toLowerCase() == label.toLowerCase() &&
                    e.label != existing?.label);
                if (clash) {
                  setLocal(() => error = 'A decoy with this label already exists.');
                  return;
                }
                _panic.upsertPreset(
                  PanicPreset(label: label, amount: amount),
                  replaceLabel: existing?.label,
                );
                Navigator.of(ctx).pop();
              },
              child: Text(isEdit ? 'Save' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
