// select_payout_receiver_bottom_sheet.dart
//
// Bottom sheet that lets a group admin designate who will receive the
// payout for a (contribution, cycleIndex). Shown from the receiver
// banner on contribution_details_screen and from the 3-dot menu.
//
// Member source: contribution.members. We deliberately don't open the
// Add-Members search here — the canonical receiver MUST already be a
// contribution member (the server enforces this; failing the picker
// constraint client-side gives clearer feedback).
//
// On save, calls PayoutAssignmentService.setReceiver with the picked
// member's user_id. The server returns both the receiver row and the
// updated scheduled-payout state; the parent screen refreshes to
// reflect the new state machine.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/group_account/data/services/payout_assignment_service.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';
import 'package:lazervault/src/generated/group_account.pb.dart' as pb;

class SelectPayoutReceiverBottomSheet extends StatefulWidget {
  final Contribution contribution;
  final int cycleIndex;
  // Pre-existing receiver (if any). When non-null the sheet is in
  // "reassign" mode — the row is highlighted and the save CTA reads
  // "Reassign" instead of "Set Receiver".
  final String? currentReceiverUserId;

  const SelectPayoutReceiverBottomSheet({
    super.key,
    required this.contribution,
    this.cycleIndex = 0,
    this.currentReceiverUserId,
  });

  /// Returns the SetPayoutReceiverResponse on success; null on cancel.
  /// Caller should refresh contribution + payout state with the
  /// returned scheduledPayout (or by re-fetching) so the UI reflects
  /// the new (scheduled|ready) status without a poll.
  static Future<pb.SetPayoutReceiverResponse?> show({
    required BuildContext context,
    required Contribution contribution,
    int cycleIndex = 0,
    String? currentReceiverUserId,
  }) {
    return showModalBottomSheet<pb.SetPayoutReceiverResponse>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectPayoutReceiverBottomSheet(
        contribution: contribution,
        cycleIndex: cycleIndex,
        currentReceiverUserId: currentReceiverUserId,
      ),
    );
  }

  @override
  State<SelectPayoutReceiverBottomSheet> createState() =>
      _SelectPayoutReceiverBottomSheetState();
}

class _SelectPayoutReceiverBottomSheetState
    extends State<SelectPayoutReceiverBottomSheet> {
  final _searchController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedUserId;
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedUserId = widget.currentReceiverUserId;
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  List<ContributionMember> get _filteredMembers {
    // Active-only filter: pending_invite shadows haven't accepted
    // the parent group invite, so they MUST NOT be selectable as
    // receivers — the backend payout_assignment_service rejects
    // them too, but filtering here saves the round-trip and makes
    // the picker honest about who's eligible.
    final activeMembers = widget.contribution.members
        .where((m) => m.isActiveParticipant)
        .toList();
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return activeMembers;
    return activeMembers.where((m) {
      return m.userName.toLowerCase().contains(q) ||
          m.email.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> _save() async {
    if (_selectedUserId == null) {
      setState(() => _error = 'Pick a member to receive the payout');
      return;
    }
    setState(() {
      _isSaving = true;
      _error = null;
    });

    final svc = serviceLocator<PayoutAssignmentService>();
    try {
      final res = await svc.setReceiver(
        contributionId: widget.contribution.id,
        cycleIndex: widget.cycleIndex,
        recipientUserId: _selectedUserId!,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      );
      if (!mounted) return;
      Navigator.of(context).pop(res);
    } on GrpcError catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _error = _humanizeGrpcError(e);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _error = 'Could not set receiver. Try again.';
      });
    }
  }

  String _humanizeGrpcError(GrpcError e) {
    // Surface the server-supplied message when it's user-facing
    // (member-not-in-contribution, not-authorized, etc.). Wrap
    // unknown / internal codes in a generic message so the picker
    // doesn't leak gRPC plumbing into the UI.
    switch (e.code) {
      case StatusCode.permissionDenied:
        return 'You need to be an admin to assign the receiver.';
      case StatusCode.invalidArgument:
        return e.message ?? 'Invalid selection';
      case StatusCode.notFound:
        return 'Contribution not found.';
      case StatusCode.unauthenticated:
        return 'Sign in again, then retry.';
      default:
        return 'Could not set receiver. Try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.currentReceiverUserId == null
                          ? 'Set Payout Receiver'
                          : 'Change Payout Receiver',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
                child: Text(
                  widget.contribution.type == ContributionType.rotatingSavings
                      ? 'Whoever you pick will receive cycle ${widget.cycleIndex} of this savings rotation. They must already be a contribution member.'
                      : 'Whoever you pick will receive the full payout when the contribution closes. They must already be a contribution member.',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Search by name or email',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.grey[400], size: 20.sp),
                    filled: true,
                    fillColor: const Color(0xFF0A0A0A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 78, 3, 208),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(child: _buildMemberList()),
              if (_error != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                  child: Text(
                    _error!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 4.h),
                child: TextField(
                  controller: _noteController,
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: 'Note (optional). Visible to admins',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey[600],
                      fontSize: 13.sp,
                    ),
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFF0A0A0A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 78, 3, 208),
                        width: 1.5,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[700],
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isSaving
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text(
                            widget.currentReceiverUserId == null
                                ? 'Set Receiver'
                                : 'Reassign',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberList() {
    final members = _filteredMembers;
    if (members.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
        child: Center(
          child: Text(
            _searchController.text.isEmpty
                ? 'No members on this contribution yet. Add members first.'
                : 'No matches.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 13.sp),
          ),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: members.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, idx) {
        final m = members[idx];
        final isSelected = _selectedUserId == m.userId;
        final isCurrent = widget.currentReceiverUserId == m.userId;
        return InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: () => setState(() => _selectedUserId = m.userId),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF1A0F2E)
                  : const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected
                    ? const Color.fromARGB(255, 78, 3, 208)
                    : const Color(0xFF2D2D2D),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor:
                      const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                  backgroundImage:
                      (m.profileImage != null && m.profileImage!.isNotEmpty)
                          ? NetworkImage(m.profileImage!)
                          : null,
                  child: (m.profileImage == null || m.profileImage!.isEmpty)
                      ? Text(
                          _initials(m.userName),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 78, 3, 208),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              m.userName,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isCurrent)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'Current',
                                style: GoogleFonts.inter(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        m.email,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle,
                      color: const Color.fromARGB(255, 78, 3, 208),
                      size: 20.sp),
              ],
            ),
          ),
        );
      },
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
