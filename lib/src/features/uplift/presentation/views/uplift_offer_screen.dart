import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Funder offer builder: set the approved amount for a selected business and
/// split it into milestone tranches that release one-by-one as evidence is
/// approved. This is the surface for the core milestone-disbursement feature.
class UpliftOfferScreen extends StatefulWidget {
  const UpliftOfferScreen({required this.application, required this.currency, required this.capKobo, super.key});
  final up.UpliftApplicationMessage application;
  final String currency;
  final int capKobo;

  @override
  State<UpliftOfferScreen> createState() => _UpliftOfferScreenState();
}

class _MilestoneRow {
  final title = TextEditingController();
  final amount = TextEditingController();
}

class _UpliftOfferScreenState extends State<UpliftOfferScreen> {
  final _repo = serviceLocator<UpliftRepository>();
  final _approved = TextEditingController();
  final _equityPct = TextEditingController();
  final List<_MilestoneRow> _rows = [];
  bool _submitting = false;
  up.GetUpliftFeeQuoteResponse? _fee;

  Future<void> _refreshFee() async {
    final kobo = _approvedKobo;
    if (kobo <= 0) {
      if (_fee != null) setState(() => _fee = null);
      return;
    }
    try {
      final q = await _repo.feeQuote(kobo);
      if (mounted) setState(() => _fee = q);
    } catch (_) {/* fee preview is best-effort */}
  }

  @override
  void initState() {
    super.initState();
    final a = widget.application;
    // Prefill from the business's latest counter (if negotiating), else from
    // their request / proposal.
    final seedAmountKobo = a.hasCounter && a.counterAmount.toInt() > 0 ? a.counterAmount.toInt() : a.requestedAmount.toInt();
    _approved.text = (seedAmountKobo / 100).toStringAsFixed(0);
    final seedEquity = a.hasCounter && a.counterEquityPct > 0
        ? a.counterEquityPct
        : (a.agreedEquityPct > 0 ? a.agreedEquityPct : a.proposedEquityPct);
    if (seedEquity > 0) _equityPct.text = (seedEquity / 100).toStringAsFixed(seedEquity % 100 == 0 ? 0 : 2);
    // Seed a single milestone with the full amount — the funder can split it.
    _rows.add(_MilestoneRow()
      ..title.text = 'Full disbursement'
      ..amount.text = _approved.text);
    _refreshFee();
  }

  @override
  void dispose() {
    _approved.dispose();
    _equityPct.dispose();
    for (final r in _rows) {
      r.title.dispose();
      r.amount.dispose();
    }
    super.dispose();
  }

  int get _approvedKobo => ((double.tryParse(_approved.text.trim()) ?? 0) * 100).round();
  int get _milestoneSumKobo =>
      _rows.fold(0, (s, r) => s + ((double.tryParse(r.amount.text.trim()) ?? 0) * 100).round());

  void _autoSplit() {
    final n = _rows.length;
    if (n == 0 || _approvedKobo <= 0) return;
    final base = _approvedKobo ~/ n;
    var remainder = _approvedKobo - base * n; // give the remainder to the first row
    for (var i = 0; i < n; i++) {
      final v = base + (i == 0 ? remainder : 0);
      _rows[i].amount.text = (v / 100).toStringAsFixed(2);
    }
    setState(() {});
  }

