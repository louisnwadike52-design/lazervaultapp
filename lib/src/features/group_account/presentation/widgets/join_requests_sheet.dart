import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/group_account/data/datasources/group_account_remote_data_source.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// The admin's queue of people waiting to join a public group.
///
/// A public group is discoverable, not open: joining files a request and
/// somebody has to decide it. Without this screen the gate is invisible —
/// requests pile up server-side and the people who filed them wait forever,
/// which is worse than the old behaviour of letting anyone in.
///
/// Decisions are deliberately one-at-a-time with no bulk action. Admitting
/// someone is granting access to other people's money, and a "approve all"
/// button turns that into a single careless tap.
class JoinRequestsSheet extends StatefulWidget {
  const JoinRequestsSheet({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.dataSource,
    this.onChanged,
  });

  final String groupId;
  final String groupName;
  final GroupAccountRemoteDataSource dataSource;

  /// Called after any decision lands, so the caller can refresh its member
  /// list and badge count rather than holding a stale number.
  final VoidCallback? onChanged;

  @override
  State<JoinRequestsSheet> createState() => _JoinRequestsSheetState();
}

class _JoinRequestsSheetState extends State<JoinRequestsSheet> {
  static const _bg = Color(0xFF121212);
  static const _card = Color(0xFF1E1E1E);
  static const _border = Color(0xFF2A2A2A);
  static const _approve = Color(0xFF10B981);
  static const _reject = Color(0xFFEF4444);

  List<GroupMember> _requests = const [];
  bool _loading = true;
  String? _error;

  /// Ids currently being decided, so a row cannot be double-tapped into two
  /// decisions while the first is in flight.
  final Set<String> _deciding = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final rows = await widget.dataSource.listJoinRequests(widget.groupId);
      if (!mounted) return;
      setState(() {
        _requests = rows;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        // The server answers PERMISSION_DENIED for a non-admin rather than an
        // empty list, so this says why instead of implying nobody is waiting.
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  Future<void> _decide(GroupMember member, bool approve) async {
    if (_deciding.contains(member.userId)) return;
    setState(() => _deciding.add(member.userId));
    try {
      await widget.dataSource.decideJoinRequest(
        groupId: widget.groupId,
        requesterId: member.userId,
        approve: approve,
      );
      if (!mounted) return;
      setState(() {
        _requests =
            _requests.where((r) => r.userId != member.userId).toList();
        _deciding.remove(member.userId);
      });
      widget.onChanged?.call();
      _toast(
        approve
            ? '${member.userName} can now access ${widget.groupName}'
            : 'Request from ${member.userName} declined',
        approve ? _approve : _reject,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _deciding.remove(member.userId));
      // The common failure is another admin deciding first, which the server
      // reports as FAILED_PRECONDITION. Reloading is the useful response —
      // the queue is simply out of date.
      _toast(e.toString().replaceFirst('Exception: ', ''), _reject);
      _load();
    }
  }

  void _toast(String message, Color colour) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colour,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: SafeArea(
        top: false,
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
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Join requests',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              widget.groupName,
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Flexible(child: _body()),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: const Center(child: LazerVaultLoader.medium()),
      );
    }
    if (_error != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          children: [
            Icon(Icons.lock_outline, color: Colors.grey[600], size: 30.sp),
            SizedBox(height: 10.h),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            TextButton(onPressed: _load, child: const Text('Try again')),
          ],
        ),
      );
    }
    if (_requests.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 34.h),
        child: Column(
          children: [
            Icon(Icons.inbox_outlined, color: Colors.grey[600], size: 32.sp),
            SizedBox(height: 10.h),
            Text(
              'No one is waiting to join',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14.sp),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: _requests.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (_, i) => _requestRow(_requests[i]),
    );
  }

  Widget _requestRow(GroupMember m) {
    final busy = _deciding.contains(m.userId);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFF2D2D2D),
            child: Text(
              (m.userName.isNotEmpty ? m.userName[0] : '?').toUpperCase(),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.userName.isNotEmpty ? m.userName : 'LazerVault user',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if ((m.userUsername ?? '').isNotEmpty)
                  Text(
                    '@${m.userUsername}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
          if (busy)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const LazerVaultLoader.small(),
            )
          else ...[
            // Decline sits left of Approve and is the quieter control: the
            // destructive-looking action here is admitting someone, not
            // turning them away.
            _decisionButton(
              label: 'Decline',
              colour: _reject,
              filled: false,
              onTap: () => _decide(m, false),
            ),
            SizedBox(width: 8.w),
            _decisionButton(
              label: 'Approve',
              colour: _approve,
              filled: true,
              onTap: () => _decide(m, true),
            ),
          ],
        ],
      ),
    );
  }

  Widget _decisionButton({
    required String label,
    required Color colour,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: filled ? colour : colour.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.r),
          border: filled ? null : Border.all(color: colour.withValues(alpha: 0.4)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: filled ? Colors.white : colour,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
