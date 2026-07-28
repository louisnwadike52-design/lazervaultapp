import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/utils/logger.dart';
import '../services/voice_settings_service.dart';

/// Per-user voice transaction-PIN controls, reusable on the voice settings screen
/// and the general app settings page. Reads/writes the override through
/// [VoiceSettingsService] (voice gateway → auth-service). When the PIN is turned
/// off here, voice money moves complete without any on-screen PIN.
class VoiceTxPinSection extends StatefulWidget {
  const VoiceTxPinSection({super.key});

  @override
  State<VoiceTxPinSection> createState() => _VoiceTxPinSectionState();
}

class _VoiceTxPinSectionState extends State<VoiceTxPinSection> {
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _primary = Color(0xFF3B82F6);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  final VoiceSettingsService _service = VoiceSettingsService();
  final TextEditingController _thresholdController = TextEditingController();

  bool _loading = true;
  bool _saving = false;
  // True once the user edits the "skip PIN below" amount away from the saved
  // value — reveals the explicit Save CTA. The threshold is NEVER persisted on
  // keystroke or keyboard-done; only the CTA tap commits it.
  bool _thresholdDirty = false;
  VoiceTxPinSettings? _settings;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _thresholdController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final s = await _service.getTxPinSettings();
    if (!mounted) return;
    setState(() {
      _settings = s ?? const VoiceTxPinSettings();
      _loading = false;
      final thresholdKobo = _settings!.effectiveThresholdKobo;
      _thresholdController.text =
          thresholdKobo > 0 ? (thresholdKobo ~/ 100).toString() : '';
      _thresholdDirty = false;
    });
  }

  /// Persist the amount currently typed in the "skip PIN below" field. Only ever
  /// called from the explicit Save CTA (never on keystroke / keyboard-done).
  Future<void> _saveThreshold() async {
    final naira = int.tryParse(_thresholdController.text.trim()) ?? 0;
    await _save(requirePin: true, thresholdKobo: naira > 0 ? naira * 100 : 0);
  }

  Future<void> _save({
    required bool? requirePin,
    required int? thresholdKobo,
    String? entryMode,
  }) async {
    setState(() => _saving = true);
    final ok = await _service.updateTxPinSettings(
      requirePin: requirePin,
      thresholdKobo: thresholdKobo,
      entryMode: entryMode,
    );
    if (!mounted) return;
    if (ok) {
      // Reflect the saved override locally without a round-trip. entry_mode is only
      // touched when explicitly passed, so a require_pin/threshold save preserves it.
      setState(() {
        _settings = VoiceTxPinSettings(
          requirePin: requirePin,
          thresholdKobo: thresholdKobo,
          entryMode: entryMode ?? (_settings?.entryMode ?? ''),
          adminRequirePin: _settings?.adminRequirePin ?? false,
          adminThresholdKobo: _settings?.adminThresholdKobo ?? 0,
          adminEntryMode: _settings?.adminEntryMode ?? 'sheet',
        );
        _thresholdDirty = false;
      });
      // Observability: confirm from real devices that the per-user voice-PIN
      // override persisted (it feeds voice-agent-gateway's _voice_txpin_policy,
      // which skips the PIN for amounts <= threshold_kobo).
      AppLogger.event('voice_txpin_settings', 'saved', fields: {
        'require_pin': requirePin,
        'threshold_kobo': thresholdKobo,
        if (entryMode != null) 'entry_mode': entryMode,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: _primary,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Saved',
            style: GoogleFonts.inter(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save. Please try again.')),
      );
    }
    if (mounted) setState(() => _saving = false);
  }

  Widget _entryModeChip({
    required String label,
    required bool selected,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: selected ? _primary.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: selected ? _primary : _divider),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? Colors.white : _textSecondary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16.r),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          height: 20.w,
          width: 20.w,
          child: const CircularProgressIndicator(strokeWidth: 2, color: _primary),
        ),
      );
    }

    final s = _settings!;
    final requirePin = s.effectiveRequirePin;
    final entryMode = s.effectiveEntryMode;
    final usingDefault =
        s.requirePin == null && s.thresholdKobo == null && s.entryMode.isEmpty;

    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            activeColor: _primary,
            value: requirePin,
            onChanged: _saving
                ? null
                : (v) => _save(
                      requirePin: v,
                      thresholdKobo: s.thresholdKobo,
                    ),
            title: Text(
              'Ask for my PIN in voice',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              requirePin
                  ? 'You confirm voice money moves with your PIN.'
                  : 'Voice money moves complete without a PIN.',
              style: GoogleFonts.inter(fontSize: 12.sp, color: _textSecondary),
            ),
          ),
          if (requirePin) ...[
            Divider(color: _divider, height: 1),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Skip PIN below',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Small voice payments at or below this amount skip the PIN. Leave empty to always ask.',
                          style: GoogleFonts.inter(fontSize: 11.sp, color: _textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  SizedBox(
                    width: 96.w,
                    child: TextField(
                      controller: _thresholdController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        prefixText: '₦ ',
                        prefixStyle: GoogleFonts.inter(color: _textSecondary, fontSize: 14.sp),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: _divider),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: _primary),
                        ),
                      ),
                      // Never persist on keystroke or keyboard-done — just mark
                      // the field dirty so the Save CTA appears. Committing is
                      // an explicit tap on Save.
                      onChanged: (_) {
                        if (!_thresholdDirty) {
                          setState(() => _thresholdDirty = true);
                        }
                      },
                    ),
                  ),
                ],
              ),
              // Clean themed Save CTA — only shown once the amount is edited,
              // and the ONLY thing that persists the threshold.
              if (_thresholdDirty) ...[
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _saveThreshold,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      disabledBackgroundColor: _primary.withValues(alpha: 0.4),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _saving
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Save amount',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
                ],
              ),
            ),
          ],
          if (requirePin) ...[
            Divider(color: _divider, height: 1),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PIN entry',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'How you confirm a voice money move when a PIN is asked.',
                    style: GoogleFonts.inter(fontSize: 11.sp, color: _textSecondary),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: _entryModeChip(
                          label: 'Enter PIN on screen',
                          selected: entryMode == 'sheet',
                          onTap: _saving || entryMode == 'sheet'
                              ? null
                              : () => _save(
                                    requirePin: s.requirePin,
                                    thresholdKobo: s.thresholdKobo,
                                    entryMode: 'sheet',
                                  ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _entryModeChip(
                          label: 'Say my PIN',
                          selected: entryMode == 'voice',
                          onTap: _saving || entryMode == 'voice'
                              ? null
                              : () => _save(
                                    requirePin: s.requirePin,
                                    thresholdKobo: s.thresholdKobo,
                                    entryMode: 'voice',
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          if (!usingDefault) ...[
            Divider(color: _divider, height: 1),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _saving
                    ? null
                    : () {
                        _thresholdController.clear();
                        _save(
                          requirePin: null,
                          thresholdKobo: null,
                          entryMode: '',
                        );
                      },
                child: Text(
                  'Use platform default',
                  style: GoogleFonts.inter(fontSize: 12.sp, color: _primary),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
