part of 'settings_screen.dart';

/// Settings hub — single-page accordion. One section open at a time.
///
/// Toggles that hit the backend (push/email/SMS notifications, dark mode,
/// language/currency/country) render INLINE inside their accordion body so
/// the user never leaves this screen for a one-tap change. Multi-step
/// flows (password change, passcode change, transaction PIN, 2FA setup,
/// KYC, banking channels, statements) still navigate.
///
/// Dead rows (Trusted Devices, in-app categories, Data Sharing,
/// Marketing/Analytics opt-in) are feature-flagged off at the top of the
/// file so a single boolean flip re-enables them when the backend lands.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Re-use the global ProfileCubit so verification screens that update
    // the user object are immediately reflected here.
    return const _SettingsView();
  }
}

class _SettingsView extends StatefulWidget {
  const _SettingsView();

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

// ============================================================
// Helper widgets
// ============================================================

/// A settings row that carries its own searchable metadata (title, subtitle,
/// keywords) so [_filterableColumn] can filter individual items within an
/// expanded accordion while a settings search is active. It renders [child]
/// unchanged — the metadata is inspected, never displayed.
class _FilterableTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> keywords;
  final Widget child;
  const _FilterableTile({
    required this.title,
    required this.subtitle,
    required this.keywords,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;
}

class _SectionSpec {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget body;
  /// Searchable labels of the items inside this section (so a query like
  /// "biometric" or "panic" matches even though it isn't in the title).
  final List<String> keywords;
  _SectionSpec({
    required this.title,
    required this.icon,
    required this.body,
    // Reusable header subtitle — currently no section sets one (the Voice &
    // Chat Assistant header was deliberately cleared), kept for future use.
    // ignore: unused_element_parameter
    this.subtitle,
    this.keywords = const [],
  });

  /// True when [query] matches this section's title, subtitle or any keyword.
  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    // Token-based match: every whitespace-separated word in the query must
    // appear somewhere in the haystack (title + subtitle + keywords). This
    // makes multi-word ("voice login") and partial ("bio", "kyc tier")
    // queries work regardless of word order, instead of requiring one
    // keyword to contain the entire raw query string.
    final haystack = [
      title.toLowerCase(),
      (subtitle ?? '').toLowerCase(),
      ...keywords.map((k) => k.toLowerCase()),
    ].join(' ');
    final tokens = q.split(RegExp(r'\s+')).where((t) => t.isNotEmpty);
    return tokens.every((t) => haystack.contains(t));
  }
}

/// One accordion card. We don't use Flutter's stock `ExpansionTile`
/// because its theming hooks for splash/divider/chevron colour are
/// awkward to override consistently. Instead we render a simple
/// header + `AnimatedSize` body — 250ms ease-out matches the design.
class _AccordionSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool expanded;
  final VoidCallback onTap;
  final Widget child;

  const _AccordionSection({
    super.key,
    required this.icon,
    required this.title,
    required this.expanded,
    required this.onTap,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: _kBrand.withValues(alpha: 0.1),
              highlightColor: _kBrand.withValues(alpha: 0.05),
              onTap: onTap,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  children: [
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: _kAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(icon, size: 20.sp, color: _kAccent),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: _kTextPrimary,
                            ),
                          ),
                          if (subtitle != null) ...[
                            SizedBox(height: 2.h),
                            Text(
                              subtitle!,
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: _kTextSecondary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Chevron rotates 180° when expanded. The brand
                    // colour pops vs the default Material grey arrow.
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: _kBrand,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Open/close with a fade+size crossfade — same styled animation the
          // insurance FAQ accordions use (200ms). clipBehavior on the outer
          // card keeps the bottom rounded corners clean during the transition.
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(height: 1, thickness: 1, color: _kDivider),
                child,
                SizedBox(height: 4.h),
              ],
            ),
            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            sizeCurve: Curves.easeOut,
          ),
        ],
      ),
    );
  }
}

/// A single tappable row inside an accordion body. Public surface is
/// trivial — `onTap` may be null for switch rows where the trailing
/// widget already owns the gesture.
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: _kAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 18.sp, color: _kAccent),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: _kTextPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: _kTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _VoiceServiceTile {
  final String slug;
  final String label;
  final IconData icon;
  const _VoiceServiceTile({
    required this.slug,
    required this.label,
    required this.icon,
  });
}
