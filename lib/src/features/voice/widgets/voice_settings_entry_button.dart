/// Drop-in entry button for per-service voice/chat assistant settings.
///
/// Any feature screen that wants to expose "Voice Assistant Settings"
/// for its own service drops this:
///
///     VoiceSettingsEntryButton(serviceName: 'crypto')
///
/// Tap pushes PerServiceVoiceSettingsScreen wrapped in a fresh
/// BlocProvider — keeps scope tight so the cubit dies when the
/// screen pops.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/per_service_voice_settings_cubit.dart';
import '../models/per_service_voice_settings.dart';
import '../screens/per_service_voice_settings_screen.dart';

class VoiceSettingsEntryButton extends StatelessWidget {
  final String serviceName;

  /// Optional explicit factory for the cubit. Default builds it with
  /// SharedPreferences-backed storage + no remote sync. Tests inject
  /// a fake.
  final PerServiceVoiceSettingsCubit Function()? cubitFactory;

  const VoiceSettingsEntryButton({
    super.key,
    required this.serviceName,
    this.cubitFactory,
  });

  PerServiceVoiceSettingsCubit _defaultCubit() {
    return PerServiceVoiceSettingsCubit(
      serviceName: serviceName,
      storage: SharedPrefsPerServiceVoiceSettingsStorage(),
    );
  }

  void _open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<PerServiceVoiceSettingsCubit>(
          create: (_) {
            final c = (cubitFactory ?? _defaultCubit).call();
            c.load();
            return c;
          },
          child: PerServiceVoiceSettingsScreen(serviceName: serviceName),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey('voice_settings_entry_$serviceName'),
      onTap: () => _open(context),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                Icons.record_voice_over_outlined,
                color: const Color(0xFF3B82F6),
                size: 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voice & chat assistant settings',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Language, voice, and prompt hints for '
                    '${labelForChatService(serviceName)}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.55),
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
