import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/webview_bottom_sheet.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/crowdfund_moderation.dart';
import 'crowdfund_moderation_badge.dart';

/// WHAT THE CREATOR IS TOLD, AND WHAT THEY CAN DO ABOUT IT.
///
/// ## Why this exists at all
///
/// A blocked campaign is absent from every public list. To its creator that
/// is indistinguishable from the platform having LOST it — they shared a link
/// that now shows nothing, and the obvious conclusion is that we are broken
/// rather than that we decided. So the one place they can still see it, their
/// own campaigns list and their own campaign page, has to say plainly what
/// happened, why, and what they can do next.
///
/// ## Three states, three different jobs
///
/// UNDER REVIEW — reassurance and an expectation. Nothing to act on, so no
/// buttons: a screen that offers an action for a wait teaches people to press
/// it repeatedly.
///
/// NOT ENDORSED — an explanation, because the creator will notice they are
/// sorted below everyone else and will otherwise assume a bug. Still live,
/// still collecting, so the tone is informative rather than apologetic.
///
/// NOT PUBLISHED — the reason, the policy, and the appeal. This is the one
/// that matters, and the appeal button is offered only when the SERVER says
/// it will be accepted ([CrowdfundModeration.canAppeal]) — offering one that
/// is then refused reads as the platform malfunctioning on top of having
/// refused them.
///
/// ## What it never says
///
/// No fault, no cause, no apology, and never a word about our classifier.
/// The reason text is written by the platform, arrives on the wire, and is
/// rendered verbatim — this widget does not compose a sentence about why a
/// campaign was refused, because that sentence is the operator's to write.
class CrowdfundModerationPanel extends StatelessWidget {
  const CrowdfundModerationPanel({
    super.key,
    required this.campaign,
    this.onAppeal,
    this.onViewAppeal,
    this.dense = false,
  });

  final Crowdfund campaign;

  /// Opens the appeal composer. Null hides the button even when the server
  /// would allow one — for surfaces with nowhere to navigate to, like a card
  /// inside a list.
  final VoidCallback? onAppeal;

  /// Opens the existing appeal, when one has been lodged.
  final VoidCallback? onViewAppeal;

  final bool dense;

  CrowdfundModeration get _m => campaign.moderation;

  @override
  Widget build(BuildContext context) {
    // An approved campaign gets NOTHING — not an empty box, not a padded
    // gap. Every existing screen must look exactly as it did before
    // moderation existed for the overwhelming majority of campaigns.
    if (!_m.needsTreatment) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final blocked = _m.isBlocked;
    final accent = blocked ? scheme.error : scheme.onSurfaceVariant;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: (dense ? 8 : 12).h),
      padding: EdgeInsets.all((dense ? 10 : 14).w),
      decoration: BoxDecoration(
        color: blocked
            ? scheme.error.withValues(alpha: 0.06)
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: blocked
              ? scheme.error.withValues(alpha: 0.22)
              : scheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CrowdfundModerationBadge(moderation: _m, compact: dense),
              const Spacer(),
              if (_m.hasAppealed)
                Text(
                  _m.appealCount == 1 ? 'Appealed' : 'Appealed ${_m.appealCount}×',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _headline,
            style: TextStyle(
              fontSize: (dense ? 12 : 13).sp,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _body,
            style: TextStyle(
              fontSize: (dense ? 11 : 12).sp,
              height: 1.45,
              color: accent,
            ),
          ),
          if (_actions(context).isNotEmpty) ...[
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _actions(context),
            ),
          ],
        ],
      ),
    );
  }

  String get _headline {
    switch (_m.status) {
      case CrowdfundModerationState.pending:
      case CrowdfundModerationState.escalated:
        return 'We are reviewing this campaign';
      case CrowdfundModerationState.restricted:
        return 'This campaign is live, but not featured';
      case CrowdfundModerationState.blocked:
        return 'This campaign has not been published';
      case CrowdfundModerationState.approved:
        return '';
    }
  }

  String get _body {
    // THE SERVER'S WORDS WIN. When a reason arrived, render it — it was
    // written for this creator by the platform, and replacing it with a
    // generic line here would throw away the only specific thing they have
    // to go on.
    final reason = _m.reason.trim();
    switch (_m.status) {
      case CrowdfundModerationState.pending:
      case CrowdfundModerationState.escalated:
        // DELIBERATELY SAYS IT CANNOT TAKE MONEY YET. The creator is about
        // to share the link; finding out from a donor that contributions are
        // refused is far worse than being told now.
        return reason.isNotEmpty
            ? reason
            : 'Nobody can contribute until the review is done. We will let you '
                'know as soon as it is — you do not need to do anything.';
      case CrowdfundModerationState.restricted:
        return reason.isNotEmpty
            ? reason
            : 'People can still find it and contribute, and it will appear '
                'below the campaigns we feature.';
      case CrowdfundModerationState.blocked:
        return reason.isNotEmpty
            ? reason
            : 'It falls outside what our crowdfunding policy allows.';
      case CrowdfundModerationState.approved:
        return '';
    }
  }

  List<Widget> _actions(BuildContext context) {
    final out = <Widget>[];
    // THE POLICY LINK IS ONLY SHOWN WHERE IT HELPS. A creator under review
    // has not been told they broke anything, so pointing them at a policy
    // document implies they did.
    if (_m.isBlocked || _m.isRestricted) {
      final url = FeatureFlags.crowdfundPolicyUrl;
      if (url != null) {
        out.add(
          _PanelButton(
            label: 'Read the policy',
            icon: Icons.open_in_new_rounded,
            onTap: () => showWebViewBottomSheet(
              context,
              url: url,
              title: 'Crowdfunding policy',
            ),
          ),
        );
      }
    }
    if (_m.canAppeal && onAppeal != null) {
      out.add(
        _PanelButton(
          label: 'Appeal this',
          icon: Icons.gavel_rounded,
          primary: true,
          onTap: onAppeal!,
        ),
      );
    } else if (_m.hasAppealed && onViewAppeal != null) {
      // Already appealed. The creator's question is now "where has it got
      // to", so the button answers that instead of offering a second one.
      out.add(
        _PanelButton(
          label: 'See your appeal',
          icon: Icons.history_rounded,
          onTap: onViewAppeal!,
        ),
      );
    }
    return out;
  }
}

class _PanelButton extends StatelessWidget {
  const _PanelButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.primary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = primary ? scheme.onPrimary : scheme.onSurface;
    final bg = primary ? scheme.primary : Colors.transparent;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: primary ? scheme.primary : scheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13.sp, color: fg),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
