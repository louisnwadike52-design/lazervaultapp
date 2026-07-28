import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_commit_screen.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/views/apply_uplift_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_application_detail_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/create_uplift_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_funding_activity_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_milestones_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Fund detail — the shared hub for both journeys. The funder sees the pool /
/// escrow state, can commit funds (PIN), and reviews/selects applicants.
/// Everyone else sees the fund story and can apply / endorse. An applicant with
/// a pending offer can accept or decline here.
class UpliftDetailScreen extends StatefulWidget {
  const UpliftDetailScreen({required this.fundId, this.applicationId, super.key});
  final String fundId;
  final String? applicationId;

  @override
  State<UpliftDetailScreen> createState() => _UpliftDetailScreenState();
}

class _UpliftDetailScreenState extends State<UpliftDetailScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  final _repo = serviceLocator<UpliftRepository>();
  up.UpliftFundMessage? _fund;
  List<up.UpliftApplicationMessage> _applications = [];
  up.GetUpliftStatisticsResponse? _stats;
  up.GetUpliftEscrowBalanceResponse? _escrow;
  bool _loading = true;
  String? _error;

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
      final fund = await _repo.getFund(widget.fundId);
      // Funder sees the full application list; everyone else sees the public
      // endorsement view (active applications on a visible fund). A private
      // fund throws for non-funders — swallow it and show none.
      List<up.UpliftApplicationMessage> apps = [];
      try {
        apps = await _repo.listApplications(fundId: fund.id, sortBy: 'most_endorsed');
      } catch (_) {
        apps = [];
      }
      // Live stats + escrow balance are funder-only extras — best-effort so a
      // failure here never blocks the detail page.
      up.GetUpliftStatisticsResponse? stats;
      up.GetUpliftEscrowBalanceResponse? escrow;
      if (fund.isFunder) {
        try {
          stats = await _repo.statistics(fund.id);
        } catch (_) {}
        try {
          escrow = await _repo.escrowBalance(fund.id);
        } catch (_) {}
      }
      setState(() {
        _fund = fund;
        _applications = apps;
        _stats = stats;
        _escrow = escrow;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = upFriendlyError(e);
        _loading = false;
      });
    }
  }

  Future<void> _commitPool() async {
    final ok = await Get.to<bool>(() => UpliftCommitScreen(fund: _fund!));
    if (ok == true) await _load();
  }

  Future<void> _cancelFund() async {
    final fund = _fund!;
    final reason = await _promptText('Cancel fund', 'Reason (min 10 chars)');
    if (reason == null || reason.trim().length < 10) return;
    final txId = 'UPLIFT-CANCEL-${DateTime.now().microsecondsSinceEpoch}';
    await validateTransactionPin(
      context: context,
      transactionId: txId,
      transactionType: 'uplift_fund_cancel',
      amount: 0,
      currency: fund.currency,
      onPinValidated: (verificationToken) async {
        await _repo.cancelFund(fundId: fund.id, reason: reason.trim(), pinToken: verificationToken, transactionId: txId);
        await _load();
      },
    );
  }

  Future<void> _respondToOffer(bool accept) async {
    if (widget.applicationId == null) return;
    try {
      await _repo.respondToOffer(applicationId: widget.applicationId!, accept: accept);
      Get.snackbar(accept ? 'Offer accepted' : 'Offer declined', '',
          backgroundColor: kUpCard, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      await _load();
    } catch (e) {
      _err(e);
    }
  }

  Future<void> _negotiate() async {
    if (widget.applicationId == null) return;
    final f = _fund!;
    final amountCtrl = TextEditingController();
    final equityCtrl = TextEditingController();
    final noteCtrl = TextEditingController();
    final ok = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: kUpBg,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Counter the offer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 4),
          const Text('Propose terms you\'d accept — the investor reviews and re-offers.', style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
          const SizedBox(height: 12),
          _sheetField(amountCtrl, 'Amount you want (₦)', keyboard: TextInputType.number),
          const SizedBox(height: 10),
          _sheetField(equityCtrl, 'Equity you\'ll give (%)', keyboard: TextInputType.number),
          const SizedBox(height: 10),
          _sheetField(noteCtrl, 'Note (optional)', maxLines: 2),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Send counter'),
          ),
          const SizedBox(height: 16),
        ]),
      ),
    );
    if (ok != true) return;
    try {
      await _repo.respondToOffer(
        applicationId: widget.applicationId!,
        accept: false,
        counter: true,
        counterAmountKobo: ((double.tryParse(amountCtrl.text.trim()) ?? 0) * 100).round(),
        counterEquityPct: ((double.tryParse(equityCtrl.text.trim()) ?? 0) * 100).round(),
        counterNote: noteCtrl.text.trim(),
      );
      Get.snackbar('Counter sent', '${f.title} will review your terms',
          backgroundColor: kUpCard, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      await _load();
    } catch (e) {
      _err(e);
    }
  }

  Widget _sheetField(TextEditingController c, String label, {int maxLines = 1, TextInputType? keyboard}) => TextField(
        controller: c,
        maxLines: maxLines,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: kUpTextSecondary),
          filled: true,
          fillColor: kUpCard,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      );

  Future<void> _editFund() async {
    final changed = await Get.to<bool>(() => CreateUpliftScreen(existing: _fund));
    if (changed == true) await _load();
  }

  Future<void> _publishFund() async {
    try {
      await _repo.publishFund(_fund!.id);
      await _load();
      Get.snackbar('Published', 'Your fund is now accepting applications',
          backgroundColor: kUpCard, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      _err(e);
    }
  }

  Future<void> _pauseResume(bool resume) async {
    try {
      await _repo.pauseFund(_fund!.id, resume: resume);
      await _load();
    } catch (e) {
      _err(e);
    }
  }

  Future<void> _withdrawApplication() async {
    final id = _fund?.myApplicationId ?? '';
    if (id.isEmpty) return;
    final confirmed = await Get.dialog<bool>(AlertDialog(
      backgroundColor: kUpCard,
      title: const Text('Withdraw application?', style: TextStyle(color: Colors.white)),
      content: const Text('You can re-apply while the fund is still open.', style: TextStyle(color: kUpTextSecondary)),
      actions: [
        TextButton(onPressed: () => Get.back(result: false), child: const Text('Keep')),
        TextButton(onPressed: () => Get.back(result: true), child: const Text('Withdraw', style: TextStyle(color: kUpError))),
      ],
    ));
    if (confirmed != true) return;
    try {
      await _repo.withdraw(id);
      await _load();
    } catch (e) {
      _err(e);
    }
  }

  /// Funder opens an applicant's full details — with decision actions and a
  /// chat targeting the applicant (business).
  Future<void> _openFunderAppDetail(up.UpliftApplicationMessage a) async {
    await Get.to(() => UpliftApplicationDetailScreen(
          application: a,
          fund: _fund!,
          showFunderActions: true,
          chatTargetUserId: a.applicant.userUuid,
          chatTargetName: a.businessName.isNotEmpty ? a.businessName : a.applicant.displayName,
          chatTargetAvatar: a.applicant.profilePicture,
        ));
    await _load();
  }

  /// Applicant opens their own application — read-only, with a chat targeting
  /// the investor (fund owner).
  Future<void> _openMyAppDetail() async {
    final f = _fund!;
    if (f.myApplicationId.isEmpty) return;
    up.UpliftApplicationMessage? mine;
    try {
      mine = await _repo.getApplication(f.myApplicationId);
    } catch (_) {
      for (final a in _applications) {
        if (a.id == f.myApplicationId) {
          mine = a;
          break;
        }
      }
    }
    final app = mine;
    if (app == null) return;
    await Get.to(() => UpliftApplicationDetailScreen(
          application: app,
          fund: f,
          showFunderActions: false,
          chatTargetUserId: f.funder.userUuid,
          chatTargetName: f.funder.displayName.isNotEmpty ? f.funder.displayName : f.title,
          chatTargetAvatar: f.funder.profilePicture,
        ));
    await _load();
  }

  /// Community viewer opens an applicant's details — read-only, no chat.
  Future<void> _openCommunityAppDetail(up.UpliftApplicationMessage a) async {
    final own = a.id == _fund!.myApplicationId;
    await Get.to(() => UpliftApplicationDetailScreen(
          application: a,
          fund: _fund!,
          showFunderActions: false,
          // Own application in the community list ⇒ still allow messaging the investor.
          chatTargetUserId: own ? _fund!.funder.userUuid : null,
          chatTargetName: own ? (_fund!.funder.displayName.isNotEmpty ? _fund!.funder.displayName : _fund!.title) : null,
          chatTargetAvatar: own ? _fund!.funder.profilePicture : null,
        ));
    await _load();
  }

  Future<void> _endorse(up.UpliftApplicationMessage a) async {
    try {
      await _repo.endorse(a.id, remove: a.viewerHasEndorsed);
      await _load();
    } catch (e) {
      _err(e);
    }
  }

  void _err(Object e) => Get.snackbar('Error', upFriendlyError(e),
      backgroundColor: kUpError, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Fund details', actions: [
        if (_fund != null && _fund!.isFunder && _fundEditable(_fund!.status))
          IconButton(tooltip: 'Edit', icon: const Icon(Icons.edit, color: Colors.white), onPressed: _editFund),
      ]),
      body: UpGradientScaffoldBody(
        child: _loading
            ? const UpLoading()
            : _error != null
                ? UpErrorState(message: _error!, onRetry: _load)
                : _content(),
      ),
    );
  }

  Widget _content() {
    final f = _fund!;
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (f.coverImageUrl.isNotEmpty) ...[
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(f.coverImageUrl, height: 150, width: double.infinity, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink())),
            const SizedBox(height: 14),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(f.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700))),
              const SizedBox(width: 10),
              Padding(padding: const EdgeInsets.only(top: 2), child: UpStatusChip(label: upFundStatusLabel(f.status))),
            ],
          ),
          const SizedBox(height: 6),
          Text('${f.category} · up to ${upNaira(f.perBusinessCap.toInt(), f.currency)} each · ${f.targetCount} businesses',
              style: const TextStyle(color: kUpTextSecondary, fontSize: 13)),
          const SizedBox(height: 12),
          Text(f.description, style: const TextStyle(color: Colors.white70, height: 1.4)),
          if (f.gallery.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: f.gallery.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(f.gallery[i], width: 100, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink())),
              ),
            ),
          ],
          const SizedBox(height: 16),
          _escrowCard(f),
          _equityCard(f),
          const SizedBox(height: 16),
          if (f.isFunder) ..._funderSection(f) else ..._applicantSection(f),
        ],
      ),
    );
  }

  Widget _escrowCard(up.UpliftFundMessage f) {
    final committed = f.committedPool.toInt();
    final released = f.releasedTotal.toInt();
    final progress = committed > 0 ? (released / committed).clamp(0.0, 1.0) : 0.0;
    return UpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.account_balance_wallet_outlined, size: 16, color: kUpPrimarySoft),
            SizedBox(width: 6),
            Text('Pool & escrow', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 12),
          _row('Committed', upNaira(committed, f.currency)),
          _row('Released', upNaira(released, f.currency)),
          // Refunded / allocation / live balance are funder operations — keep them
          // off the applicant + community view to reduce clutter.
          if (f.isFunder) ...[
            _row('Refunded', upNaira(f.refundedTotal.toInt(), f.currency)),
            _row('Available to allocate', upNaira(f.escrowAvailable.toInt(), f.currency)),
            if (_escrow != null)
              _row('Escrow wallet (live)', upNaira(_escrow!.balance.toInt(), f.currency)),
          ],
          const SizedBox(height: 12),
          UpProgressBar(value: progress),
        ],
      ),
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(k, style: const TextStyle(color: kUpTextSecondary)),
          Text(v, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ]),
      );

  Widget _equityCard(up.UpliftFundMessage f) {
    final eq = UpEquityTerms.fromMetadata(f.metadata);
    if (!eq.enabled) return const SizedBox.shrink();
    return UpCard(
      margin: const EdgeInsets.only(top: 12),
      borderColor: kUpPrimary.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.pie_chart, size: 16, color: kUpPrimarySoft),
            SizedBox(width: 6),
            Text('Deal structure', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          _row('Type', upInvestmentTypeLabel(eq.investmentType).isEmpty ? 'Equity' : upInvestmentTypeLabel(eq.investmentType)),
          if (eq.offeredPct > 0) _row('Equity per business', upPct(eq.offeredPct)),
          if (eq.valuation > 0) _row('Valuation', upNaira(eq.valuation, f.currency)),
          if (eq.terms.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(eq.terms, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ],
      ),
    );
  }

  Widget _statsStrip(up.GetUpliftStatisticsResponse s) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        UpStatChip(
            icon: Icons.savings,
            value: '${s.fundedPercentage.toStringAsFixed(0)}%',
            label: 'Funded',
            color: kUpPrimary),
        UpStatChip(
            icon: Icons.check_circle_outline,
            value: '${s.completedCount}/${s.selectedCount}',
            label: 'Completed',
            color: kUpSuccess),
        UpStatChip(
            icon: Icons.groups_outlined,
            value: '${s.applicationCount}',
            label: 'Applicants',
            color: kUpPrimarySoft),
        UpStatChip(
            icon: Icons.schedule,
            value: s.daysRemaining > 0 ? '${s.daysRemaining}' : '—',
            label: 'Days left',
            color: kUpWarning),
      ],
    );
  }

  bool _fundEditable(up.UpliftFundStatus s) =>
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_DRAFT ||
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN ||
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_REVIEWING ||
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED;

  List<Widget> _funderSection(up.UpliftFundMessage f) {
    final actionable = f.status != up.UpliftFundStatus.UPLIFT_FUND_STATUS_CANCELLED &&
        f.status != up.UpliftFundStatus.UPLIFT_FUND_STATUS_COMPLETED;
    return [
      // Draft funds: prominent publish CTA before anything else.
      if (f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_DRAFT) ...[
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: kUpSuccess, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
          onPressed: _publishFund,
          icon: const Icon(Icons.publish),
          label: const Text('Publish — start accepting applications'),
        ),
        const SizedBox(height: 12),
      ],
      if (_stats != null) ...[
        _statsStrip(_stats!),
        const SizedBox(height: 14),
      ],
      Row(children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
            onPressed: actionable ? _commitPool : null,
            icon: const Icon(Icons.savings),
            label: const Text('Commit funds'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(foregroundColor: kUpError, minimumSize: const Size.fromHeight(48), side: const BorderSide(color: kUpError)),
            onPressed: actionable ? _cancelFund : null,
            icon: const Icon(Icons.cancel),
            label: const Text('Cancel'),
          ),
        ),
      ]),
      const SizedBox(height: 10),
      Row(children: [
        if (f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_REVIEWING ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED)
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: kUpWarning, minimumSize: const Size.fromHeight(44), side: const BorderSide(color: kUpDivider)),
              onPressed: () => _pauseResume(f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED),
              icon: Icon(f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED ? Icons.play_arrow : Icons.pause),
              label: Text(f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED ? 'Resume' : 'Pause'),
            ),
          ),
        if (f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_REVIEWING ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED)
          const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, minimumSize: const Size.fromHeight(44), side: const BorderSide(color: kUpDivider)),
            onPressed: () => Get.to(() => UpliftFundingActivityScreen(fundId: f.id, currency: f.currency)),
            icon: const Icon(Icons.receipt_long),
            label: const Text('Funding activity'),
          ),
        ),
      ]),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Applications', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
          Text('${f.applicationCount} total · ${f.selectedCount}/${f.targetCount} selected',
              style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
        ],
      ),
      const SizedBox(height: 8),
      if (_applications.isEmpty)
        const Padding(padding: EdgeInsets.all(16), child: Text('No applications yet.', style: TextStyle(color: kUpTextSecondary))),
      for (final a in _applications) _funderApplicationTile(a),
    ];
  }

  /// Compact, tappable applicant summary. Every decision (shortlist / reject /
  /// select & fund / review counter / review milestones) lives on the
  /// application detail screen this opens — keeping the list scannable.
  Widget _funderApplicationTile(up.UpliftApplicationMessage a) {
    return UpCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _openFunderAppDetail(a),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UpGradientAvatar(text: a.businessName, size: 36, radius: 9),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.businessName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text('Requested ${upNaira(a.requestedAmount.toInt(), a.currency)} · ❤ ${a.endorsementCount}',
                            style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  UpStatusChip(label: upAppStatusLabel(a.status)),
                ],
              ),
              if (a.pitch.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(a.pitch, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
              if (a.agreedEquityPct > 0 || a.proposedEquityPct > 0 || a.hasCounter) ...[
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  if (a.agreedEquityPct > 0) UpEquityChip(label: 'Offered ${upPct(a.agreedEquityPct)}'),
                  if (a.agreedEquityPct == 0 && a.proposedEquityPct > 0) UpEquityChip(label: 'Proposes ${upPct(a.proposedEquityPct)}', icon: Icons.handshake),
                  if (a.hasCounter)
                    UpEquityChip(
                      icon: Icons.swap_horiz,
                      label: 'Counter ${upNaira(a.counterAmount.toInt(), a.currency)}${a.counterEquityPct > 0 ? ' · ${upPct(a.counterEquityPct)}' : ''}',
                    ),
                ]),
              ],
              const SizedBox(height: 10),
              Row(children: [
                Icon(Icons.touch_app_outlined, size: 14, color: kUpPrimarySoft.withOpacity(0.9)),
                const SizedBox(width: 6),
                Text(_funderTileHint(a.status),
                    style: const TextStyle(color: kUpPrimarySoft, fontSize: 12, fontWeight: FontWeight.w500)),
                const Spacer(),
                const Icon(Icons.chevron_right, color: kUpTextSecondary, size: 20),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  String _funderTileHint(up.UpliftApplicationStatus s) {
    switch (s) {
      case up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SUBMITTED:
      case up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_UNDER_REVIEW:
      case up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SHORTLISTED:
        return 'Tap to review & decide';
      case up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_NEGOTIATING:
        return 'Tap to review counter';
      case up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS:
      case up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_COMPLETED:
        return 'Tap to review milestones';
      default:
        return 'Tap to view details';
    }
  }

  List<Widget> _applicantSection(up.UpliftFundMessage f) {
    final hasOffer = f.myApplicationStatus == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SELECTED;
    final negotiating = f.myApplicationStatus == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_NEGOTIATING;
    final hasApplied = f.myApplicationId.isNotEmpty;
    return [
      if (hasOffer) ...[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kUpSuccess.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kUpSuccess.withOpacity(0.4)),
          ),
          child: Column(children: [
            Row(children: const [
              Text('🎉', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Expanded(child: Text('You have a funding offer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15))),
            ]),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Open your application to see the full terms, then respond.',
                  style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: kUpSuccess, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(46)),
                onPressed: () => _respondToOffer(true),
                icon: const Icon(Icons.check_circle, size: 18),
                label: const Text('Accept offer'),
              ),
            ),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(44), side: const BorderSide(color: kUpPrimary)),
                      onPressed: _negotiate,
                      child: const Text('Negotiate', style: TextStyle(color: kUpPrimarySoft)))),
              const SizedBox(width: 8),
              Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(44), side: const BorderSide(color: kUpDivider)),
                      onPressed: () => _respondToOffer(false),
                      child: const Text('Decline', style: TextStyle(color: Colors.white)))),
            ]),
          ]),
        ),
        const SizedBox(height: 12),
      ],
      if (negotiating) ...[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kUpPrimary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kUpPrimary.withOpacity(0.4)),
          ),
          child: Row(children: const [
            Icon(Icons.hourglass_top, color: kUpPrimarySoft),
            SizedBox(width: 10),
            Expanded(child: Text('Counter sent — awaiting the investor\'s response.', style: TextStyle(color: Colors.white))),
          ]),
        ),
        const SizedBox(height: 12),
      ],
      if (!hasApplied && f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN)
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50)),
          onPressed: () async {
            await Get.to(() => ApplyUpliftScreen(fund: f));
            _load();
          },
          icon: const Icon(Icons.send),
          label: const Text('Apply for funding'),
        )
      else if (hasApplied) ...[
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _openMyAppDetail,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kUpCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kUpDivider),
            ),
            child: Row(children: [
              const Icon(Icons.info_outline, color: kUpTextSecondary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your application status: ${upAppStatusLabel(f.myApplicationStatus)}', style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 2),
                    const Text('View details & message the investor', style: TextStyle(color: kUpPrimarySoft, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: kUpTextSecondary),
            ]),
          ),
        ),
        if (f.myApplicationStatus == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS ||
            f.myApplicationStatus == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_COMPLETED) ...[
          const SizedBox(height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
            onPressed: () async {
              await Get.to(() => UpliftMilestonesScreen(applicationId: f.myApplicationId, isFunder: false));
              _load();
            },
            icon: const Icon(Icons.flag),
            label: const Text('View milestones & submit evidence'),
          ),
        ],
        // Withdraw is allowed before funding starts.
        if (f.myApplicationStatus == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SUBMITTED ||
            f.myApplicationStatus == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_UNDER_REVIEW ||
            f.myApplicationStatus == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SHORTLISTED) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _withdrawApplication,
              icon: const Icon(Icons.undo, size: 18, color: kUpError),
              label: const Text('Withdraw application', style: TextStyle(color: kUpError)),
            ),
          ),
        ],
      ],
      // Community endorsement — anyone can back other applicants.
      if (_applications.isNotEmpty) ...[
        const SizedBox(height: 22),
        const Text('Applicants', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text('Endorse the businesses you believe in — the funder sees community support.',
            style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
        const SizedBox(height: 10),
        for (final a in _applications)
          UpliftApplicationCard(
            application: a,
            onTap: () => _openCommunityAppDetail(a),
            // The viewer's own application (matched via the fund's
            // my_application_id) can't be self-endorsed.
            trailing: a.id == f.myApplicationId
                ? const Chip(
                    backgroundColor: kUpCard,
                    label: Text('Your application', style: TextStyle(color: kUpTextSecondary, fontSize: 11)),
                  )
                : TextButton.icon(
                    onPressed: () => _endorse(a),
                    icon: Icon(a.viewerHasEndorsed ? Icons.favorite : Icons.favorite_border,
                        size: 18, color: a.viewerHasEndorsed ? kUpError : kUpTextSecondary),
                    label: Text(a.viewerHasEndorsed ? 'Endorsed' : 'Endorse',
                        style: TextStyle(color: a.viewerHasEndorsed ? kUpError : kUpTextSecondary)),
                  ),
          ),
      ],
    ];
  }

  // ---- small prompt helpers ----

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
