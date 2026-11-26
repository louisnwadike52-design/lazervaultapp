import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/navigation/back_or_home.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/webview_bottom_sheet.dart';

import '../../data/datasources/crowdfund_grpc_data_source.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/crowdfund_moderation.dart';
import '../widgets/crowdfund_moderation_badge.dart';

/// THE APPEAL — the creator's side of a block, end to end.
///
/// ## One screen, two jobs
///
/// It COMPOSES an appeal when there is none, and REPORTS one when there is.
/// Those are the same screen on purpose: a creator who has already appealed
/// and comes back is asking "where has it got to", and sending them to a
/// different place for the answer than the place they lodged it is how people
/// conclude the thing was never submitted.
///
/// ## Navigation
///
/// Reached from the moderation panel on the creator's own campaign. Back is
/// [backOrHome] rather than `Get.back()` so the screen is safe to arrive at
/// from a notification tap, where there is no previous route to pop to — the
/// case that used to close the whole app.
///
/// ## What it refuses to do
///
/// It does not let a creator submit an empty case. "I appeal" gives an
/// operator nothing to weigh, and an appeal that cannot be decided wastes the
/// creator's one or two attempts. The minimum is checked here AND on the
/// server; this one exists so the refusal arrives before they press send.
class CrowdfundAppealScreen extends StatefulWidget {
  const CrowdfundAppealScreen({
    super.key,
    required this.campaign,
    required this.dataSource,
  });

  final Crowdfund campaign;
  final CrowdfundGrpcDataSource dataSource;

  @override
  State<CrowdfundAppealScreen> createState() => _CrowdfundAppealScreenState();
}

class _CrowdfundAppealScreenState extends State<CrowdfundAppealScreen> {
  static const _minChars = 20;
  static const _maxChars = 2000;

  final _controller = TextEditingController();
  bool _loading = true;
  bool _submitting = false;
  String? _error;
  CrowdfundAppeal? _existing;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final appeals = await widget.dataSource.listMyAppeals(
        crowdfundId: widget.campaign.id,
        limit: 5,
      );
      // THE MOST RECENT ONE IS THE ONE THAT MATTERS. A campaign can be
      // appealed more than once (the cap is an operator setting), and the
      // creator's question is always about their latest attempt.
      appeals.sort((a, b) {
        final x = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final y = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return y.compareTo(x);
      });
      setState(() {
        _existing = appeals.isEmpty ? null : appeals.first;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        // NOT FATAL. A creator who has never appealed and one whose list
        // failed to load both need the composer — refusing to show it because
        // a read failed would strand the only action they have.
        _existing = null;
        _loading = false;
        _error = null;
      });
      debugPrint('could not load appeals: $e');
    }
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.length < _minChars) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final appeal = await widget.dataSource.submitAppeal(
        crowdfundId: widget.campaign.id,
        message: text,
      );
      if (!mounted) return;
      setState(() {
        _existing = appeal;
        _submitting = false;
        _controller.clear();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        // The service's wording, forwarded. "An appeal is already open for
        // this campaign" and "appeals are not available" are both answers the
        // creator can act on, and replacing them with a generic failure would
        // throw that away.
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return PopScope(
      // The OS back button must behave like the in-app one. Without this the
      // two diverge, and on Android the system gesture would pop a route the
      // in-app arrow deliberately replaces.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) backOrHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: backOrHome,
          ),
          title: const Text('Appeal'),
        ),
        body: SafeArea(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: EdgeInsets.all(16.w),
                  children: [
                    _campaignCard(scheme),
                    SizedBox(height: 16.h),
                    if (_existing != null)
                      _appealStatusCard(scheme)
                    else
                      _composer(scheme),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _campaignCard(ColorScheme scheme) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrowdfundModerationBadge(moderation: widget.campaign.moderation),
          SizedBox(height: 8.h),
          Text(
            widget.campaign.title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          if (widget.campaign.moderation.reason.trim().isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              widget.campaign.moderation.reason,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
          if (FeatureFlags.crowdfundPolicyUrl != null) ...[
            SizedBox(height: 10.h),
            InkWell(
              onTap: () => showWebViewBottomSheet(
                context,
                url: FeatureFlags.crowdfundPolicyUrl!,
                title: 'Crowdfunding policy',
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.open_in_new_rounded,
                      size: 13.sp, color: scheme.primary),
                  SizedBox(width: 6.w),
                  Text(
                    'Read the crowdfunding policy',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _composer(ColorScheme scheme) {
    final len = _controller.text.trim().length;
    final tooShort = len < _minChars;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us why this should be published',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'A person will read this. The more specific you are about what the '
          'money is for and who it reaches, the more there is to go on.',
          style: TextStyle(
            fontSize: 12.sp,
            height: 1.45,
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 12.h),
        TextField(
          controller: _controller,
          maxLines: 8,
          minLines: 5,
          maxLength: _maxChars,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText:
                'What the campaign is raising for, and anything that shows it '
                'is genuine…',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        if (tooShort && len > 0)
          Text(
            'A little more detail — at least $_minChars characters.',
            style: TextStyle(fontSize: 11.sp, color: scheme.error),
          ),
        if (_error != null) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: scheme.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: scheme.error.withValues(alpha: 0.22)),
            ),
            child: Text(
              _error!,
              style: TextStyle(fontSize: 12.sp, color: scheme.error),
            ),
          ),
        ],
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: (_submitting || tooShort) ? null : _submit,
            child: Text(_submitting ? 'Sending…' : 'Submit appeal'),
          ),
        ),
      ],
    );
  }

  Widget _appealStatusCard(ColorScheme scheme) {
    final a = _existing!;
    final (title, body, colour) = switch (a.status) {
      CrowdfundAppealStatus.open => (
          'We are reviewing your appeal',
          'Someone from our team will look at your campaign again and we will '
              'let you know the outcome. You do not need to do anything.',
          scheme.onSurfaceVariant,
        ),
      CrowdfundAppealStatus.approved => (
          'Your appeal was upheld 🎉',
          a.hasDecision
              ? a.decision
              : 'Your campaign is published and can accept contributions.',
          scheme.primary,
        ),
      CrowdfundAppealStatus.rejected => (
          'Your appeal was not upheld',
          a.hasDecision
              ? a.decision
              : 'The campaign stays unpublished under our crowdfunding policy.',
          scheme.error,
        ),
      CrowdfundAppealStatus.withdrawn => (
          'This appeal was withdrawn',
          'You can appeal again if the campaign is still unpublished.',
          scheme.onSurfaceVariant,
        ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: colour,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.45,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'What you told us',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Text(
            a.message,
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.5,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        // A REJECTED APPEAL MAY BE APPEALABLE AGAIN, and may not — the cap is
        // an operator setting. `canAppeal` is the server's answer, so the
        // button only appears when it will be accepted.
        if (!a.isOpen && widget.campaign.moderation.canAppeal) ...[
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => setState(() => _existing = null),
              child: const Text('Appeal again'),
            ),
          ),
        ],
      ],
    );
  }
}
