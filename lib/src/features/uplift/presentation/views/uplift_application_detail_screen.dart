import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_milestones_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_offer_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Full-detail view of a single Lazerfunds application. Reached by tapping an
/// application from the fund detail screen. Presents everything about the
/// application (pitch, amounts, equity/counter terms, images, documents,
/// milestones, endorsements) and — when a [chatTargetUserId] is supplied —
/// lets the two parties open a 1:1 P2P chat.
///
/// The caller decides the chat counterparty so the button only appears for the
/// two people in the deal:
///   • funder viewing an applicant  → chat target = the applicant (business)
///   • applicant viewing their own  → chat target = the funder (investor)
///   • community endorser           → chatTargetUserId null ⇒ no Message button
class UpliftApplicationDetailScreen extends StatefulWidget {
  const UpliftApplicationDetailScreen({
    required this.application,
    required this.fund,
    this.showFunderActions = false,
    this.chatTargetUserId,
    this.chatTargetName,
    this.chatTargetAvatar,
    super.key,
  });

  final up.UpliftApplicationMessage application;
  final up.UpliftFundMessage fund;

  /// Funder-only decision actions (shortlist / reject / select & fund).
  final bool showFunderActions;

  /// Counterparty for the P2P chat. When null/empty, no Message button shows.
  final String? chatTargetUserId;
  final String? chatTargetName;
  final String? chatTargetAvatar;

  @override
  State<UpliftApplicationDetailScreen> createState() => _UpliftApplicationDetailScreenState();
}

class _UpliftApplicationDetailScreenState extends State<UpliftApplicationDetailScreen> {
  final _repo = serviceLocator<UpliftRepository>();
  late up.UpliftApplicationMessage _app = widget.application;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  /// Best-effort refresh — pulls the freshest application (incl. milestones)
  /// so status/evidence reflect the latest state. Never blocks the page.
  Future<void> _refresh() async {
    try {
      final fresh = await _repo.getApplication(_app.id);
      if (mounted) setState(() => _app = fresh);
    } catch (_) {
      // Keep the passed-in snapshot on failure.
    }
  }

  bool get _canChat => (widget.chatTargetUserId ?? '').isNotEmpty;

  void _openChat() {
    final id = widget.chatTargetUserId ?? '';
    if (id.isEmpty) {
      _snack('Chat is not available for this application.', kUpError);
      return;
    }
    final avatar = widget.chatTargetAvatar;
    Get.toNamed(AppRoutes.p2pChat, arguments: {
      'otherUserId': id,
      'otherUserName': (widget.chatTargetName?.trim().isNotEmpty ?? false)
          ? widget.chatTargetName!.trim()
          : 'Lazervault user',
      'otherUserAvatar': (avatar?.isNotEmpty ?? false) ? avatar : null,
    });
  }

