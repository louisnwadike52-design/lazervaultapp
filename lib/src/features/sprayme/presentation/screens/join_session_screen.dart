import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/spray_room_screen.dart';

class JoinSessionScreen extends StatefulWidget {
  const JoinSessionScreen({super.key});

  @override
  State<JoinSessionScreen> createState() => _JoinSessionScreenState();
}

class _JoinSessionScreenState extends State<JoinSessionScreen> {
  final List<TextEditingController> _codeControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  List<SpraySession> _recentSessions = [];
  bool _isLoadingRecent = true;
  bool _isJoining = false; // Prevent double-submit

  @override
  void initState() {
    super.initState();
    _loadRecentSessions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _codeControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _loadRecentSessions() {
    context.read<SprayMeCubit>().loadMySessions(filter: 'joined');
  }

  String get _code => _codeControllers.map((c) => c.text).join();

  bool get _isCodeComplete => _code.length == 6;

  void _onCodeChanged(int index, String value) {
    if (value.length == 1) {
      _codeControllers[index].text = value.toUpperCase();
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        // Auto-submit when all 6 characters entered
        if (_isCodeComplete) {
          _onJoin();
        }
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {}); // Rebuild to update button state
  }

  void _onJoin() {
    if (!_isCodeComplete || _isJoining) return;
    setState(() => _isJoining = true);
    HapticFeedback.lightImpact();
    context.read<SprayMeCubit>().joinSession(_code);
  }

  void _clearCode() {
    for (final c in _codeControllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          'Join Session',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<SprayMeCubit, SprayMeState>(
          listener: (context, state) async {
            if (state is SessionJoined) {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Joined "${state.session.title}"!'),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
              // Navigate to spray room
              final storage = serviceLocator<SecureStorageService>();
              final token = await storage.getAccessToken();
              if (token != null && mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => serviceLocator<SprayRoomCubit>(),
                      child: SprayRoomScreen(
                        sessionId: state.session.id,
                        accessToken: token,
                      ),
                    ),
                  ),
                );
              } else {
                Navigator.of(context).pop();
              }
            } else if (state is MySessionsLoaded) {
              setState(() {
                _recentSessions = state.sessions;
                _isLoadingRecent = false;
              });
            } else if (state is SprayMeError) {
              setState(() => _isJoining = false); // Re-enable join button
              // Clear the code fields on error so user can re-enter
              _clearCode();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is SprayMeLoading;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 32.h),
                  _buildCodeInputSection(isLoading),
                  SizedBox(height: 40.h),
                  _buildRecentSessions(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Code Input Section ───────────────────────────────────────────────────────

  Widget _buildCodeInputSection(bool isLoading) {
    return Column(
      children: [
        Icon(
          Icons.qr_code_2,
          size: 56.sp,
          color: const Color(0xFF7C3AED),
        ),
        SizedBox(height: 16.h),
        Text(
          'Enter Session Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Ask the host for the 6-character code',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 28.h),

        // Code input boxes
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            final hasValue = _codeControllers[index].text.isNotEmpty;
            final isFocused = _focusNodes[index].hasFocus;

            return Container(
              width: 46.w,
              height: 56.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: TextFormField(
                controller: _codeControllers[index],
                focusNode: _focusNodes[index],
                onChanged: (value) => _onCodeChanged(index, value),
                maxLength: 1,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: hasValue
                      ? const Color(0xFF7C3AED).withOpacity(0.1)
                      : const Color(0xFF1F1F1F),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: isFocused
                          ? const Color(0xFF7C3AED)
                          : hasValue
                              ? const Color(0xFF7C3AED).withOpacity(0.5)
                              : const Color(0xFF2D2D2D),
                      width: isFocused ? 2 : 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: hasValue
                          ? const Color(0xFF7C3AED).withOpacity(0.5)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: Color(0xFF7C3AED),
                      width: 2,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 24.h),

        // Join button
        SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: _isCodeComplete && !isLoading ? _onJoin : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              disabledBackgroundColor: const Color(0xFF7C3AED).withOpacity(0.3),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? SizedBox(
                    width: 22.w,
                    height: 22.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Join Session',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 12.h),

        // Clear button
        if (_code.isNotEmpty)
          TextButton(
            onPressed: _clearCode,
            child: Text(
              'Clear',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }

  // ── Recent Sessions ──────────────────────────────────────────────────────────

  Widget _buildRecentSessions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: const Color(0xFF2D2D2D), height: 1.h),
        SizedBox(height: 20.h),
        Text(
          'Recent Sessions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (_isLoadingRecent)
          Shimmer.fromColors(
            baseColor: const Color(0xFF1F1F1F),
            highlightColor: const Color(0xFF2D2D2D),
            child: Column(
              children: List.generate(
                3,
                (_) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Container(
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (_recentSessions.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.history,
                  size: 36.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                SizedBox(height: 8.h),
                Text(
                  'No recent sessions',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          )
        else
          ..._recentSessions.take(5).map((session) {
            return _buildRecentSessionTile(session);
          }),
      ],
    );
  }

  Widget _buildRecentSessionTile(SpraySession session) {
    final isEnded = session.isEnded;
    final statusColor = isEnded ? const Color(0xFF9CA3AF) : const Color(0xFF10B981);

    return GestureDetector(
      onTap: () {
        if (_isJoining) return;
        HapticFeedback.lightImpact();
        if (isEnded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('"${session.title}" has ended.'),
              backgroundColor: const Color(0xFF9CA3AF),
              duration: const Duration(seconds: 2),
            ),
          );
          return;
        }
        // Re-join active session
        setState(() => _isJoining = true);
        context.read<SprayMeCubit>().joinSession(session.sessionCode);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: (isEnded ? const Color(0xFF9CA3AF) : const Color(0xFF7C3AED)).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                isEnded ? Icons.event_busy : Icons.celebration,
                color: isEnded ? const Color(0xFF9CA3AF) : const Color(0xFF7C3AED),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.title,
                    style: TextStyle(
                      color: isEnded ? const Color(0xFF9CA3AF) : Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        session.occasionType,
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          isEnded ? 'ENDED' : 'ACTIVE',
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              isEnded ? Icons.info_outline : Icons.arrow_forward_ios,
              color: const Color(0xFF9CA3AF),
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Uppercase Text Formatter ─────────────────────────────────────────────────

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
