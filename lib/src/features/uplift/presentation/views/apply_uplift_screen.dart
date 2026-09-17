import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Applicant flow: apply to a fund with a business pitch + requested amount
/// (<= the funder's per-business cap) + optional images/documents.
class ApplyUpliftScreen extends StatefulWidget {
  const ApplyUpliftScreen({required this.fund, super.key});
  final up.UpliftFundMessage fund;

  @override
  State<ApplyUpliftScreen> createState() => _ApplyUpliftScreenState();
}

class _ApplyUpliftScreenState extends State<ApplyUpliftScreen> {
  final _repo = serviceLocator<UpliftRepository>();
  final _form = GlobalKey<FormState>();
  final _businessName = TextEditingController();
  final _pitch = TextEditingController();
  final _amount = TextEditingController();
  final _equityPct = TextEditingController();
  final _equityNote = TextEditingController();
  final List<String> _images = [];

  /// Pitch deck, financials, CAC certificate.
  ///
  /// Kept out of [_images] on purpose: the funder's detail screen renders docs
  /// and photos in different sections, and a PDF in the photo gallery draws as
  /// a broken thumbnail. This list was the missing half — the backend field and
  /// the funder's documents section both existed with nothing ever filling them.
  final List<String> _docUrls = [];

  /// Optional founder pitch video.
  String _videoUrl = '';
  bool _offerEquity = false;
  bool _submitting = false;

  /// True while ANY attachment is uploading.
  ///
  /// Counted rather than a bool: a user can start a document and a video
  /// together, and a single flag would clear on the first one finishing while
  /// the other was still in flight.
  int _uploadsInFlight = 0;
  bool get _uploading => _uploadsInFlight > 0;

  void _trackUpload(bool active) {
    setState(() => _uploadsInFlight += active ? 1 : -1);
    if (_uploadsInFlight < 0) _uploadsInFlight = 0;
  }

  @override
  void dispose() {
    _businessName.dispose();
    _pitch.dispose();
    _amount.dispose();
    _equityPct.dispose();
    _equityNote.dispose();
    super.dispose();
  }

  int get _capKobo => widget.fund.perBusinessCap.toInt();

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    final amountKobo = (double.parse(_amount.text.trim()) * 100).round();
    if (amountKobo > _capKobo) {
      Get.snackbar('Amount too high',
          'Max is ${upNaira(_capKobo, widget.fund.currency)} per business',
          backgroundColor: kUpError,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    setState(() => _submitting = true);
    try {
      await _repo.apply(
        fundId: widget.fund.id,
        businessName: _businessName.text.trim(),
        pitch: _pitch.text.trim(),
        requestedAmountKobo: amountKobo,
        images: _images,
        docUrls: _docUrls,
        videoUrl: _videoUrl,
        proposedEquityPct: _offerEquity
            ? ((double.tryParse(_equityPct.text.trim()) ?? 0) * 100).round()
            : 0,
        equityNote: _offerEquity ? _equityNote.text.trim() : '',
      );
      Get.back();
      Get.snackbar(
          'Application sent', 'The funder will review your application',
          backgroundColor: kUpCard,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Could not apply', upFriendlyError(e),
          backgroundColor: kUpError,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.fund;
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Apply for funding'),
      body: UpGradientScaffoldBody(
          child: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: kUpCard, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(f.title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('Up to ${upNaira(_capKobo, f.currency)} per business',
                      style: const TextStyle(
                          color: kUpTextSecondary, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _field(_businessName, 'Business name'),
            _field(_pitch, 'Your pitch — what will you do with the funds?',
                maxLines: 5),
            _field(_amount, 'Amount requested (₦)',
                keyboard: TextInputType.number, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              return double.tryParse(v.trim()) == null
                  ? 'Enter a valid amount'
                  : null;
            }),
            const SizedBox(height: 8),
            UpliftImagePickerRow(
              label: 'Photos of your business',
              onUploadingChanged: _trackUpload,
              urls: _images,
              onAdd: (u) => setState(() => _images.add(u)),
              onRemove: (u) => setState(() => _images.remove(u)),
            ),
            const SizedBox(height: 16),
            // The documents an investor actually decides on. Separate row from
            // photos because they go to a different field and the funder's
            // screen renders them in a different section.
            UpliftImagePickerRow(
              label: 'Pitch deck & documents',
              onUploadingChanged: _trackUpload,
              urls: _docUrls,
              allowDocuments: true,
              onAdd: (u) => setState(() => _docUrls.add(u)),
              onRemove: (u) => setState(() => _docUrls.remove(u)),
            ),
            const SizedBox(height: 16),
            UpliftVideoPickerRow(
              url: _videoUrl,
              onUploadingChanged: _trackUpload,
              onChanged: (u) => setState(() => _videoUrl = u),
            ),
            const SizedBox(height: 16),
            _equityProposal(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kUpPrimary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50)),
              // Blocked while an attachment is still uploading: submitting
              // now would post the form without the URL, and the business
              // would never know the deck or video did not arrive.
              onPressed: (_submitting || _uploading) ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  // Says WHY it is disabled. A greyed button with no
                  // explanation reads as a broken form, and the user retries
                  // instead of waiting the few seconds left.
                  : Text(_uploading
                      ? 'Waiting for uploads…'
                      : 'Submit application'),
            ),
          ],
        ),
      )),
    );
  }

  Widget _equityProposal() {
    final eq = UpEquityTerms.fromMetadata(widget.fund.metadata);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kUpCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: kUpPrimary.withOpacity(_offerEquity ? 0.4 : 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (eq.enabled)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: UpEquityChip(
                label:
                    'Investor seeks ${upInvestmentTypeLabel(eq.investmentType).isEmpty ? 'equity' : upInvestmentTypeLabel(eq.investmentType)}'
                    '${eq.offeredPct > 0 ? ' · ${upPct(eq.offeredPct)}' : ''}',
              ),
            ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: kUpPrimary,
            value: _offerEquity,
            onChanged: (v) => setState(() => _offerEquity = v),
            title: const Text('Propose equity terms',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            subtitle: const Text(
                'Optional — what you\'re willing to give in return',
                style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
          ),
          if (_offerEquity) ...[
            const SizedBox(height: 8),
            TextField(
              controller: _equityPct,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('Equity you\'ll give (%)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _equityNote,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('Note (optional)'),
            ),
          ],
        ],
      ),
    );
  }

  InputDecoration _dec(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kUpTextSecondary),
        filled: true,
        fillColor: kUpBg,
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      );

  Widget _field(TextEditingController c, String label,
      {int maxLines = 1,
      TextInputType? keyboard,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.white),
        validator: validator ??
            (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: kUpTextSecondary),
          filled: true,
          fillColor: kUpCard,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
