import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/voice/cubit/voice_settings_cubit.dart';
import 'package:lazervault/src/features/voice/models/voice_settings_models.dart'
    as settings_models;
import 'package:lazervault/src/features/voice/services/voice_settings_service.dart';

/// Voice Settings Screen
///
/// Allows users to manage voice language, voice selection, and voice enrollment.
class VoiceSettingsScreen extends StatefulWidget {
  const VoiceSettingsScreen({super.key});

  @override
  State<VoiceSettingsScreen> createState() => _VoiceSettingsScreenState();
}

class _VoiceSettingsScreenState extends State<VoiceSettingsScreen> {
  String? _selectedLanguageCode;
  String? _selectedVoiceId;
  List<settings_models.VoiceOption> _voicesForLanguage = [];
  bool _loadingVoices = false;
  bool _isEnrolled = false;
  bool _loadingEnrollment = true;
  double? _enrollmentQualityScore;
  int? _enrollmentSamplesCount;
  settings_models.CustomVoiceStatus? _customVoiceStatus;
  bool _loadingCustomVoice = false;
  bool _togglingCustomVoice = false;
  Timer? _pendingStatusTimer;

  static const String _prefKeyLanguage = 'voice_selected_language';
  static const String _prefKeyVoice = 'voice_selected_voice_id';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    // Check for partial enrollment progress
    final savedSamples = prefs.getStringList('voice_enrollment_samples');
    setState(() {
      _selectedLanguageCode = prefs.getString(_prefKeyLanguage);
      _selectedVoiceId = prefs.getString(_prefKeyVoice);
      _hasPartialProgress = savedSamples != null && savedSamples.isNotEmpty;
    });

    // Check enrollment status from backend (single source of truth)
    await _checkEnrollmentFromBackend();
    if (!mounted) return;

    // Load voices for current language
    if (_selectedLanguageCode != null) {
      _loadVoicesForLanguage(_selectedLanguageCode!);
    }

