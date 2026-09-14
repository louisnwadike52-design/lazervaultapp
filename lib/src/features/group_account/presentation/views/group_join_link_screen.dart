import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

import '../../data/datasources/group_join_link_remote_data_source.dart';

/// Landing screen for a shared group invite link
/// (`https://lazervault.app/family/invite/<token>`).
///
/// Shows WHAT you're joining before you commit — group name, who invited you,
/// how many members — then joins on an explicit tap. The link is resolved
/// server-side on every open, so a revoked/expired/spent link explains itself
/// here rather than failing after the user has already tapped Join.
class GroupJoinLinkScreen extends StatefulWidget {
  final String token;

  const GroupJoinLinkScreen({super.key, required this.token});

  @override
  State<GroupJoinLinkScreen> createState() => _GroupJoinLinkScreenState();
}

class _GroupJoinLinkScreenState extends State<GroupJoinLinkScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _primary = Color(0xFF4E03D0);

  final _dataSource = GroupJoinLinkRemoteDataSource();

  bool _loading = true;
  bool _joining = false;
  String? _error;
  GroupJoinLinkPreview? _preview;

  @override
  void initState() {
    super.initState();
    _load();
  }

  String? get _accessToken {
    final s = context.read<AuthenticationCubit>().state;
    return s is AuthenticationSuccess ? s.profile.session.accessToken : null;
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final token = _accessToken;
    if (token == null) {
      // Should not happen — the deep link is replayed through PendingDeepLink
      // AFTER the session exists — but never strand the user on a spinner.
      setState(() {
        _loading = false;
        _error = 'Please sign in to open this invite.';
      });
      return;
    }
    try {
      final p =
          await _dataSource.preview(token: token, linkToken: widget.token);
      if (!mounted) return;
      setState(() {
        _preview = p;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _loading = false;
      });
    }
  }

  Future<void> _join() async {
    final token = _accessToken;
    final preview = _preview;
    if (token == null || preview == null || _joining) return;
    setState(() => _joining = true);
    try {
      final res =
          await _dataSource.join(token: token, linkToken: widget.token);
      if (!mounted) return;
      Get.offNamed(AppRoutes.groupDetails, arguments: res.groupId);
      Get.snackbar(
        res.alreadyMember ? 'Already a member' : 'Welcome aboard',
        res.message.isNotEmpty
            ? res.message
            : 'You\'ve joined ${preview.groupName}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: _card,
        colorText: Colors.white,
        margin: EdgeInsets.all(12.w),
        borderRadius: 14.r,
        icon: const Icon(Icons.groups, color: Color(0xFF10B981)),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _joining = false;
        // Re-resolve so the screen reflects the CURRENT link state (e.g. the
        // last slot was taken while this screen sat open).
        _error = '$e';
      });
      _load();
    }
  }

  void _openGroup() {
    final id = _preview?.groupId ?? '';
    if (id.isEmpty) return;
    Get.offNamed(AppRoutes.groupDetails, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
        ),
        title: Text(
          'Group invite',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LazerVaultLoader.small(),
            SizedBox(height: 14.h),
            Text('Opening invite…',
                style: GoogleFonts.inter(
                    color: Colors.grey[400], fontSize: 14.sp)),
          ],
        ),
      );
    }

    final p = _preview;
    if (p == null) {
      return _messageState(
        icon: Icons.error_outline,
        color: const Color(0xFFEF4444),
        title: "Couldn't open this invite",
        body: _error ?? 'Something went wrong. Please try again.',
        actionLabel: 'Try again',
        onAction: _load,
      );
    }

    if (!p.valid) {
      return _messageState(
        icon: Icons.link_off,
        color: const Color(0xFFF59E0B),
        title: 'Invite unavailable',
        body: p.invalidMessage,
        actionLabel: 'Back to home',
        onAction: () => Get.offAllNamed(AppRoutes.dashboard),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 76.w,
              height: 76.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.groups, color: _primary, size: 36.sp),
            ),
          ),
          SizedBox(height: 18.h),
          Center(
            child: Text(
              p.groupName.isNotEmpty ? p.groupName : 'This group',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (p.inviterName.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Center(
              child: Text(
                '${p.inviterName} invited you to join',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.grey[400], fontSize: 13.sp),
              ),
            ),
          ],
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _border),
            ),
            child: Column(
              children: [
                if (p.groupDescription.isNotEmpty) ...[
                  Text(
                    p.groupDescription,
                    style: GoogleFonts.inter(
                        color: Colors.grey[300], fontSize: 13.sp, height: 1.4),
                  ),
                  SizedBox(height: 14.h),
                  Divider(color: _border, height: 1),
                  SizedBox(height: 14.h),
                ],
                _row(Icons.people_outline, 'Members',
                    '${p.memberCount}'),
                SizedBox(height: 10.h),
                _row(Icons.badge_outlined, 'You join as',
                    p.role.isNotEmpty ? _titleCase(p.role) : 'Member'),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          // Honest disclosure: this is a money group, not a chat group.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 14.sp, color: Colors.grey[500]),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Joining lets you see this group and take part in its '
                  'contributions. You are never charged for joining, and any '
                  'payment you make is always confirmed by you first.',
                  style: GoogleFonts.inter(
                      color: Colors.grey[500], fontSize: 11.sp, height: 1.35),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          if (p.alreadyMember)
            _primaryButton(
              label: 'Open group',
              onTap: _openGroup,
            )
          else
            _primaryButton(
              label: _joining ? 'Joining…' : 'Join group',
              busy: _joining,
              onTap: _join,
            ),
          SizedBox(height: 10.h),
          Center(
            child: TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              child: Text(
                'Not now',
                style: GoogleFonts.inter(
                    color: Colors.grey[400], fontSize: 13.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _titleCase(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  Widget _row(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: Colors.grey[500]),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(label,
              style:
                  GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp)),
        ),
        Text(value,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _primaryButton({
    required String label,
    required VoidCallback onTap,
    bool busy = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: busy ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          disabledBackgroundColor: _primary.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: busy
            ? SizedBox(
                width: 20.sp,
                height: 20.sp,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Text(label,
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _messageState({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 52.sp, color: color),
            SizedBox(height: 14.h),
            Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Text(body,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.grey[400], fontSize: 13.sp, height: 1.4)),
            SizedBox(height: 20.h),
            _primaryButton(label: actionLabel, onTap: onAction),
          ],
        ),
      ),
    );
  }
}
