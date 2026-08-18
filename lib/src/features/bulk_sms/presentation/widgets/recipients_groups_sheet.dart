import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../view/bulk_sms_theme.dart';

/// Saved-groups picker. Lists the user's recipient groups; tapping one resolves
/// its members and returns them (via `Get.back`) so the parent picker can add
/// them to the current selection. Also lets the user save the currently-entered
/// recipients as a new group and delete existing groups.
///
/// Takes the shared [BulkSmsCubit] directly (the sheet lives in the root overlay
/// and so has no `BlocProvider` ancestor) and drives it with the `bloc:` arg.
class RecipientsGroupsSheet extends StatefulWidget {
  final BulkSmsCubit cubit;
  final List<SmsRecipientEntity> currentRecipients;

  const RecipientsGroupsSheet({
    super.key,
    required this.cubit,
    this.currentRecipients = const [],
  });

  @override
  State<RecipientsGroupsSheet> createState() => _RecipientsGroupsSheetState();
}

class _RecipientsGroupsSheetState extends State<RecipientsGroupsSheet> {
  // Id of the group whose members are currently being fetched (tap spinner).
  String? _resolvingId;

  @override
  void initState() {
    super.initState();
    widget.cubit.loadGroups();
  }

  Future<void> _selectGroup(BulkSmsGroup g) async {
    if (_resolvingId != null) return;
    setState(() => _resolvingId = g.id);
    final members = await widget.cubit.resolveGroupMembers(g.id);
    if (!mounted) return;
    setState(() => _resolvingId = null);
    if (members.isEmpty) {
      LVSnackbar.showError(
        title: 'Couldn’t load group',
        message: widget.cubit.state.errorMessage ??
            'This group has no valid recipients.',
      );
      return;
    }
    Get.back(result: members);
  }

  Future<void> _saveCurrentAsGroup() async {
    if (widget.currentRecipients.isEmpty) {
      LVSnackbar.showInfo(
        title: 'No recipients yet',
        message: 'Add some recipients first, then save them as a group.',
      );
      return;
    }
    final name = await _promptName();
    if (name == null || !mounted) return;
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    await widget.cubit
        .createGroup(name: trimmed, recipients: widget.currentRecipients);
    if (!mounted) return;
    final status = widget.cubit.state.groupActionStatus;
    if (status == ActionStatus.success) {
      LVSnackbar.showSuccess(
        title: 'Group saved',
        message:
            '“$trimmed” saved with ${widget.currentRecipients.length} recipient(s).',
      );
    } else if (status == ActionStatus.failed) {
      LVSnackbar.showError(
        title: 'Save failed',
        message: widget.cubit.state.errorMessage ?? 'Please try again.',
      );
    }
  }

  Future<void> _deleteGroup(BulkSmsGroup g) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: BulkSmsTheme.card,
        title: const Text('Delete group?',
            style: TextStyle(color: Colors.white)),
        content: Text(
          '“${g.name}” and its ${g.memberCount} saved recipient(s) will be removed. This can’t be undone.',
          style: TextStyle(color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Keep')),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Delete',
                  style: TextStyle(color: BulkSmsTheme.error))),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await widget.cubit.deleteGroup(g.id);
    if (!mounted) return;
    final status = widget.cubit.state.groupActionStatus;
    if (status == ActionStatus.success) {
      LVSnackbar.showSuccess(
          title: 'Group deleted', message: '“${g.name}” removed.');
    } else if (status == ActionStatus.failed) {
      LVSnackbar.showError(
        title: 'Delete failed',
        message: widget.cubit.state.errorMessage ?? 'Please try again.',
      );
    }
  }

  Future<String?> _promptName() {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: BulkSmsTheme.card,
        title:
            const Text('Save as group', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: 'Group name (e.g. VIP customers)',
            hintStyle:
                TextStyle(color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
            filled: true,
            fillColor: BulkSmsTheme.bg,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
          onSubmitted: (v) => Navigator.of(ctx).pop(v),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text),
            child: const Text('Save',
                style: TextStyle(color: BulkSmsTheme.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: BulkSmsTheme.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: BulkSmsTheme.divider,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Text('Saved groups',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                Icon(Icons.groups_2_outlined,
                    color: BulkSmsTheme.textSecondary, size: 20.sp),
              ],
            ),
          ),
          _saveCurrentButton(),
          SizedBox(height: 8.h),
          Expanded(
            child: BlocBuilder<BulkSmsCubit, BulkSmsState>(
              bloc: widget.cubit,
              buildWhen: (p, c) =>
                  p.groupsStatus != c.groupsStatus || p.groups != c.groups,
              builder: (context, state) => _body(state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveCurrentButton() {
    final count = widget.currentRecipients.length;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: _saveCurrentAsGroup,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: BulkSmsTheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: BulkSmsTheme.primary),
          ),
          child: Row(
            children: [
              Icon(Icons.bookmark_add_outlined,
                  color: BulkSmsTheme.primary, size: 20.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  count > 0
                      ? 'Save current $count recipient(s) as a group'
                      : 'Save current recipients as a group',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BulkSmsState state) {
    if (state.groupsStatus == SectionStatus.loading && state.groups.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: BulkSmsTheme.primary));
    }
    if (state.groupsStatus == SectionStatus.error && state.groups.isEmpty) {
      return _empty(
        icon: Icons.error_outline,
        title: 'Couldn’t load groups',
        subtitle: state.errorMessage ?? 'Please try again.',
        onRetry: widget.cubit.loadGroups,
      );
    }
    if (state.groups.isEmpty) {
      return _empty(
        icon: Icons.groups_2_outlined,
        title: 'No saved groups yet',
        subtitle:
            'Save a set of recipients above to reuse them in future campaigns.',
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: state.groups.length,
      itemBuilder: (context, i) => _groupTile(state.groups[i]),
    );
  }

  Widget _groupTile(BulkSmsGroup g) {
    final resolving = _resolvingId == g.id;
    return GestureDetector(
      onTap: () => _selectGroup(g),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: BulkSmsTheme.divider),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: BulkSmsTheme.primary.withValues(alpha: 0.2),
              child: Icon(Icons.groups_2_rounded,
                  color: Colors.white, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(g.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: Colors.white, fontSize: 14.sp)),
                  SizedBox(height: 2.h),
                  Text('${g.memberCount} recipient(s)',
                      style: TextStyle(
                          color: BulkSmsTheme.textSecondary, fontSize: 11.sp)),
                ],
              ),
            ),
            if (resolving)
              SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: BulkSmsTheme.primary),
              )
            else ...[
              GestureDetector(
                onTap: () => _deleteGroup(g),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Icon(Icons.delete_outline,
                      color: BulkSmsTheme.textSecondary, size: 20.sp),
                ),
              ),
              Icon(Icons.add_circle_outline,
                  color: BulkSmsTheme.primary, size: 22.sp),
            ],
          ],
        ),
      ),
    );
  }

  Widget _empty({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onRetry,
  }) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 44.sp, color: BulkSmsTheme.textSecondary),
          SizedBox(height: 12.h),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15.sp)),
          SizedBox(height: 6.h),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: BulkSmsTheme.textSecondary, fontSize: 12.sp)),
          if (onRetry != null) ...[
            SizedBox(height: 14.h),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