    // Load custom voice status if enrolled (cloning is cross-lingual)
    if (_isEnrolled) {
      _loadCustomVoiceStatus();
    }
  }

  @override
  void dispose() {
    _pendingStatusTimer?.cancel();
    super.dispose();
  }

  /// Query the backend for voice enrollment status.
  /// This is the single source of truth — not SharedPreferences.
  Future<void> _checkEnrollmentFromBackend() async {
    setState(() => _loadingEnrollment = true);
    try {
      final userId = _getCurrentUserId();
      if (userId == null || userId.isEmpty) {
        setState(() {
          _isEnrolled = false;
          _loadingEnrollment = false;
        });
        return;
      }

      final voiceBiometricsService = GetIt.I<VoiceBiometricsService>();
      final status = await voiceBiometricsService.checkEnrollmentStatus(userId);
      if (mounted) {
        setState(() {
          _isEnrolled = status.isEnrolled;
          _enrollmentQualityScore = status.qualityScore;
          _enrollmentSamplesCount = status.samplesCount;
          _loadingEnrollment = false;
        });
      }
    } catch (e) {
      print('VoiceSettings: Error checking enrollment: $e');
      if (mounted) {
        setState(() {
          _isEnrolled = false;
          _loadingEnrollment = false;
        });
      }
    }
  }

  String? _getCurrentUserId() {
    try {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        return authState.profile.userId;
      }
    } catch (_) {}
    return null;
  }

  Future<void> _loadCustomVoiceStatus() async {
    setState(() => _loadingCustomVoice = true);
    try {
      final userId = _getCurrentUserId();
      if (userId == null || userId.isEmpty) {
        if (mounted) setState(() => _loadingCustomVoice = false);
        return;
      }

      final voiceService = VoiceSettingsService();
      final status = await voiceService.getCustomVoiceStatus(userId);
      if (mounted) {
        setState(() {
          _customVoiceStatus = status;
          _loadingCustomVoice = false;
        });
        // Auto-refresh while status is pending
        _managePendingPoll();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingCustomVoice = false);
      }
    }
  }

  void _managePendingPoll() {
    final statusText = _customVoiceStatus?.customVoiceStatus ?? 'none';
    if (statusText == 'pending') {
      // Start polling every 10 seconds
      _pendingStatusTimer?.cancel();
      _pendingStatusTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        if (!mounted) {
          timer.cancel();
          return;
        }
        try {
          final userId = _getCurrentUserId();
          if (userId == null || userId.isEmpty) return;

          final voiceService = VoiceSettingsService();
          final status = await voiceService.getCustomVoiceStatus(userId);
          if (!mounted) return;
          setState(() => _customVoiceStatus = status);

          final newStatus = status?.customVoiceStatus;
          if (newStatus != 'pending') {
            timer.cancel();
            _pendingStatusTimer = null;
          }
        } catch (_) {
          // Keep polling
        }
      });
    } else {
      // Not pending — stop polling
      _pendingStatusTimer?.cancel();
      _pendingStatusTimer = null;
    }
  }

  Future<void> _toggleCustomVoice(bool enabled) async {
    if (!mounted) return;
    setState(() => _togglingCustomVoice = true);
    try {
      final userId = _getCurrentUserId();
      if (userId == null || userId.isEmpty) {
        if (mounted) setState(() => _togglingCustomVoice = false);
        return;
      }

      final voiceService = VoiceSettingsService();
      final success = await voiceService.setCustomVoiceEnabled(userId, enabled);
      if (success && mounted) {
        await _loadCustomVoiceStatus();
      }
    } finally {
      if (mounted) {
        setState(() => _togglingCustomVoice = false);
      }
    }
  }

  /// Track which language load is in flight to avoid out-of-order responses
  String? _voiceLoadRequestLanguage;

  Future<void> _loadVoicesForLanguage(String languageCode) async {
    _voiceLoadRequestLanguage = languageCode;
    if (!mounted) return;
    setState(() => _loadingVoices = true);
    try {
      final voiceService = VoiceSettingsService();
      final voices = await voiceService.getVoicesForLanguage(languageCode);
      // Only apply result if this is still the most recent request
      if (mounted && _voiceLoadRequestLanguage == languageCode) {
        setState(() {
          _voicesForLanguage = voices;
          _loadingVoices = false;
        });
      }
    } catch (e) {
      if (mounted && _voiceLoadRequestLanguage == languageCode) {
        setState(() => _loadingVoices = false);
      }
    }
  }

  Future<void> _saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKeyLanguage, code);
    await prefs.remove(_prefKeyVoice); // Clear voice pref before updating state
    if (!mounted) return;
    setState(() {
      _selectedLanguageCode = code;
      _selectedVoiceId = null; // Reset voice when language changes
      _voicesForLanguage = [];
    });
    _loadVoicesForLanguage(code);
  }

  Future<void> _saveVoice(String voiceId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKeyVoice, voiceId);
    setState(() => _selectedVoiceId = voiceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Voice Settings',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<VoiceSettingsCubit, VoiceSettingsState>(
        builder: (context, state) {
          if (state is VoiceSettingsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
              ),
            );
          }

          if (state is VoiceSettingsError) {
            return _buildError(state.message);
          }

          if (state is VoiceSettingsLoaded) {
            return _buildSettings(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 16.h),
            Text(
              message,
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () =>
                  context.read<VoiceSettingsCubit>().loadLanguages(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettings(BuildContext context, VoiceSettingsLoaded state) {
    final languages = state.languages;
    final selectedLang = _selectedLanguageCode != null
        ? languages
            .where((l) => l.code == _selectedLanguageCode)
            .firstOrNull
        : null;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      children: [
        // Voice Enrollment Section
        _buildSectionHeader('Voice Enrollment'),
        SizedBox(height: 8.h),
        _buildEnrollmentCard(),
        SizedBox(height: 28.h),

        // Custom Voice Section (shown for all enrolled users — cloning is cross-lingual)
        if (_isEnrolled) ...[
          _buildSectionHeader('Custom Voice Cloning'),
          SizedBox(height: 4.h),
          Text(
            'Have the assistant respond in your own cloned voice. '
            'This is separate from voice recognition (above) which verifies your identity.',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          _buildCustomVoiceCard(),
          SizedBox(height: 28.h),
        ],

        // Language Section
        _buildSectionHeader('Voice Language'),
        SizedBox(height: 8.h),
        _buildLanguageSelector(languages, selectedLang),
        SizedBox(height: 28.h),

        // Voice Section
        _buildSectionHeader('Assistant Voice'),
        SizedBox(height: 4.h),
        Text(
          'Choose the voice your assistant speaks with',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 12.h),
        if (_selectedLanguageCode == null)
          _buildPlaceholderCard(
            icon: Icons.record_voice_over_rounded,
            text: 'Select a language first to see available voices',
          )
        else if (_loadingVoices)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
                strokeWidth: 2,
              ),
            ),
          )
        else if (_voicesForLanguage.isEmpty)
          _buildPlaceholderCard(
            icon: Icons.voice_over_off_rounded,
            text: 'No voices available for this language',
          )
        else
          ..._voicesForLanguage.map((voice) => _buildVoiceTile(voice)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildEnrollmentCard() {
    if (_loadingEnrollment) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: const CircularProgressIndicator(
                color: Color.fromARGB(255, 78, 3, 208),
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 14.w),
            Text(
              'Checking enrollment status...',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      );
    }

    // Check for partial enrollment (saved progress but not completed)
    final hasPartialProgress = _checkPartialEnrollmentProgress();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: _isEnrolled
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : hasPartialProgress
                  ? const Color(0xFFFB923C).withValues(alpha: 0.3)
                  : const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Voice Recognition Status Row
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: _isEnrolled
                      ? const Color(0xFF10B981).withValues(alpha: 0.15)
                      : hasPartialProgress
                          ? const Color(0xFFFB923C).withValues(alpha: 0.15)
                          : const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isEnrolled
                      ? Icons.verified_user_rounded
                      : hasPartialProgress
                          ? Icons.pending_rounded
                          : Icons.fingerprint_rounded,
                  color: _isEnrolled
                      ? const Color(0xFF10B981)
                      : hasPartialProgress
                          ? const Color(0xFFFB923C)
                          : const Color.fromARGB(255, 78, 3, 208),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isEnrolled
                          ? 'Voice Recognition'
                          : hasPartialProgress
                              ? 'Partially Enrolled'
                              : 'Voice Not Enrolled',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _isEnrolled
                          ? 'Your voice is registered for secure transactions'
                          : hasPartialProgress
                              ? 'Enrollment was interrupted. Resume to complete setup.'
                              : 'Set up voice biometrics for secure banking',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _isEnrolled
                      ? const Color(0xFF10B981).withValues(alpha: 0.15)
                      : hasPartialProgress
                          ? const Color(0xFFFB923C).withValues(alpha: 0.15)
                          : const Color(0xFF9CA3AF).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  _isEnrolled
                      ? 'Active'
                      : hasPartialProgress
                          ? 'Incomplete'
                          : 'Not Set Up',
                  style: GoogleFonts.inter(
                    color: _isEnrolled
                        ? const Color(0xFF10B981)
                        : hasPartialProgress
                            ? const Color(0xFFFB923C)
                            : const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Quality score indicator (when enrolled)
          if (_isEnrolled && _enrollmentQualityScore != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.graphic_eq_rounded,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Voice Quality: ${(_enrollmentQualityScore! * 100).toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (_enrollmentSamplesCount != null) ...[
                    SizedBox(width: 12.w),
                    Text(
                      '${_enrollmentSamplesCount!} samples',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Clear partial progress if re-enrolling
                if (hasPartialProgress && !_isEnrolled) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('voice_enrollment_step');
                  await prefs.remove('voice_enrollment_samples');
                }
                await Get.toNamed(AppRoutes.voiceEnrollment);
                // Re-check enrollment from backend when returning
                if (mounted) {
                  await _checkEnrollmentFromBackend();
                  if (mounted && _isEnrolled) {
                    _loadCustomVoiceStatus();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isEnrolled
                    ? Colors.white.withValues(alpha: 0.08)
                    : hasPartialProgress
                        ? const Color(0xFFFB923C)
                        : const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Text(
                _isEnrolled
                    ? 'Re-enroll Voice'
                    : hasPartialProgress
                        ? 'Resume Enrollment'
                        : 'Set Up Voice',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasPartialProgress = false;

  /// Check if there is saved but incomplete enrollment progress
  bool _checkPartialEnrollmentProgress() {
    return !_isEnrolled && _hasPartialProgress;
  }

  Widget _buildCustomVoiceCard() {
    if (_loadingCustomVoice) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    final status = _customVoiceStatus;
    final statusText = status?.customVoiceStatus ?? 'none';

    // Determine display state
    IconData icon;
    Color iconColor;
    String title;
    String subtitle;

    switch (statusText) {
      case 'ready':
        icon = Icons.check_circle_rounded;
        iconColor = const Color(0xFF10B981);
        title = 'Custom Voice Ready';
        subtitle = 'Your cloned voice is active';
      case 'pending':
        icon = Icons.hourglass_top_rounded;
        iconColor = const Color(0xFFFB923C);
        title = 'Cloning In Progress';
        subtitle = 'Your voice is being cloned...';
      case 'failed':
        icon = Icons.error_outline_rounded;
        iconColor = const Color(0xFFEF4444);
        title = 'Cloning Failed';
        // Show user-friendly error instead of raw API error
        final rawError = status?.customVoiceError ?? '';
        if (rawError.contains('paid_plan_required') || rawError.contains('payment_required')) {
          subtitle = 'Voice cloning requires a premium provider plan. Try re-enrolling.';
        } else if (rawError.contains('rate_limit') || rawError.contains('429')) {
          subtitle = 'Provider rate limited. Please try again later.';
        } else if (rawError.contains('timeout') || rawError.contains('unavailable')) {
          subtitle = 'Provider temporarily unavailable. Tap retry to try again.';
        } else {
          subtitle = rawError.isNotEmpty
              ? 'Cloning failed. Tap retry to try again.'
              : 'Voice cloning encountered an error';
        }
      case 'disabled':
        icon = Icons.voice_over_off_rounded;
        iconColor = const Color(0xFF9CA3AF);
        title = 'Custom Voice Disabled';
        subtitle = 'Toggle on to use your cloned voice';
      default:
        icon = Icons.record_voice_over_rounded;
        iconColor = const Color(0xFF3B82F6);
        title = 'No Custom Voice';
        subtitle = 'Enroll your voice to clone it for the assistant';
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: statusText == 'ready'
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : statusText == 'failed'
                  ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                  : const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: statusText == 'pending'
                    ? Padding(
                        padding: EdgeInsets.all(10.w),
                        child: CircularProgressIndicator(
                          color: iconColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(icon, color: iconColor, size: 22.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Toggle for ready/disabled states
              if (statusText == 'ready' || statusText == 'disabled')
                _togglingCustomVoice
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Color(0xFF3B82F6),
                          strokeWidth: 2,
                        ),
                      )
                    : Switch(
                        value: statusText == 'ready',
                        onChanged: (value) => _toggleCustomVoice(value),
                        activeThumbColor: const Color(0xFF10B981),
                        inactiveThumbColor: const Color(0xFF9CA3AF),
                        inactiveTrackColor:
                            Colors.white.withValues(alpha: 0.1),
                      ),
            ],
          ),
          // Start cloning button for 'none' state
          if (statusText == 'none') ...[
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Get.toNamed(AppRoutes.voiceCloning);
                  // Reload status when returning from cloning screen
                  if (mounted) {
                    _loadCustomVoiceStatus();
                  }
                },
                icon: Icon(Icons.record_voice_over_rounded, size: 18.sp),
                label: Text(
                  'Create Custom Voice',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
          // Retry button for failed state — re-record fresh audio
          if (statusText == 'failed') ...[
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Get.toNamed(AppRoutes.voiceCloning);
                  if (mounted) _loadCustomVoiceStatus();
                },
                icon: Icon(Icons.refresh_rounded, size: 18.sp),
                label: Text(
                  'Re-record & Retry',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.15),
                  foregroundColor: const Color(0xFFEF4444),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(
    List<settings_models.VoiceLanguage> languages,
    settings_models.VoiceLanguage? selectedLang,
  ) {
    if (languages.isEmpty) {
      return _buildPlaceholderCard(
        icon: Icons.translate_rounded,
        text: 'No languages available',
      );
    }

    return Column(
      children: languages.map((lang) {
        final isSelected = lang.code == _selectedLanguageCode;
        return GestureDetector(
          onTap: () => _saveLanguage(lang.code),
          child: Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.12)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      lang.flagEmoji ?? '',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.nativeName,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        lang.name,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B82F6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                  )
                else
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVoiceTile(settings_models.VoiceOption voice) {
    final isSelected = voice.voiceId == _selectedVoiceId;
    return GestureDetector(
      onTap: () => _saveVoice(voice.voiceId),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.12)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6).withValues(alpha: 0.4)
                : const Color(0xFF2D2D2D),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.06),
              ),
              child: Center(
                child: Icon(
                  voice.gender == 'female'
                      ? Icons.woman_rounded
                      : voice.gender == 'male'
                          ? Icons.man_rounded
                          : Icons.person_rounded,
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : Colors.white.withValues(alpha: 0.4),
                  size: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        voice.name,
                        style: GoogleFonts.inter(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.85),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isSelected) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF3B82F6).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            'CURRENT',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      if (voice.gender != null && voice.gender!.isNotEmpty)
                        _buildChip(_capitalize(voice.gender!)),
                      if (voice.description != null &&
                          voice.description!.isNotEmpty)
                        _buildChip(voice.description!),
                    ],
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 28.w,
                height: 28.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
              )
            else
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      margin: EdgeInsets.only(right: 6.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPlaceholderCard({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 36.sp,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          SizedBox(height: 12.h),
          Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