  Future<void> _review(String action) async {
    String reason = '';
    if (action == 'reject') {
      final r = await _promptText('Reject application', 'Reason');
      if (r == null) return;
      reason = r;
    }
    setState(() => _busy = true);
    try {
      await _repo.review(_app.id, action, reason: reason);
      await _refresh();
    } catch (e) {
      _snack(upFriendlyError(e), kUpError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _select() async {
    final ok = await Get.to<bool>(() => UpliftOfferScreen(
          application: _app,
          currency: widget.fund.currency,
          capKobo: widget.fund.perBusinessCap.toInt(),
        ));
    if (ok == true) await _refresh();
  }

  Future<void> _openMilestones() async {
    await Get.to(() => UpliftMilestonesScreen(applicationId: _app.id, isFunder: widget.showFunderActions));
    await _refresh();
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _snack('Could not open the document.', kUpError);
    }
  }

  void _snack(String msg, Color bg) => Get.snackbar('', msg,
      titleText: const SizedBox.shrink(),
      messageText: Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: bg,
      snackPosition: SnackPosition.BOTTOM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Application'),
      body: UpGradientScaffoldBody(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _header(),
              if (_canChat) ...[
                const SizedBox(height: 12),
                _messageButton(),
              ],
              const SizedBox(height: 14),
              _pitchCard(),
              const SizedBox(height: 12),
              _amountsCard(),
              _dealTermsCard(),
              _imagesSection(),
              _docsSection(),
              _milestonesSection(),
              const SizedBox(height: 16),
              _endorsements(),
              if (widget.showFunderActions) ...[
                const SizedBox(height: 20),
                ..._funderActions(),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final a = _app;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UpGradientAvatar(text: a.businessName, size: 48, radius: 12),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(a.businessName,
                  style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              if (a.businessCategory.isNotEmpty)
                Text(a.businessCategory, style: const TextStyle(color: kUpTextSecondary, fontSize: 13)),
              const SizedBox(height: 6),
              UpStatusChip(label: upAppStatusLabel(a.status)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _messageButton() {
    final name = (widget.chatTargetName?.trim().isNotEmpty ?? false) ? widget.chatTargetName!.trim() : 'the other party';
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: kUpPrimary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
      ),
      onPressed: _openChat,
      icon: const Icon(Icons.chat_bubble_outline),
      label: Text('Message $name'),
    );
  }

  Widget _pitchCard() {
    final pitch = _app.pitch.trim();
    return UpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pitch & use of funds',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(pitch.isEmpty ? 'No pitch provided.' : pitch,
              style: const TextStyle(color: Colors.white70, height: 1.4)),
        ],
      ),
    );
  }

  Widget _amountsCard() {
    final a = _app;
    return UpCard(
      child: Column(
        children: [
          _row('Requested', upNaira(a.requestedAmount.toInt(), a.currency)),
          if (a.approvedAmount > 0) _row('Approved', upNaira(a.approvedAmount.toInt(), a.currency)),
          _row('Endorsements', '❤ ${a.endorsementCount}'),
        ],
      ),
    );
  }

  Widget _dealTermsCard() {
    final a = _app;
    final hasEquity = a.proposedEquityPct > 0 || a.agreedEquityPct > 0 || a.investmentType.isNotEmpty;
    if (!hasEquity && !a.hasCounter && a.equityNote.isEmpty) return const SizedBox.shrink();
    return UpCard(
      margin: const EdgeInsets.only(top: 12),
      borderColor: kUpPrimary.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.handshake, size: 16, color: kUpPrimarySoft),
            SizedBox(width: 6),
            Text('Deal terms', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          if (a.investmentType.isNotEmpty) _row('Type', upInvestmentTypeLabel(a.investmentType)),
          if (a.agreedEquityPct > 0) _row('Agreed equity', upPct(a.agreedEquityPct)),
          if (a.agreedEquityPct == 0 && a.proposedEquityPct > 0) _row('Proposed equity', upPct(a.proposedEquityPct)),
          if (a.hasCounter)
            _row('Counter',
                '${upNaira(a.counterAmount.toInt(), a.currency)}${a.counterEquityPct > 0 ? ' · ${upPct(a.counterEquityPct)}' : ''}'),
          if (a.counterNote.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(a.counterNote, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
          if (a.equityNote.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(a.equityNote, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ],
      ),
    );
  }

  Widget _imagesSection() {
    final imgs = _app.images;
    if (imgs.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: imgs.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imgs[i], width: 110, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink()),
          ),
        ),
      ),
    );
  }

  Widget _docsSection() {
    final docs = _app.docUrls;
    if (docs.isEmpty) return const SizedBox.shrink();
    return UpCard(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Documents', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          for (var i = 0; i < docs.length; i++)
            InkWell(
              onTap: () => _openUrl(docs[i]),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(children: [
                  const Icon(Icons.description_outlined, size: 18, color: kUpPrimarySoft),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Document ${i + 1}',
                        style: const TextStyle(color: kUpPrimarySoft, decoration: TextDecoration.underline)),
                  ),
                  const Icon(Icons.open_in_new, size: 16, color: kUpTextSecondary),
                ]),
              ),
            ),
        ],
      ),
    );
  }

  Widget _milestonesSection() {
    final ms = _app.milestones;
    if (ms.isEmpty) return const SizedBox.shrink();
    return UpCard(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Milestones', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          for (final m in ms)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(children: [
                Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(8)),
                  child: Text('${m.sequence}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      Text(_milestoneStatusLabel(m.status),
                          style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                Text(upNaira(m.amount.toInt(), _app.currency),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ]),
            ),
        ],
      ),
    );
  }

  String _milestoneStatusLabel(up.UpliftMilestoneStatus s) =>
      s.name.replaceFirst('UPLIFT_MILESTONE_STATUS_', '').toLowerCase().replaceAll('_', ' ');

  Widget _endorsements() => Text('${_app.endorsementCount} endorsement${_app.endorsementCount == 1 ? '' : 's'} from the community',
      style: const TextStyle(color: kUpTextSecondary, fontSize: 12));

  List<Widget> _funderActions() {
    final a = _app;
    final canAct = a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SUBMITTED ||
        a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_UNDER_REVIEW ||
        a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SHORTLISTED ||
        a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_NEGOTIATING;
    final inFunding = a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS ||
        a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_COMPLETED;
    return [
      const Text('Decision', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      if (canAct)
        Row(children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white, minimumSize: const Size.fromHeight(46), side: const BorderSide(color: kUpDivider)),
              onPressed: _busy ? null : () => _review('shortlist'),
              child: const Text('Shortlist'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: kUpError, minimumSize: const Size.fromHeight(46), side: const BorderSide(color: kUpError)),
              onPressed: _busy ? null : () => _review('reject'),
              child: const Text('Reject'),
            ),
          ),
        ]),
      if (canAct) const SizedBox(height: 10),
      if (canAct)
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
          onPressed: _busy ? null : _select,
          icon: Icon(a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_NEGOTIATING ? Icons.swap_horiz : Icons.savings),
          label: Text(a.status == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_NEGOTIATING ? 'Review counter & re-offer' : 'Select & fund'),
        ),
      if (inFunding)
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
          onPressed: _openMilestones,
          icon: const Icon(Icons.flag),
          label: const Text('Review milestones'),
        ),
    ];
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(k, style: const TextStyle(color: kUpTextSecondary)),
          Flexible(child: Text(v, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
        ]),
      );

  Future<String?> _promptText(String title, String label) async {
    final c = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kUpCard,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: TextField(
          controller: c,
          autofocus: true,
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: kUpTextSecondary)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, c.text), child: const Text('Confirm')),
        ],
      ),
    );
  }
}
