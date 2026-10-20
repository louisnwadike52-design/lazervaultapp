import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/config/feature_flags.dart';
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
  const UpliftDetailScreen(
      {required this.fundId, this.applicationId, super.key});
  final String fundId;
  final String? applicationId;

  @override
  State<UpliftDetailScreen> createState() => _UpliftDetailScreenState();
}

class _UpliftDetailScreenState extends State<UpliftDetailScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

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
    _load(showSpinner: true);
  }

  /// Re-reads the fund.
  ///
  /// [showSpinner] REPLACES the page with a loader while it runs. That is
  /// right for the first load and for retrying after an error — there is
  /// nothing on screen worth keeping. It is wrong everywhere else, and it was
  /// the default: every CTA ended `await Get.to(...); await _load();`, so
  /// coming back from ANY of them — even one that changed nothing, even
  /// Cancel — blanked the page to a spinner and reset the scroll position.
  /// On a page this long that reads as the screen reloading itself, which is
  /// exactly how it was reported.
  ///
  /// A quiet refresh fetches the same data and swaps it in on arrival. The
  /// user keeps their place and sees the new numbers appear.
  Future<void> _load({bool showSpinner = false}) async {
    setState(() {
      if (showSpinner) _loading = true;
      _error = null;
    });
    try {
      final fund = await _repo.getFund(widget.fundId);
      // Funder sees the full application list; everyone else sees the public
      // endorsement view (active applications on a visible fund). A private
      // fund throws for non-funders — swallow it and show none.
      List<up.UpliftApplicationMessage> apps = [];
      try {
        apps = await _repo.listApplications(
            fundId: fund.id, sortBy: 'most_endorsed');
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
        await _repo.cancelFund(
            fundId: fund.id,
            reason: reason.trim(),
            pinToken: verificationToken,
            transactionId: txId);
        await _load();
      },
    );
  }

  /// Take uncommitted pool money back without closing the fund.
  ///
  /// The ceiling comes from the SERVER, not from arithmetic here: it also has
  /// to subtract refunds already in flight, which the app cannot see. The
  /// sheet shows `escrow_available` and the server refuses anything above
  /// what is genuinely free, so the two can never disagree.
  Future<void> _withdrawPool() async {
    final fund = _fund!;
    final availableKobo =
        _escrow?.available.toInt() ?? fund.escrowAvailable.toInt();
    if (availableKobo <= 0) {
      Get.snackbar('Nothing to withdraw',
          'This pool is either empty or fully promised to businesses you have selected.',
          backgroundColor: kUpCard,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final ctrl =
        TextEditingController(text: (availableKobo / 100).toStringAsFixed(2));

    // LIVE VALIDATION, inside the dialog.
    //
    // The cap was only enforced after the dialog closed — an over-limit
    // amount dismissed the sheet and then threw a snackbar, and a blank or
    // zero amount hit `if (major == null || major <= 0) return;`, which did
    // nothing at all: the funder tapped Withdraw and the button appeared
    // dead. Both now resolve in place, against the same availableKobo the
    // server will enforce, so the Withdraw action is only ever offered for an
    // amount that can actually succeed.
    String? errorFor(String raw) {
      final text = raw.trim();
      if (text.isEmpty) return 'Enter an amount';
      final major = double.tryParse(text);
      if (major == null) return 'Enter a valid amount';
      if (major <= 0) return 'Amount must be more than zero';
      // Compare in MINOR units: 0.1 + 0.2 style drift in major units can
      // reject an amount that is exactly the available balance.
      final kobo = (major * 100).round();
      if (kobo > availableKobo) {
        return 'Only ${upNaira(availableKobo, fund.currency)} is free to '
            'withdraw, the rest is promised to businesses you selected.';
      }
      return null;
    }

    final amount = await showDialog<int>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final error = errorFor(ctrl.text);
          return AlertDialog(
            backgroundColor: kUpCard,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Withdraw from pool',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Up to ${upNaira(availableKobo, fund.currency)} is free to take '
                  'back. Money already promised to a selected business stays put.',
                  style: const TextStyle(color: kUpTextSecondary, height: 1.4),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: ctrl,
                  autofocus: true,
                  onChanged: (_) => setDialogState(() {}),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Amount (${fund.currency})',
                    labelStyle: const TextStyle(color: kUpTextSecondary),
                    errorText: error,
                    errorMaxLines: 3,
                    // One tap to take everything that is actually free, so the
                    // funder never has to retype the cap they were just shown.
                    suffixIcon: TextButton(
                      onPressed: () => setDialogState(() {
                        ctrl.text = (availableKobo / 100).toStringAsFixed(2);
                        ctrl.selection = TextSelection.fromPosition(
                            TextPosition(offset: ctrl.text.length));
                      }),
                      child: const Text('Max',
                          style: TextStyle(
                              color: kUpPrimary, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('It returns to your personal account.',
                    style: TextStyle(color: kUpTextSecondary, fontSize: 11.5)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel',
                    style: TextStyle(color: kUpTextSecondary)),
              ),
              TextButton(
                // Disabled rather than silently doing nothing: the old handler
                // returned on an invalid amount, which looked like a broken
                // button.
                onPressed: error != null
                    ? null
                    : () => Navigator.of(ctx)
                        .pop((double.parse(ctrl.text.trim()) * 100).round()),
                child: Text('Withdraw',
                    style: TextStyle(
                        color: error != null ? kUpTextSecondary : kUpPrimary,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          );
        },
      ),
    );
    if (amount == null || !mounted) return;
    // Checked here too so the funder is told before a PIN entry is spent on a
    // refusal the screen already had the numbers to predict.
    if (amount > availableKobo) {
      Get.snackbar('More than is available',
          'You can withdraw up to ${upNaira(availableKobo, fund.currency)} right now.',
          backgroundColor: kUpError,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final txId = 'UPLIFT-WITHDRAW-${DateTime.now().microsecondsSinceEpoch}';
    await validateTransactionPin(
      context: context,
      transactionId: txId,
      transactionType: 'uplift_pool_withdraw',
      amount: amount / 100,
      currency: fund.currency,
      onPinValidated: (verificationToken) async {
        final resp = await _repo.withdrawPool(
          fundId: fund.id,
          amountKobo: amount,
          pinToken: verificationToken,
          transactionId: txId,
        );
        Get.snackbar('Withdrawal started',
            '${upNaira(resp.withdrawnAmount.toInt(), fund.currency)} is on its way to your account.',
            backgroundColor: kUpCard,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        await _load();
      },
    );
  }

  /// Remove the fund from the funder's own lists.
  ///
  /// No PIN: this moves no money, and the server refuses outright while any
  /// is still in the pool or in flight. The dialog says plainly that the
  /// record is kept, because "delete" otherwise reads as destroying the
  /// applications people submitted.
  Future<void> _deleteFund() async {
    final fund = _fund!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kUpCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Remove this fund?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        content: const Text(
          'It disappears from your funds and stops taking any further '
          'activity. The record is kept for our records and for the '
          'businesses that applied, this does not erase their applications.',
          style: TextStyle(color: kUpTextSecondary, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child:
                const Text('Keep', style: TextStyle(color: kUpTextSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Remove',
                style: TextStyle(color: kUpError, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await _repo.deleteFund(fundId: fund.id);
      Get.back(result: true);
      Get.snackbar('Fund removed', '${fund.title} is no longer in your list',
          backgroundColor: kUpCard,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // The server's sentence is the useful one — it names what is still in
      // the pool and what to do about it.
      _err(e);
    }
  }

  Future<void> _respondToOffer(bool accept) async {
    if (widget.applicationId == null) return;
    try {
      await _repo.respondToOffer(
          applicationId: widget.applicationId!, accept: accept);
      Get.snackbar(accept ? 'Offer accepted' : 'Offer declined', '',
          backgroundColor: kUpCard,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
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
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Counter the offer',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
              const SizedBox(height: 4),
              const Text(
                  'Propose terms you\'d accept, the investor reviews and re-offers.',
                  style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
              const SizedBox(height: 12),
              _sheetField(amountCtrl, 'Amount you want (₦)',
                  keyboard: TextInputType.number),
              const SizedBox(height: 10),
              _sheetField(equityCtrl, 'Equity you\'ll give (%)',
                  keyboard: TextInputType.number),
              const SizedBox(height: 10),
              _sheetField(noteCtrl, 'Note (optional)', maxLines: 2),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kUpPrimary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48)),
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
        counterAmountKobo:
            ((double.tryParse(amountCtrl.text.trim()) ?? 0) * 100).round(),
        counterEquityPct:
            ((double.tryParse(equityCtrl.text.trim()) ?? 0) * 100).round(),
        counterNote: noteCtrl.text.trim(),
      );
      Get.snackbar('Counter sent', '${f.title} will review your terms',
          backgroundColor: kUpCard,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      await _load();
    } catch (e) {
      _err(e);
    }
  }

  Widget _sheetField(TextEditingController c, String label,
          {int maxLines = 1, TextInputType? keyboard}) =>
      TextField(
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
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      );

  Future<void> _editFund() async {
    final changed =
        await Get.to<bool>(() => CreateUpliftScreen(existing: _fund));
    if (changed == true) await _load();
  }

  /// Opens a draft — funding the pool first when it is empty.
  ///
  /// This is the OTHER door into publishing. The create wizard funds before
  /// it publishes, and this button did not, so a fund could still open with
  /// nothing behind it — businesses pitching against a promise with no money.
  /// The server refuses an empty pool now, but bouncing the user off a
  /// refusal would be a worse answer than taking them to the thing that
  /// fixes it.
  Future<void> _publishFund() async {
    final fund = _fund!;
    if (fund.committedPool.toInt() <= 0) {
      final funded = await Get.to<bool>(
            () => UpliftCommitScreen(fund: fund, isFundingNewFund: true),
          ) ??
          false;
      if (!mounted) return;
      if (!funded) {
        // They declined to fund. The draft is untouched and still theirs to
        // finish; saying nothing here would read as the button being broken.
        Get.snackbar('Still a draft',
            'Commit money to the pool to start taking applications',
            backgroundColor: kUpCard,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        await _load();
        return;
      }
    }
    try {
      await _repo.publishFund(_fund!.id);
      await _load();
      Get.snackbar('Published', 'Your fund is now accepting applications',
          backgroundColor: kUpCard,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
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
      title: const Text('Withdraw application?',
          style: TextStyle(color: Colors.white)),
      content: const Text('You can re-apply while the fund is still open.',
          style: TextStyle(color: kUpTextSecondary)),
      actions: [
        TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Keep')),
        TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Withdraw', style: TextStyle(color: kUpError))),
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
          chatTargetName: a.businessName.isNotEmpty
              ? a.businessName
              : a.applicant.displayName,
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
          // NEVER the fund's title. A title is not a person, and this value
          // becomes the other party's name in Financial Connections — which
          // is how "Pilot Africa" ended up listed there as though it were
          // someone. Empty is honest; the button then says "the investor".
          chatTargetName: f.funder.displayName,
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
          chatTargetName: own ? _fund!.funder.displayName : null,
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
      backgroundColor: kUpError,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Fund details', actions: [
        if (_fund != null && _fund!.isFunder && _fundEditable(_fund!.status))
          IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: _editFund),
      ]),
      body: UpGradientScaffoldBody(
        child: _loading
            ? const UpLoading()
            : _error != null
                ? UpErrorState(
                    message: _error!, onRetry: () => _load(showSpinner: true))
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
            // Tappable: the list now shows a 64px thumbnail, so this is where
            // the cover is actually seen — and it should be openable at full
            // size rather than cropped to a 150px band forever.
            GestureDetector(
              onTap: () =>
                  showUpliftImageViewer(context, f.coverImageUrl, f.title),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: UpRemoteImage(
                      url: f.coverImageUrl,
                      height: 150,
                      width: double.infinity,
                      fallback: const SizedBox.shrink())),
            ),
            const SizedBox(height: 14),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(f.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700))),
              const SizedBox(width: 10),
              Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: UpStatusChip(label: upFundStatusLabel(f.status))),
            ],
          ),
          const SizedBox(height: 6),
          Text(
              '${f.category} · up to ${upNaira(f.perBusinessCap.toInt(), f.currency)} each · ${f.targetCount} businesses',
              style: const TextStyle(color: kUpTextSecondary, fontSize: 13)),
          // WHO IS BEHIND THIS FUND.
          //
          // A business deciding whether to pitch is deciding whether to pitch
          // to a PERSON, and the page named everyone involved except them.
          // Shown only when we actually know — an "Offered by" with nothing
          // after it is worse than the line being absent.
          if (f.funder.displayName.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.person_outline,
                    size: 14, color: kUpTextSecondary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Offered by ${f.funder.displayName.trim()}'
                    '${f.isFunder ? ' (you)' : ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: kUpTextSecondary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Text(f.description,
              style: const TextStyle(color: Colors.white70, height: 1.4)),
          if (f.gallery.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: f.gallery.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () =>
                      showUpliftImageViewer(context, f.gallery[i], f.title),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: UpRemoteImage(
                          url: f.gallery[i],
                          width: 100,
                          fallback: const SizedBox.shrink())),
                ),
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

  /// THE POOL, AS ONE FIGURE PLUS ITS BREAKDOWN.
  ///
  /// This was five full-width rows stacked — Committed, Released, Refunded,
  /// Available to allocate, Pool wallet (live) — each spending the whole
  /// width of a phone on a label and about twelve characters of money. Five
  /// rows of near-nothing is why the page did not fit, and nothing in it was
  /// emphasised: the number a funder actually looks for (what is in the pool)
  /// sat in the same type as the number they rarely do.
  ///
  /// Now: the committed total is the headline, and the rest is a two-column
  /// grid underneath. Same information, roughly a third of the height, with
  /// the important figure visibly the important one.
  Widget _escrowCard(up.UpliftFundMessage f) {
    final committed = f.committedPool.toInt();
    final released = f.releasedTotal.toInt();
    final progress =
        committed > 0 ? (released / committed).clamp(0.0, 1.0) : 0.0;

    final pairs = <(String, String)>[
      ('Released', upNaira(released, f.currency)),
      if (f.isFunder)
        ('Refunded', upNaira(f.refundedTotal.toInt(), f.currency)),
      if (f.isFunder)
        ('Available', upNaira(f.escrowAvailable.toInt(), f.currency)),
      if (f.isFunder && _escrow != null)
        ('Pool wallet', upNaira(_escrow!.balance.toInt(), f.currency)),
    ];

    return UpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.account_balance_wallet_outlined,
                size: 16, color: kUpPrimarySoft),
            const SizedBox(width: 6),
            const Text('Pool',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
            const Spacer(),
            Text(upNaira(committed, f.currency),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800)),
          ]),
          if (committed > 0) ...[
            const SizedBox(height: 10),
            UpProgressBar(value: progress, height: 5),
            const SizedBox(height: 4),
            Text('${upNaira(released, f.currency)} released',
                style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
          ],
          if (pairs.isNotEmpty) ...[
            const SizedBox(height: 12),
            _pairGrid(pairs),
          ],
        ],
      ),
    );
  }

  /// Label/value pairs two to a row.
  ///
  /// A money value is short and a label is short; giving each pair the full
  /// width of the screen was the single biggest reason this page scrolled.
  /// An odd count leaves the last pair alone on its row rather than stretched
  /// across it, so the columns stay aligned down the card.
  Widget _pairGrid(List<(String, String)> pairs) {
    final rows = <Widget>[];
    for (var i = 0; i < pairs.length; i += 2) {
      final left = pairs[i];
      final right = i + 1 < pairs.length ? pairs[i + 1] : null;
      rows.add(Padding(
        padding: EdgeInsets.only(top: i == 0 ? 0 : 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _pair(left.$1, left.$2)),
            const SizedBox(width: 12),
            Expanded(
                child: right == null
                    ? const SizedBox.shrink()
                    : _pair(right.$1, right.$2)),
          ],
        ),
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }

  Widget _pair(String k, String v) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(k,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: kUpTextSecondary, fontSize: 11.5)),
          const SizedBox(height: 2),
          Text(v,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600)),
        ],
      );

  Widget _equityCard(up.UpliftFundMessage f) {
    final eq = UpEquityTerms.fromMetadata(f.metadata);
    if (!eq.enabled) return const SizedBox.shrink();
    final pairs = <(String, String)>[
      (
        'Type',
        upInvestmentTypeLabel(eq.investmentType).isEmpty
            ? 'Equity'
            : upInvestmentTypeLabel(eq.investmentType)
      ),
      if (eq.offeredPct > 0) ('Per business', upPct(eq.offeredPct)),
      if (eq.valuation > 0) ('Valuation', upNaira(eq.valuation, f.currency)),
    ];
    return UpCard(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.pie_chart, size: 16, color: kUpPrimarySoft),
            SizedBox(width: 6),
            Text('Deal structure',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          _pairGrid(pairs),
          if (eq.terms.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(eq.terms,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 12.5, height: 1.35)),
          ],
        ],
      ),
    );
  }

  /// Four stats on a FIXED 2x2 grid.
  ///
  /// This was a Wrap, which fits three chips on a phone and drops the fourth
  /// onto a line of its own — so "Days left" sat alone under a row of three,
  /// looking like an afterthought rather than a peer. A fixed grid is the
  /// same four facts in two tidy rows, and it cannot re-flow differently on a
  /// narrower device.
  Widget _statsStrip(up.GetUpliftStatisticsResponse s) {
    final chips = <Widget>[
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
    ];
    return Column(children: [
      Row(children: [
        Expanded(child: chips[0]),
        const SizedBox(width: 8),
        Expanded(child: chips[1]),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        Expanded(child: chips[2]),
        const SizedBox(width: 8),
        Expanded(child: chips[3]),
      ]),
    ]);
  }

  bool _fundEditable(up.UpliftFundStatus s) =>
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_DRAFT ||
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN ||
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_REVIEWING ||
      s == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED;

  IconData _terminalIcon(up.UpliftFundStatus s) {
    switch (s) {
      case up.UpliftFundStatus.UPLIFT_FUND_STATUS_COMPLETED:
        return Icons.check_circle_outline;
      case up.UpliftFundStatus.UPLIFT_FUND_STATUS_EXPIRED:
        return Icons.event_busy_outlined;
      default:
        return Icons.cancel_outlined;
    }
  }

  Color _terminalColour(up.UpliftFundStatus s) {
    switch (s) {
      case up.UpliftFundStatus.UPLIFT_FUND_STATUS_COMPLETED:
        return kUpSuccess;
      case up.UpliftFundStatus.UPLIFT_FUND_STATUS_EXPIRED:
        return kUpWarning;
      default:
        return kUpError;
    }
  }

  /// What actually happened to the money in a closed fund.
  /// Delegates to the pure [upliftMoneyOutcome] so the rule can be pinned by a
  /// test without building a screen — it is the part that was wrong.
  String _moneyOutcome(up.UpliftFundMessage f) => upliftMoneyOutcome(
        committedKobo: f.committedPool.toInt(),
        releasedKobo: f.releasedTotal.toInt(),
        refundedKobo: f.refundedTotal.toInt(),
        currency: f.currency,
      );

  /// Why this fund is closed, followed by where the money stands.
  String _terminalNote(up.UpliftFundMessage f) {
    switch (f.status) {
      case up.UpliftFundStatus.UPLIFT_FUND_STATUS_COMPLETED:
        return 'This fund is complete. Every selected business was funded and '
            'all milestones were released.';
      case up.UpliftFundStatus.UPLIFT_FUND_STATUS_EXPIRED:
        return 'This fund expired when its funding deadline passed. '
            '${_moneyOutcome(f)}';
      default:
        final why = f.cancelReason.trim();
        final head = why.isEmpty
            ? 'This fund was cancelled.'
            : 'This fund was cancelled, $why.';
        return '$head ${_moneyOutcome(f)}';
    }
  }

  List<Widget> _funderSection(up.UpliftFundMessage f) {
    // Terminal states. EXPIRED belongs here and was missing: the server refuses
    // CommitEscrow on CANCELLED/COMPLETED/**EXPIRED** alike
    // (uplift_funds_lifecycle.go:104), so leaving "Commit funds" live on an
    // expired fund offered a button that could only ever return
    // FailedPrecondition. Cancel is a different shape of wrong — the server DOES
    // allow it on an expired fund, but the expiry sweep has already refunded the
    // unreleased escrow, so it asks for a PIN and a 10-character reason to
    // achieve nothing.
    final isTerminal =
        f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_CANCELLED ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_COMPLETED ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_EXPIRED;
    return [
      // Draft funds: prominent publish CTA before anything else.
      if (f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_DRAFT) ...[
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: kUpSuccess,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48)),
          onPressed: _publishFund,
          icon: const Icon(Icons.publish),
          // Names the money step when there is one, so the PIN sheet that
          // follows is not a surprise.
          label: Text(f.committedPool.toInt() > 0
              ? 'Publish, start accepting applications'
              : 'Fund & publish, start accepting applications'),
        ),
        const SizedBox(height: 12),
      ],
      if (_stats != null) ...[
        _statsStrip(_stats!),
        const SizedBox(height: 14),
      ],
      // A closed fund disabled both CTAs and said nothing. Greyed-out buttons
      // are not an explanation — the funder's actual question is where their
      // money went, and expiry and cancellation both refund unreleased escrow.
      // _terminalIcon/_terminalColour/_terminalNote were written for exactly
      // this and had no render site.
      if (isTerminal) ...[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            // The 10% status tint is the signal. A 35% outline of the same
            // hue on top of it adds nothing but an edge.
            color: _terminalColour(f.status).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_terminalIcon(f.status),
                  color: _terminalColour(f.status), size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _terminalNote(f),
                  style: TextStyle(
                    color: _terminalColour(f.status),
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
      ],
      // A CLOSED FUND SHOWS NO ACTIONS IT CANNOT PERFORM.
      //
      // Commit and Cancel used to render DISABLED on a terminal fund —
      // dimmed purple on near-black and dimmed red inside a red outline,
      // which is the "what are these invisible CTAs" in the report. They were
      // not invisible, they were unreadable, and a control nobody can read is
      // worse than one that is not there: it costs a row of the screen and
      // invites a tap that does nothing.
      //
      // The explanation banner directly above already says what happened to
      // the fund and where the money went, so removing them leaves the page
      // saying MORE, not less.
      if (!isTerminal) ...[
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kUpPrimary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48)),
              onPressed: _commitPool,
              icon: const Icon(Icons.savings),
              // The same control does two jobs, and the label should say
              // which one. "Commit funds" on a pool that already holds money
              // reads as starting over; a funder topping up to cover a bigger
              // raise is UPDATING what they committed.
              label: Text(
                  f.committedPool.toInt() > 0 ? 'Add to pool' : 'Commit funds'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: kUpError,
                  minimumSize: const Size.fromHeight(48),
                  side: const BorderSide(color: kUpError)),
              onPressed: _cancelFund,
              icon: const Icon(Icons.cancel),
              label: const Text('Cancel'),
            ),
          ),
        ]),
        const SizedBox(height: 10),
      ],
      Row(children: [
        if (f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_REVIEWING ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED)
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: kUpWarning,
                  minimumSize: const Size.fromHeight(44),
                  side: const BorderSide(color: kUpDivider)),
              onPressed: () => _pauseResume(
                  f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED),
              icon: Icon(
                  f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED
                      ? Icons.play_arrow
                      : Icons.pause),
              label: Text(
                  f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED
                      ? 'Resume'
                      : 'Pause'),
            ),
          ),
        if (f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_REVIEWING ||
            f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED)
          const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(44),
                side: const BorderSide(color: kUpDivider)),
            onPressed: () => Get.to(() => UpliftFundingActivityScreen(
                fundId: f.id, currency: f.currency)),
            icon: const Icon(Icons.receipt_long),
            label: const Text('Funding activity'),
          ),
        ),
      ]),
      const SizedBox(height: 10),
      Row(children: [
        // TAKE IT BACK WITHOUT KILLING THE RAISE.
        //
        // Cancel refunds the unreleased balance, but it also rejects every
        // pending application — so a funder who merely over-committed had to
        // choose between leaving the money locked and ending the fund. Shown
        // only while there is something free to take: the server subtracts
        // what is allocated to selected businesses AND refunds already in
        // flight, so an enabled button on an empty pool would be an offer it
        // would refuse.
        if (!isTerminal && (_escrow?.available.toInt() ?? 0) > 0)
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: kUpPrimary,
                  minimumSize: const Size.fromHeight(44),
                  side: const BorderSide(color: kUpDivider)),
              onPressed: _withdrawPool,
              icon: const Icon(Icons.undo),
              label: const Text('Withdraw'),
            ),
          ),
        if (!isTerminal && (_escrow?.available.toInt() ?? 0) > 0)
          const SizedBox(width: 12),
        // Remove is offered only once the pool is settled — the server
        // refuses otherwise, and a button that can only fail is worse than
        // no button. On a live fund the route out is Cancel or Withdraw,
        // which are both right there.
        //
        // ADMIN-TOGGLABLE on top of that settled check, via
        // `uplift_remove_cta_visible`. The flag can only ever HIDE the
        // control: it is ANDed with the settled condition, so flipping it on
        // can never expose a Remove the server would refuse. Defaults to
        // visible, because the control shipped that way and an unset key
        // must not quietly withdraw it.
        if (FeatureFlags.upliftRemoveCta &&
            f.committedPool.toInt() -
                    f.releasedTotal.toInt() -
                    f.refundedTotal.toInt() <=
                0)
          Expanded(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: kUpError,
                  minimumSize: const Size.fromHeight(44),
                  side: const BorderSide(color: kUpDivider)),
              onPressed: _deleteFund,
              icon: const Icon(Icons.delete_outline),
              label: const Text('Remove'),
            ),
          ),
      ]),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Applications',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          Text(
              '${f.applicationCount} total · ${f.selectedCount}/${f.targetCount} selected',
              style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
        ],
      ),
      const SizedBox(height: 8),
      if (_applications.isEmpty)
        const Padding(
            padding: EdgeInsets.all(16),
            child: Text('No applications yet.',
                style: TextStyle(color: kUpTextSecondary))),
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
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(
                            'Requested ${upNaira(a.requestedAmount.toInt(), a.currency)} · ❤ ${a.endorsementCount}',
                            style: const TextStyle(
                                color: kUpTextSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  UpStatusChip(label: upAppStatusLabel(a.status)),
                ],
              ),
              if (a.pitch.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(a.pitch,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
              if (a.agreedEquityPct > 0 ||
                  a.proposedEquityPct > 0 ||
                  a.hasCounter) ...[
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  if (a.agreedEquityPct > 0)
                    UpEquityChip(label: 'Offered ${upPct(a.agreedEquityPct)}'),
                  if (a.agreedEquityPct == 0 && a.proposedEquityPct > 0)
                    UpEquityChip(
                        label: 'Proposes ${upPct(a.proposedEquityPct)}',
                        icon: Icons.handshake),
                  if (a.hasCounter)
                    UpEquityChip(
                      icon: Icons.swap_horiz,
                      label:
                          'Counter ${upNaira(a.counterAmount.toInt(), a.currency)}${a.counterEquityPct > 0 ? ' · ${upPct(a.counterEquityPct)}' : ''}',
                    ),
                ]),
              ],
              const SizedBox(height: 10),
              Row(children: [
                Icon(Icons.touch_app_outlined,
                    size: 14, color: kUpPrimarySoft.withOpacity(0.9)),
                const SizedBox(width: 6),
                Text(_funderTileHint(a.status),
                    style: const TextStyle(
                        color: kUpPrimarySoft,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const Spacer(),
                const Icon(Icons.chevron_right,
                    color: kUpTextSecondary, size: 20),
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
      case up.UpliftApplicationStatus
            .UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS:
      case up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_COMPLETED:
        return 'Tap to review milestones';
      default:
        return 'Tap to view details';
    }
  }

  List<Widget> _applicantSection(up.UpliftFundMessage f) {
    final hasOffer = f.myApplicationStatus ==
        up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_SELECTED;
    final negotiating = f.myApplicationStatus ==
        up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_NEGOTIATING;
    // A withdrawn / rejected / declined / expired-offer application leaves the
    // business free to apply again — the server's duplicate guard says so. This
    // read `myApplicationId.isNotEmpty`, which locked them out of the fund
    // forever over an application they had cancelled themselves.
    final hasApplied = upHasLiveApplication(f);
    final hadApplication = f.myApplicationId.isNotEmpty;
    return [
      if (hasOffer) ...[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kUpSuccess.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: [
            Row(children: const [
              Text('🎉', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Expanded(
                  child: Text('You have a funding offer',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15))),
            ]),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Open your application to see the full terms, then respond.',
                  style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kUpSuccess,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(46)),
                onPressed: () => _respondToOffer(true),
                icon: const Icon(Icons.check_circle, size: 18),
                label: const Text('Accept offer'),
              ),
            ),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(44),
                          side: const BorderSide(color: kUpPrimary)),
                      onPressed: _negotiate,
                      child: const Text('Negotiate',
                          style: TextStyle(color: kUpPrimarySoft)))),
              const SizedBox(width: 8),
              Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(44),
                          side: const BorderSide(color: kUpDivider)),
                      onPressed: () => _respondToOffer(false),
                      child: const Text('Decline',
                          style: TextStyle(color: Colors.white)))),
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
          ),
          child: Row(children: const [
            Icon(Icons.hourglass_top, color: kUpPrimarySoft),
            SizedBox(width: 10),
            Expanded(
                child: Text('Counter sent, awaiting the investor\'s response.',
                    style: TextStyle(color: Colors.white))),
          ]),
        ),
        const SizedBox(height: 12),
      ],
      // Your own raise is not something you can apply to. The backend refuses it
      // outright (FailedPrecondition, "you cannot apply to your own fund"), so
      // offering the button would only produce an error the user could not have
      // predicted. `is_funder` is resolved server-side from the caller's token,
      // which is what makes it safe to gate on here.
      if (f.isFunder) ...[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kUpPrimary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: const [
            Icon(Icons.workspace_premium_outlined, color: kUpPrimarySoft),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'This is your fund. Businesses apply to you, you review their '
                'applications rather than applying yourself.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 12),
      ] else if (!hasApplied &&
          f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN &&
          upApplicationsClosed(f)) ...[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kUpWarning.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: const [
            Icon(Icons.event_busy_outlined, color: kUpWarning),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Applications have closed for this fund. The deadline set by '
                'the funder has passed.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 12),
      ] else if (!hasApplied &&
          f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN) ...[
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: kUpPrimary,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50)),
          onPressed: () async {
            await Get.to(() => ApplyUpliftScreen(fund: f));
            _load();
          },
          icon: const Icon(Icons.send),
          label: Text(hadApplication ? 'Apply again' : 'Apply for funding'),
        ),
        // Re-applying must not erase what happened last time: the earlier
        // application, the funder's reason for rejecting it and any messages
        // stay one tap away.
        if (hadApplication)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _openMyAppDetail,
              icon: const Icon(Icons.history, size: 16),
              label: Text(
                  'Previous application: ${upAppStatusLabel(f.myApplicationStatus)}'),
              style: TextButton.styleFrom(foregroundColor: kUpTextSecondary),
            ),
          ),
      ] else if (hadApplication) ...[
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _openMyAppDetail,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kUpCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(children: [
              const Icon(Icons.info_outline, color: kUpTextSecondary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Your application status: ${upAppStatusLabel(f.myApplicationStatus)}',
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 2),
                    const Text('View details & message the investor',
                        style: TextStyle(color: kUpPrimarySoft, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: kUpTextSecondary),
            ]),
          ),
        ),
        if (f.myApplicationStatus ==
                up.UpliftApplicationStatus
                    .UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS ||
            f.myApplicationStatus ==
                up.UpliftApplicationStatus
                    .UPLIFT_APPLICATION_STATUS_COMPLETED) ...[
          const SizedBox(height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: kUpPrimary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48)),
            onPressed: () async {
              await Get.to(() => UpliftMilestonesScreen(
                  applicationId: f.myApplicationId, isFunder: false));
              _load();
            },
            icon: const Icon(Icons.flag),
            label: const Text('View milestones & submit evidence'),
          ),
        ],
        // Withdraw is allowed before funding starts.
        if (f.myApplicationStatus ==
                up.UpliftApplicationStatus
                    .UPLIFT_APPLICATION_STATUS_SUBMITTED ||
            f.myApplicationStatus ==
                up.UpliftApplicationStatus
                    .UPLIFT_APPLICATION_STATUS_UNDER_REVIEW ||
            f.myApplicationStatus ==
                up.UpliftApplicationStatus
                    .UPLIFT_APPLICATION_STATUS_SHORTLISTED) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _withdrawApplication,
              icon: const Icon(Icons.undo, size: 18, color: kUpError),
              label: const Text('Withdraw application',
                  style: TextStyle(color: kUpError)),
            ),
          ),
        ],
      ],
      // Community endorsement — anyone can back other applicants.
      if (_applications.isNotEmpty) ...[
        const SizedBox(height: 22),
        const Text('Applicants',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
            'Endorse the businesses you believe in, the funder sees community support.',
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
                    label: Text('Your application',
                        style:
                            TextStyle(color: kUpTextSecondary, fontSize: 11)),
                  )
                : TextButton.icon(
                    onPressed: () => _endorse(a),
                    icon: Icon(
                        a.viewerHasEndorsed
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18,
                        color:
                            a.viewerHasEndorsed ? kUpError : kUpTextSecondary),
                    label: Text(a.viewerHasEndorsed ? 'Endorsed' : 'Endorse',
                        style: TextStyle(
                            color: a.viewerHasEndorsed
                                ? kUpError
                                : kUpTextSecondary)),
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
          decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: kUpTextSecondary)),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, c.text),
              child: const Text('Confirm')),
        ],
      ),
    );
  }
}

