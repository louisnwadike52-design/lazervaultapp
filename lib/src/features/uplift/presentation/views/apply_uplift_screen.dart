import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;
import 'package:lazervault/core/config/feature_flags.dart';

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

  /// Which half of the pitch-media control is showing. The two are exclusive
  /// because they write the same field — offering both at once would invite
  /// filling in two and silently dropping one.
  bool _usePitchLink = false;
  final _pitchLink = TextEditingController();
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
    _pitchLink.dispose();
    super.dispose();
  }

  int get _capKobo => widget.fund.perBusinessCap.toInt();

  /// The one value that goes on the wire, whichever control produced it.
  String get _pitchMedia =>
      _usePitchLink ? _pitchLink.text.trim() : _videoUrl;

  Future<void> _submit() async {
    // Last line of defence. The Discover list and the detail screen both hide
    // the entry point for your own fund, but this screen can also be reached
    // from a deep link or a stale list, and the refusal is far clearer here
    // than as a gRPC FailedPrecondition surfacing after the form is filled in.
    if (widget.fund.isFunder) {
      Get.snackbar('This is your fund',
          'You review the applications that come in — you cannot apply to your own raise.',
          backgroundColor: kUpError,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    // THE WINDOW CAN SHUT WHILE THE FORM IS OPEN.
    //
    // The entry guard in build() stops somebody opening this on a fund that
    // is already closed, but a business typing a pitch two minutes before the
    // deadline can cross it mid-sentence. Re-asked here so the refusal is
    // ours and legible, rather than a gRPC FailedPrecondition after submit.
    if (upApplicationsClosed(widget.fund)) {
      Get.snackbar('Applications have closed',
          'The deadline for this fund passed while you were writing. Nothing was sent.',
          backgroundColor: kUpError,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
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
        videoUrl: _pitchMedia,
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
    // ENTRY GUARD. Reachable from a deep link, a notification tap or a list
    // that was loaded before the deadline passed — in all of which the honest
    // thing is to say so at the door rather than let somebody write a pitch
    // that cannot be sent.
    if (upApplicationsClosed(f)) {
      return Scaffold(
        backgroundColor: kUpBg,
        appBar: upAppBar('Apply for funding'),
        body: UpGradientScaffoldBody(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer_off,
                      color: kUpTextSecondary, size: 44),
                  const SizedBox(height: 14),
                  const Text(
                    'Applications have closed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The deadline for ${f.title} has passed, so this fund is '
                    'no longer taking applications.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: kUpTextSecondary, height: 1.4),
                  ),
                  const SizedBox(height: 18),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Browse other funds',
                        style: TextStyle(
                            color: kUpPrimary, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
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
            // 80: a trading name, not a legal description. It renders beside
            // a status chip on the funder's list, where anything longer is
            // ellipsised anyway, and the column is varchar(255).
            _field(_businessName, 'Business name', maxLength: 80),
            // 600: long enough for a real case, short enough that a funder
            // reading twenty of them still reads this one.
            _field(_pitch, 'Your pitch — what will you do with the funds?',
                maxLines: 5, maxLength: 600),
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
              maxItems: FeatureFlags.upliftApplicationMaxImages,
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
              maxItems: FeatureFlags.upliftApplicationMaxDocuments,
              onUploadingChanged: _trackUpload,
              urls: _docUrls,
              allowDocuments: true,
              onAdd: (u) => setState(() => _docUrls.add(u)),
              onRemove: (u) => setState(() => _docUrls.remove(u)),
            ),
            const SizedBox(height: 16),
            // UPLOAD A VIDEO, OR PASTE A LINK. Either is a pitch.
            //
            // A founder who already has their pitch on YouTube, Loom or Drive
            // had to re-upload it as a file, and the 64MB ceiling means plenty
            // of them simply could not. Both land in the same `video_url`
            // field, so nothing downstream needed a new contract — the readers
            // just had to stop assuming it was always ours.
            if (!_usePitchLink) ...[
              UpliftVideoPickerRow(
                url: _videoUrl,
                onUploadingChanged: _trackUpload,
                onChanged: (u) => setState(() => _videoUrl = u),
              ),
              if (_videoUrl.isEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => setState(() {
                      _usePitchLink = true;
                      _videoUrl = '';
                    }),
                    icon: const Icon(Icons.link, size: 16, color: kUpPrimary),
                    label: const Text('Paste a link instead',
                        style: TextStyle(
                            color: kUpPrimary, fontWeight: FontWeight.w600)),
                  ),
                ),
            ] else ...[
              TextFormField(
                controller: _pitchLink,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.url,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Link to your pitch (optional)',
                  labelStyle: TextStyle(color: kUpTextSecondary),
                  hintText: 'https://…',
                  hintStyle: TextStyle(color: kUpTextSecondary),
                ),
                // Validated, not just accepted: this link is opened on the
                // FUNDER's device, so a javascript: or data: URL in it would
                // be our problem handed to them. http(s) only.
                validator: (v) {
                  final t = (v ?? '').trim();
                  if (t.isEmpty) return null;
                  if (!upIsAcceptablePitchLink(t)) {
                    return 'Enter a full web address starting with https://';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => setState(() {
                    _usePitchLink = false;
                    _pitchLink.clear();
                  }),
                  icon: const Icon(Icons.videocam_outlined,
                      size: 16, color: kUpPrimary),
                  label: const Text('Upload a video instead',
                      style: TextStyle(
                          color: kUpPrimary, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
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
        // Outlined only while the section is ON — same rule as the create
        // screen's equity block.
        border: _offerEquity
            ? Border.all(color: kUpPrimary.withOpacity(0.4))
            : null,
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
              // A note on terms, not a contract — the funder negotiates in
              // the offer flow, which has its own thread.
              maxLength: 200,
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

  /// A form field with a HARD ceiling and a live counter.
  ///
  /// None of these had a limit. A pitch is read in a card on the funder's
  /// review list and in the application sheet — both of which clip it — so an
  /// unbounded field invited someone to write something nobody would ever
  /// see, and a business name of arbitrary length broke the layout wherever it
  /// is rendered beside a status chip. The server stores business_name as
  /// varchar(255), so an over-long name was a refusal at the very end of the
  /// form rather than a limit while typing.
  ///
  /// maxLength both CAPS the input and shows the counter, so the ceiling is
  /// visible before it is reached rather than discovered at submit.
  Widget _field(TextEditingController c, String label,
      {int maxLines = 1,
      int? maxLength,
      TextInputType? keyboard,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        maxLength: maxLength,
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
