part of 'learn_earn_screen.dart';

// ---------------------------------------------------------------------------
// Educational content data
// ---------------------------------------------------------------------------
class _Lesson {
  final IconData icon;
  final String title;
  final String summary;
  final String detail;
  const _Lesson(this.icon, this.title, this.summary, this.detail);
}

// ---------------------------------------------------------------------------
// Expandable lesson card (stateful for animation)
// ---------------------------------------------------------------------------
class _ExpandableLessonCard extends StatefulWidget {
  final _Lesson lesson;
  const _ExpandableLessonCard({required this.lesson});

  @override
  State<_ExpandableLessonCard> createState() => _ExpandableLessonCardState();
}

class _ExpandableLessonCardState extends State<_ExpandableLessonCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _expanded ? _kAccent.withValues(alpha: 0.5) : _kDivider,
            width: _expanded ? 1 : 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: _kAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: Icon(lesson.icon, color: _kAccent, size: 18.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _cleanLessonMarkdown(lesson.summary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(fontSize: 12.sp, color: _kTextSecondary),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(Icons.keyboard_arrow_down, color: _kTextSecondary, size: 20.sp),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.only(top: 12.h),
                // Render the lesson body as real markdown (bold, headings,
                // lists) instead of showing raw "**...**"; strip em/en dashes.
                child: MarkdownBody(
                  data: _cleanLessonMarkdown(lesson.detail),
                  shrinkWrap: true,
                  styleSheet: _lessonMarkdownStyle(),
                ),
              ),
              crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}
