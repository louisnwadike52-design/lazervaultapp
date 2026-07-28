import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_receipt_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Milestone tracking for one funded application. Applicant (business) submits
/// evidence per milestone; the funder approves (PIN → escrow→business release)
/// or rejects. Released milestones show a receipt summary. This is the tail of
/// both journeys — the actual money delivery.
class UpliftMilestonesScreen extends StatefulWidget {
  const UpliftMilestonesScreen({required this.applicationId, required this.isFunder, super.key});
  final String applicationId;
  final bool isFunder;

  @override
  State<UpliftMilestonesScreen> createState() => _UpliftMilestonesScreenState();
}

class _UpliftMilestonesScreenState extends State<UpliftMilestonesScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  final _repo = serviceLocator<UpliftRepository>();
  up.UpliftApplicationMessage? _app;
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
      final app = await _repo.getApplication(widget.applicationId);
      setState(() {
        _app = app;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = upFriendlyError(e);
        _loading = false;
      });
    }
  }

  void _err(Object e) => Get.snackbar('Error', upFriendlyError(e),
      backgroundColor: kUpError, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);

  Future<void> _openReceipt(String releaseId) async {
    try {
      final receipt = await _repo.getReceipt('milestone_release', releaseId);
      Get.to(() => UpliftReceiptScreen(receipt: receipt));
    } catch (e) {
      _err(e);
    }
  }

  Future<void> _submitEvidence(up.UpliftMilestoneMessage m) async {
    final images = <String>[];
    final noteCtrl = TextEditingController();
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: kUpBg,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 16),
        child: StatefulBuilder(
          builder: (ctx, setSheet) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Submit evidence · ${m.title}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 12),
              UpliftImagePickerRow(
                label: 'Proof of work',
                urls: images,
                onAdd: (u) => setSheet(() => images.add(u)),
                onRemove: (u) => setSheet(() => images.remove(u)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteCtrl,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Note (optional)',
                  labelStyle: const TextStyle(color: kUpTextSecondary),
                  filled: true,
                  fillColor: kUpCard,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Submit'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true) return;
    try {
      await _repo.submitEvidence(m.id, images, note: noteCtrl.text.trim());
      await _load();
      Get.snackbar('Evidence submitted', 'The funder will review it',
          backgroundColor: kUpCard, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      _err(e);
    }
  }

  Future<void> _approve(up.UpliftMilestoneMessage m) async {
    final txId = 'UPLIFT-MILESTONE-${DateTime.now().microsecondsSinceEpoch}';
    await validateTransactionPin(
      context: context,
      transactionId: txId,
      transactionType: 'uplift_milestone_release',
      amount: m.amount.toInt() / 100.0,
      currency: _app?.currency ?? 'NGN',
      title: 'Release ${m.title}',
      onPinValidated: (verificationToken) async {
        await _repo.reviewMilestone(
          milestoneId: m.id,
          approve: true,
          pinToken: verificationToken,
          transactionId: txId,
        );
        await _load();
      },
    );
  }

  Future<void> _reject(up.UpliftMilestoneMessage m) async {
    final ctrl = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kUpCard,
        title: const Text('Reject milestone', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(labelText: 'Reason', labelStyle: TextStyle(color: kUpTextSecondary)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, ctrl.text.trim()), child: const Text('Reject', style: TextStyle(color: kUpError))),
        ],
      ),
    );
    if (reason == null || reason.isEmpty) return;
    try {
      await _repo.reviewMilestone(milestoneId: m.id, approve: false, reason: reason);
      await _load();
    } catch (e) {
      _err(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Milestones'),
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
    final a = _app!;
    if (a.milestones.isEmpty) {
      return const Center(child: Text('No milestones yet.', style: TextStyle(color: kUpTextSecondary)));
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(a.businessName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          Text('Approved ${upNaira(a.approvedAmount.toInt(), a.currency)}', style: const TextStyle(color: kUpTextSecondary)),
          const SizedBox(height: 16),
          for (final m in a.milestones) _milestoneTile(m),
        ],
      ),
    );
  }

  Widget _milestoneTile(up.UpliftMilestoneMessage m) {
    final label = m.status.name.replaceFirst('UPLIFT_MILESTONE_STATUS_', '').toLowerCase().replaceAll('_', ' ');
    final released = m.status == up.UpliftMilestoneStatus.UPLIFT_MILESTONE_STATUS_RELEASED;
    final canSubmit = !widget.isFunder &&
        (m.status == up.UpliftMilestoneStatus.UPLIFT_MILESTONE_STATUS_PLANNED ||
            m.status == up.UpliftMilestoneStatus.UPLIFT_MILESTONE_STATUS_REJECTED);
    final canReview = widget.isFunder && m.status == up.UpliftMilestoneStatus.UPLIFT_MILESTONE_STATUS_EVIDENCE_SUBMITTED;
    return UpCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 26, height: 26, alignment: Alignment.center,
                decoration: BoxDecoration(color: released ? kUpSuccess : kUpDivider, shape: BoxShape.circle),
                child: released
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : Text('${m.sequence}', style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(m.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
              UpStatusChip(label: label),
            ]),
            if (m.description.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(m.description, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
            const SizedBox(height: 6),
            Text(upNaira(m.amount.toInt(), _app?.currency ?? 'NGN'), style: const TextStyle(color: kUpPrimary, fontWeight: FontWeight.w700)),
            if (m.rejectReason.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text('Rejected: ${m.rejectReason}', style: const TextStyle(color: kUpError, fontSize: 12)),
            ],
            if (m.evidence.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 64,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: m.evidence.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6),
                  itemBuilder: (_, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(m.evidence[i], width: 72, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink())),
                ),
              ),
            ],
            if (released)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: const [
                      Icon(Icons.check_circle, size: 16, color: kUpSuccess),
                      SizedBox(width: 6),
                      Text('Funds released', style: TextStyle(color: kUpSuccess, fontSize: 12)),
                    ]),
                    if (m.releaseId.isNotEmpty)
                      TextButton.icon(
                        onPressed: () => _openReceipt(m.releaseId),
                        icon: const Icon(Icons.receipt_long, size: 16, color: kUpPrimary),
                        label: const Text('View receipt', style: TextStyle(color: kUpPrimary)),
                      ),
                  ],
                ),
              ),
            if (canSubmit)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white),
                  onPressed: () => _submitEvidence(m),
                  icon: const Icon(Icons.upload_file, size: 18),
                  label: Text(m.status == up.UpliftMilestoneStatus.UPLIFT_MILESTONE_STATUS_REJECTED ? 'Resubmit evidence' : 'Submit evidence'),
                ),
              ),
            if (canReview)
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(onPressed: () => _reject(m), child: const Text('Reject', style: TextStyle(color: kUpError))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: kUpSuccess, foregroundColor: Colors.white),
                    onPressed: () => _approve(m),
                    child: const Text('Approve & release')),
              ]),
          ],
        ),
    );
  }
}
