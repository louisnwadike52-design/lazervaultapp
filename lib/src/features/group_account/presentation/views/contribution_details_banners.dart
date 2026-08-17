part of 'contribution_details_screen.dart';

// _StatusChip is a borderless elevated tile used by the contribution-
// details "status row" (auto-debit + role). Designed as a compact,
// horizontally-scaled chip the user taps to see full detail in a
// dialog. Uses Material elevation rather than a border to set the
// chip apart from its background.
class _StatusChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _StatusChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1F1F1F),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(icon, color: iconColor, size: 14.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: iconColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[600], size: 16.sp),
            ],
          ),
        ),
      ),
    );
  }
}

// _CompactInfoBanner is a generic collapsible info row used by the
// auto-debit notice. Default state shows icon + title only (~32px tall);
// expanding reveals the body copy. The body is rendered inline rather
// than in a separate scroll region so the user keeps their place when
// dismissing.
class _CompactInfoBanner extends StatefulWidget {
  final IconData icon;
  final Color accent;
  final String title;
  final String body;

  const _CompactInfoBanner({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
  });

  @override
  State<_CompactInfoBanner> createState() => _CompactInfoBannerState();
}

class _CompactInfoBannerState extends State<_CompactInfoBanner> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: widget.accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(8.r),
            child: Row(
              children: [
                Icon(widget.icon, color: widget.accent, size: 14.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.grey[500],
                  size: 16.sp,
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: 6.h),
            Text(
              widget.body,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 11.sp,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// _CompactRoleBanner is a single-row collapsed role chip with a chevron.
// Default state is ~36px tall (icon + role label + Join CTA / chevron),
// expanding inline to show the permissions list when tapped. Replaces
// the previous always-expanded banner that consumed ~110px regardless
// of whether the user cared about the permission detail.
class _CompactRoleBanner extends StatefulWidget {
  final String roleLabel;
  final Color roleColor;
  final IconData roleIcon;
  final List<String> permissions;
  final bool showJoinCta;
  final VoidCallback onJoin;

  const _CompactRoleBanner({
    required this.roleLabel,
    required this.roleColor,
    required this.roleIcon,
    required this.permissions,
    required this.showJoinCta,
    required this.onJoin,
  });

  @override
  State<_CompactRoleBanner> createState() => _CompactRoleBannerState();
}

class _CompactRoleBannerState extends State<_CompactRoleBanner> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: widget.roleColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: widget.roleColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(8.r),
            child: Row(
              children: [
                Icon(widget.roleIcon, color: widget.roleColor, size: 14.sp),
                SizedBox(width: 8.w),
                Text(
                  'Role: ',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  widget.roleLabel,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: widget.roleColor,
                  ),
                ),
                const Spacer(),
                if (widget.showJoinCta)
                  GestureDetector(
                    onTap: widget.onJoin,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: widget.roleColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Join',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[500],
                    size: 16.sp,
                  ),
              ],
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: 6.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 4.h,
              children: widget.permissions
                  .map((p) => Text(
                        '• $p',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