/// What a closed fund should SAY about the funder's money.
///
/// This used to be a fixed sentence attached to the STATUS: every expired or
/// cancelled fund told the funder that "anything in the pool that had not been
/// released was refunded to your wallet", whether or not a naira had ever been
/// committed.
///
/// Measured on production 2026-10-16: all four expired funds had
/// committed_pool = 0, released = 0, refunded = 0 and no escrow account, and
/// `uplift_escrow_refunds` held ZERO rows platform-wide. The expiry sweep only
/// queues a refund when `unreleased > 0`
/// (uplift_worker_reconcile.go sweepExpiredFunds), so for a fund nobody funded
/// there is correctly nothing to refund — but the screen promised one, which
/// sent a funder looking through the refunds page for money that had never
/// moved.
///
/// "Nothing was taken" and "it came back" are different promises, and the
/// expensive direction is claiming a refund that did not happen. Each arm is
/// derived from the fund's own figures.
String upliftMoneyOutcome({
  required int committedKobo,
  required int releasedKobo,
  required int refundedKobo,
  required String currency,
}) {
  final unreleased = committedKobo - releasedKobo - refundedKobo;

  if (committedKobo <= 0) {
    // Say it plainly. Silence here reads as a refund that went missing.
    return 'No money was committed to this fund, so there is nothing to refund.';
  }
  if (unreleased > 0) {
    // Queued, not settled. Promising a completed refund would be the
    // expensive direction of wrong.
    return '${upNaira(unreleased, currency)} is on its way back to your wallet. '
        'It will appear once the refund settles.';
  }
  if (refundedKobo > 0) {
    return '${upNaira(refundedKobo, currency)} was returned to your wallet.';
  }
  return 'Everything in the pool had already been released to businesses, so '
      'there is nothing to refund.';
}