  Future<void> _submit() async {
    final approved = _approvedKobo;
    if (approved <= 0) {
      _snack('Enter an approved amount', kUpError);
      return;
    }
    if (approved > widget.capKobo) {
      _snack('Max is ${upNaira(widget.capKobo, widget.currency)} per business', kUpError);
      return;
    }
    final equityInput = double.tryParse(_equityPct.text.trim()) ?? 0;
    if (equityInput < 0 || equityInput > 100) {
      _snack('Equity must be between 0 and 100%', kUpError);
      return;
    }
    // Validate milestone plan sums to the approved amount.
    for (final r in _rows) {
      if (r.title.text.trim().isEmpty) {
        _snack('Every milestone needs a title', kUpError);
        return;
      }
    }
    if (_milestoneSumKobo != approved) {
      _snack('Milestone amounts must add up to ${upNaira(approved, widget.currency)}', kUpError);
      return;
    }
    final milestones = <up.UpliftMilestonePlanInput>[];
    for (var i = 0; i < _rows.length; i++) {
      final r = _rows[i];
      milestones.add(up.UpliftMilestonePlanInput(
        sequence: i + 1,
        title: r.title.text.trim(),
        amount: Int64(((double.tryParse(r.amount.text.trim()) ?? 0) * 100).round()),
      ));
    }
    setState(() => _submitting = true);
    try {
      await _repo.select(
        applicationId: widget.application.id,
        approvedAmountKobo: approved,
        milestones: milestones,
        equityPct: ((double.tryParse(_equityPct.text.trim()) ?? 0) * 100).round(),
      );
      Get.back(result: true);
      _snack('Offer sent to ${widget.application.businessName}', kUpCard);
    } catch (e) {
      _snack(upFriendlyError(e), kUpError);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Widget _feeRow(String k, String v, {bool bold = false, bool warn = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(k, style: TextStyle(color: warn ? kUpWarning : kUpTextSecondary, fontSize: 12)),
          Text(v,
              style: TextStyle(
                  color: bold ? kUpSuccess : (warn ? kUpWarning : Colors.white),
                  fontSize: bold ? 15 : 13,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w600)),
        ]),
      );

  void _snack(String msg, Color bg) =>
      Get.snackbar('', msg, backgroundColor: bg, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, titleText: const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    final approved = _approvedKobo;
    final sum = _milestoneSumKobo;
    final balanced = sum == approved && approved > 0;
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Fund ${widget.application.businessName}'),
      body: UpGradientScaffoldBody(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Cap: up to ${upNaira(widget.capKobo, widget.currency)} · requested ${upNaira(widget.application.requestedAmount.toInt(), widget.currency)}',
              style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
          const SizedBox(height: 12),
          if (widget.application.hasCounter)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: kUpPrimary.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                const Icon(Icons.swap_horiz, color: kUpPrimarySoft, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Business countered: ${upNaira(widget.application.counterAmount.toInt(), widget.currency)}'
                    '${widget.application.counterEquityPct > 0 ? ' for ${upPct(widget.application.counterEquityPct)} equity' : ''}'
                    '${widget.application.counterNote.isNotEmpty ? '\n"${widget.application.counterNote}"' : ''}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ]),
            ),
          _numField(_approved, 'Approved amount (₦)', onChanged: () {
            setState(() {});
            _refreshFee();
          }),
          if (_fee != null && _fee!.feeEnabled && _fee!.fee.toInt() > 0) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(10), border: Border.all(color: kUpDivider)),
              child: Column(children: [
                _feeRow('Gross disbursement', upNaira(_fee!.gross.toInt(), widget.currency)),
                _feeRow('Platform fee${_fee!.feeType == 'percentage' && _fee!.feePercentageBps > 0 ? ' (${(_fee!.feePercentageBps / 100).toStringAsFixed(2)}%)' : ''}',
                    '- ${upNaira(_fee!.fee.toInt(), widget.currency)}', warn: true),
                const Divider(color: kUpDivider, height: 14),
                _feeRow('Business receives', upNaira(_fee!.net.toInt(), widget.currency), bold: true),
              ]),
            ),
          ],
          const SizedBox(height: 10),
          _numField(_equityPct, 'Equity you take (%) — optional'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Milestones', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              TextButton.icon(
                onPressed: _autoSplit,
                icon: const Icon(Icons.call_split, size: 16, color: kUpPrimary),
                label: const Text('Split evenly', style: TextStyle(color: kUpPrimary)),
              ),
            ],
          ),
          for (var i = 0; i < _rows.length; i++) _milestoneRow(i),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => setState(() => _rows.add(_MilestoneRow())),
              icon: const Icon(Icons.add, color: kUpPrimary),
              label: const Text('Add milestone', style: TextStyle(color: kUpPrimary)),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Milestones total', style: TextStyle(color: balanced ? kUpSuccess : kUpWarning)),
              Text('${upNaira(sum, widget.currency)} / ${upNaira(approved, widget.currency)}',
                  style: TextStyle(color: balanced ? kUpSuccess : kUpWarning, fontWeight: FontWeight.w700)),
            ]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50)),
            onPressed: _submitting ? null : _submit,
            child: _submitting
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Send funding offer'),
          ),
        ],
      )),
    );
  }

  Widget _milestoneRow(int i) {
    final r = _rows[i];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: r.title,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('Milestone ${i + 1}'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextField(
              controller: r.amount,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: Colors.white),
              decoration: _dec('₦'),
            ),
          ),
          if (_rows.length > 1)
            IconButton(
              onPressed: () => setState(() => _rows.removeAt(i)),
              icon: const Icon(Icons.remove_circle_outline, color: kUpError),
            ),
        ],
      ),
    );
  }

  Widget _numField(TextEditingController c, String label, {VoidCallback? onChanged}) => TextField(
        controller: c,
        keyboardType: TextInputType.number,
        onChanged: (_) => onChanged?.call(),
        style: const TextStyle(color: Colors.white),
        decoration: _dec(label),
      );

  InputDecoration _dec(String label) => InputDecoration(
        labelText: label,
        hintText: label,
        labelStyle: const TextStyle(color: kUpTextSecondary),
        hintStyle: const TextStyle(color: kUpTextSecondary),
        filled: true,
        fillColor: kUpCard,
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      );
}
