import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/datasources/group_account_remote_data_source.dart';
import '../../domain/entities/group_entities.dart';
import '../../domain/entities/pending_join_request.dart';

/// Everything waiting on this admin to decide, across all of their groups.
///
/// WHY A TAB AND NOT A SHEET
/// -------------------------
/// JoinRequestsSheet answers "who is waiting for THIS group?" and is opened
/// from that group's own screen. It cannot answer "is anything waiting on me?"
/// — the question somebody opening Group Funds actually has — because they
/// would have to visit every group they administer to find out. A request
/// nobody looks for is a person who never gets in.
///
/// Deliberately NO "approve all". Approving is granting a stranger access to
/// other people's money; it should cost one deliberate tap each.
class JoinRequestsTab extends StatefulWidget {
  const JoinRequestsTab({
    super.key,
    required this.dataSource,
    this.onCountChanged,
  });

  final GroupAccountRemoteDataSource dataSource;

  /// Lets the parent keep the tab badge honest after a decision, without the
  /// tab knowing anything about how the badge is drawn.
  final ValueChanged<int>? onCountChanged;

  @override
  State<JoinRequestsTab> createState() => JoinRequestsTabState();
}

class JoinRequestsTabState extends State<JoinRequestsTab> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1A1A1A);
  static const _border = Color(0xFF2D2D2D);
  static const _approve = Color(0xFF10B981);
  static const _reject = Color(0xFFEF4444);
  static const _pending = Color(0xFFF59E0B);

  List<PendingJoinRequest> _requests = const [];
  final Set<String> _deciding = {};
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    load();
  }

  /// Public so the parent can refresh when the tab is selected — a queue that
  /// only loads once goes stale the moment somebody else decides a request.
  Future<void> load() async {
    if (!mounted) return;
    setState(() {
      _loading = _requests.isEmpty;
      _error = null;
    });
    try {
      final rows = await widget.dataSource.listMyPendingJoinRequests();
      if (!mounted) return;
      setState(() {
        _requests = rows;
        _loading = false;
      });
      widget.onCountChanged?.call(rows.length);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _decide(PendingJoinRequest req, bool approve) async {
    final key = '${req.groupId}:${req.member.userId}';
    if (_deciding.contains(key)) return;

    // Rejecting is the one that costs somebody something, so it asks first.
    // Approving is additive and reversible by removing the member; rejecting
    // consumes one of their limited attempts before a cooling-off period.
    if (!approve) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: _card,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          title: Text('Decline this request?',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700)),
          content: Text(
            '${_name(req.member)} asked to join "${req.groupName}". They can ask '
            'again, but only a limited number of times before they have to wait.',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 12.5.sp, height: 1.45),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text('Cancel',
                  style: GoogleFonts.inter(color: Colors.grey[400])),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: ElevatedButton.styleFrom(
                  backgroundColor: _reject, foregroundColor: Colors.white),
              child: Text('Decline',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }

    setState(() => _deciding.add(key));
    try {
      await widget.dataSource.decideJoinRequest(
        groupId: req.groupId,
        requesterId: req.member.userId,
        approve: approve,
      );
      if (!mounted) return;
      setState(() {
        _requests = _requests
            .where((r) =>
                !(r.groupId == req.groupId &&
                    r.member.userId == req.member.userId))
            .toList();
        _deciding.remove(key);
      });
      widget.onCountChanged?.call(_requests.length);
      _toast(
        approve
            ? '${_name(req.member)} joined ${req.groupName}'
            : 'Request declined',
        approve ? _approve : _reject,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _deciding.remove(key));
      _toast(e.toString().replaceFirst('Exception: ', ''), _reject);
    }
  }

  String _name(GroupMember m) {
    final n = m.userName.trim();
    if (n.isNotEmpty) return n;
    final e = m.email.trim();
    return e.isNotEmpty ? e : 'Someone';
  }

  void _toast(String msg, Color colour) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: colour,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: _pending));
    }
    if (_error != null) {
      return _message(
        icon: Icons.cloud_off_rounded,
        title: 'Could not load requests',
        body: _error!,
        action: 'Try again',
      );
    }
    if (_requests.isEmpty) {
      // Says what this tab is FOR, not just that it is empty — an admin who
      // has never seen a request should still learn what will appear here.
      return _message(
        icon: Icons.inbox_outlined,
        title: 'No one is waiting',
        body: 'When somebody asks to join a group you run, their request '
            'appears here for you to accept or decline.',
      );
    }

    return RefreshIndicator(
      onRefresh: load,
      color: _pending,
      backgroundColor: _card,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        itemCount: _requests.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (_, i) => _row(_requests[i]),
      ),
    );
  }

  Widget _message({
    required IconData icon,
    required String title,
    required String body,
    String? action,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44.sp, color: Colors.grey[700]),
            SizedBox(height: 14.h),
            Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Text(body,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.grey[500], fontSize: 12.5.sp, height: 1.5)),
            if (action != null) ...[
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: load,
                style: ElevatedButton.styleFrom(backgroundColor: _pending),
                child: Text(action,
                    style: GoogleFonts.inter(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(PendingJoinRequest req) {
    final key = '${req.groupId}:${req.member.userId}';
    final busy = _deciding.contains(key);
    final name = _name(req.member);

    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: req.isStale ? _pending.withValues(alpha: 0.5) : _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 19.r,
                backgroundColor: _pending.withValues(alpha: 0.15),
                backgroundImage: (req.member.profileImage ?? '').isNotEmpty
                    ? NetworkImage(req.member.profileImage!)
                    : null,
                child: (req.member.profileImage ?? '').isEmpty
                    ? Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                        style: GoogleFonts.inter(
                            color: _pending,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
                      )
                    : null,
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 2.h),
                    // WHICH group — the whole reason this tab needs the group
                    // attached to every row.
                    Text('wants to join ${req.groupName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: Colors.grey[400], fontSize: 11.5.sp)),
                  ],
                ),
              ),
              _waitBadge(req),
            ],
          ),
          SizedBox(height: 11.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: busy ? null : () => _decide(req, false),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: _reject.withValues(alpha: 0.6)),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.r)),
                  ),
                  child: Text('Decline',
                      style: GoogleFonts.inter(
                          color: _reject,
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 9.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: busy ? null : () => _decide(req, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _approve,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.r)),
                  ),
                  child: busy
                      ? SizedBox(
                          height: 14.sp,
                          width: 14.sp,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text('Accept',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// How long they have waited. Amber once it has been a week: a request
  /// nobody has answered is the one most likely to be forgotten.
  Widget _waitBadge(PendingJoinRequest req) {
    final colour = req.isStale ? _pending : Colors.grey[500]!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(req.waitingLabel,
          style: GoogleFonts.inter(
              color: colour, fontSize: 9.5.sp, fontWeight: FontWeight.w600)),
    );
  }
}
