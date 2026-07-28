import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Funder flow: open a new Uplift fund, or edit an existing one when [existing]
/// is provided. Create mode can publish immediately or save as a draft.
class CreateUpliftScreen extends StatefulWidget {
  const CreateUpliftScreen({this.existing, super.key});

  /// When non-null the screen runs in EDIT mode (calls UpdateUpliftFund).
  final up.UpliftFundMessage? existing;

  @override
  State<CreateUpliftScreen> createState() => _CreateUpliftScreenState();
}

class _CreateUpliftScreenState extends State<CreateUpliftScreen> {
  final _repo = serviceLocator<UpliftRepository>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _category = TextEditingController(text: 'Agri-tech');
  final _cap = TextEditingController();
  final _count = TextEditingController(text: '10');
  DateTime? _appDeadline;
  DateTime? _fundingDeadline;
  final List<String> _gallery = [];
  bool _submitting = false;

  final _pageCtrl = PageController();
  int _step = 0;
  static const _steps = ['Basics', 'Funding', 'Deal terms', 'Media', 'Review'];
  int get _lastStep => _steps.length - 1;

  // Optional equity / deal terms.
  bool _equityEnabled = false;
  String _investmentType = 'equity';
  final _equityPct = TextEditingController();
  final _valuation = TextEditingController();
  final _equityTerms = TextEditingController();

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _title.text = e.title;
      _desc.text = e.description;
      _category.text = e.category;
      _cap.text = (e.perBusinessCap.toInt() / 100).toStringAsFixed(0);
      _count.text = '${e.targetCount}';
      if (e.hasApplicationDeadline()) _appDeadline = e.applicationDeadline.toDateTime();
      if (e.hasFundingDeadline()) _fundingDeadline = e.fundingDeadline.toDateTime();
      _gallery.addAll(e.gallery);
      final eq = UpEquityTerms.fromMetadata(e.metadata);
      if (eq.enabled) {
        _equityEnabled = true;
        _investmentType = eq.investmentType.isEmpty ? 'equity' : eq.investmentType;
        if (eq.offeredPct > 0) _equityPct.text = (eq.offeredPct / 100).toStringAsFixed(eq.offeredPct % 100 == 0 ? 0 : 2);
        if (eq.valuation > 0) _valuation.text = (eq.valuation / 100).toStringAsFixed(0);
        _equityTerms.text = eq.terms;
      }
    }
  }

  String _buildMetadata() {
    if (!_equityEnabled) return '';
    return UpEquityTerms(
      enabled: true,
      investmentType: _investmentType,
      offeredPct: ((double.tryParse(_equityPct.text.trim()) ?? 0) * 100).round(),
      valuation: ((double.tryParse(_valuation.text.trim()) ?? 0) * 100).round(),
      terms: _equityTerms.text.trim(),
    ).toMetadata();
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _category.dispose();
    _cap.dispose();
    _count.dispose();
    _equityPct.dispose();
    _valuation.dispose();
    _equityTerms.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goTo(int s) {
    setState(() => _step = s);
    _pageCtrl.animateToPage(s, duration: const Duration(milliseconds: 260), curve: Curves.easeOut);
  }

  void _next() {
    if (_step < _lastStep) {
      if (!_validateStep(_step)) return;
      _goTo(_step + 1);
    } else {
      _submit();
    }
  }

  void _back() {
    if (_step == 0) {
      Get.back();
      return;
    }
    _goTo(_step - 1);
  }

  void _snack(String msg) => Get.snackbar('', msg,
      backgroundColor: kUpError, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, titleText: const SizedBox.shrink());

  bool _validateStep(int s) {
    if (s == 0) {
      if (_title.text.trim().isEmpty) {
        _snack('Give your fund a title');
        return false;
      }
    } else if (s == 1) {
      if (_num(_cap.text) != null) {
        _snack('Enter a valid max amount per business');
        return false;
      }
      if (_int(_count.text) != null) {
        _snack('Enter how many businesses to fund');
        return false;
      }
    }
    return true;
  }

  Future<void> _submit({bool asDraft = false}) async {
    // Steps gate their own fields, but re-check the required ones before commit.
    if (!_validateStep(0) || !_validateStep(1)) return;
    setState(() => _submitting = true);
    try {
      final capKobo = (double.parse(_cap.text.trim()) * 100).round();
      if (_isEdit) {
        final fund = await _repo.updateFund(
          fundId: widget.existing!.id,
          title: _title.text.trim(),
          description: _desc.text.trim(),
          category: _category.text.trim(),
          perBusinessCapKobo: capKobo,
          targetCount: int.parse(_count.text.trim()),
          applicationDeadline: _appDeadline,
          fundingDeadline: _fundingDeadline,
          coverImageUrl: _gallery.isNotEmpty ? _gallery.first : '',
          gallery: _gallery,
          metadata: _buildMetadata(),
        );
        Get.back(result: true);
        Get.snackbar('Changes saved', '${fund.title} was updated',
            backgroundColor: kUpCard, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
        return;
      }
      final fund = await _repo.createFund(
        title: _title.text.trim(),
        description: _desc.text.trim(),
        category: _category.text.trim(),
        perBusinessCapKobo: capKobo,
        targetCount: int.parse(_count.text.trim()),
        applicationDeadline: _appDeadline,
        fundingDeadline: _fundingDeadline,
        coverImageUrl: _gallery.isNotEmpty ? _gallery.first : '',
        gallery: _gallery,
        publishNow: !asDraft,
        metadata: _buildMetadata(),
      );
      Get.back(result: true);
      Get.snackbar(
        asDraft ? 'Draft saved' : 'Fund opened',
        asDraft ? '${fund.title} saved as a draft — publish it when ready' : '${fund.title} is now accepting applications',
        backgroundColor: kUpCard, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(_isEdit ? 'Could not save changes' : 'Could not open fund', upFriendlyError(e),
          backgroundColor: kUpError, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: _submitting ? null : _back),
        title: Text('${_isEdit ? 'Edit fund' : 'Open a fund'} · ${_steps[_step]}'),
      ),
      body: UpGradientScaffoldBody(
        child: Column(
          children: [
            UpStepIndicator(current: _step, total: _steps.length),
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _step = i),
                children: [
                  _pageScroll(_basicsStep()),
                  _pageScroll(_fundingStep()),
                  _pageScroll(_dealStep()),
                  _pageScroll(_mediaStep()),
                  _pageScroll(_reviewStep()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: UpBottomNav(
        onBack: _step > 0 ? _back : null,
        onNext: _submitting ? null : _next,
        nextLabel: _step < _lastStep ? 'Continue' : (_isEdit ? 'Save changes' : 'Publish fund'),
        isLast: _step == _lastStep,
        loading: _submitting,
      ),
    );
  }

  Widget _pageScroll(List<Widget> children) => ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: children,
      );

  List<Widget> _basicsStep() => [
        _stepHeader('Fund basics', 'Name your call and describe the kind of business you want to back.'),
        _field(_title, 'Title', hint: 'e.g. Fund 20 agri-tech founders'),
        _field(_desc, 'Description', maxLines: 4),
        const SizedBox(height: 4),
        const Text('Category', style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final c in const ['Agri-tech', 'Retail', 'Technology', 'Health', 'Education', 'Creative', 'Services'])
              ChoiceChip(
                label: Text(c),
                selected: _category.text == c,
                onSelected: (_) => setState(() => _category.text = c),
                labelStyle: TextStyle(color: _category.text == c ? Colors.white : kUpTextSecondary, fontSize: 12),
                backgroundColor: kUpCard,
                selectedColor: kUpPrimary,
                side: BorderSide.none,
              ),
          ],
        ),
      ];

  List<Widget> _fundingStep() => [
        _stepHeader('Funding shape', 'Set how much each business can get and how many you\'ll fund.'),
        _field(_cap, 'Max per business (₦)', keyboard: TextInputType.number, validator: _num),
        _field(_count, 'How many businesses', keyboard: TextInputType.number, validator: _int),
        _datePicker('Application deadline', _appDeadline, (d) => setState(() => _appDeadline = d)),
        _datePicker('Funding deadline', _fundingDeadline, (d) => setState(() => _fundingDeadline = d)),
      ];

  List<Widget> _dealStep() => [
        _stepHeader('Deal terms', 'Optionally structure the equity or investment you take in return.'),
        _equitySection(),
      ];

  List<Widget> _mediaStep() => [
        _stepHeader('Media', 'Add a cover and gallery so businesses understand your fund.'),
        UpliftImagePickerRow(
          label: 'Cover & gallery (first image is the cover)',
          urls: _gallery,
          onAdd: (u) => setState(() => _gallery.add(u)),
          onRemove: (u) => setState(() => _gallery.remove(u)),
        ),
      ];

  List<Widget> _reviewStep() {
    final cap = double.tryParse(_cap.text.trim());
    return [
      _stepHeader('Review', 'Confirm the details, then publish — or save it as a draft.'),
      UpCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _reviewRow('Title', _title.text.trim().isEmpty ? '—' : _title.text.trim()),
            _reviewRow('Category', _category.text),
            _reviewRow('Max per business', cap == null ? '—' : upNaira((cap * 100).round(), 'NGN')),
            _reviewRow('Businesses', _count.text.trim()),
            if (_appDeadline != null) _reviewRow('Applications close', _appDeadline!.toLocal().toString().split(' ').first),
            if (_fundingDeadline != null) _reviewRow('Funding deadline', _fundingDeadline!.toLocal().toString().split(' ').first),
            _reviewRow('Deal terms',
                _equityEnabled ? '${upInvestmentTypeLabel(_investmentType)}${_equityPct.text.trim().isNotEmpty ? ' · ${_equityPct.text.trim()}%' : ''}' : 'None'),
            _reviewRow('Media', _gallery.isEmpty ? 'None' : '${_gallery.length} image(s)'),
          ],
        ),
      ),
      if (!_isEdit) ...[
        const SizedBox(height: 12),
        Center(
          child: TextButton.icon(
            onPressed: _submitting ? null : () => _submit(asDraft: true),
            icon: const Icon(Icons.save_outlined, color: kUpTextSecondary, size: 18),
            label: const Text('Save as draft instead', style: TextStyle(color: kUpTextSecondary)),
          ),
        ),
      ],
    ];
  }

  Widget _stepHeader(String title, String subtitle) => Padding(
        padding: const EdgeInsets.only(bottom: 14, top: 4),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: kUpTextSecondary, fontSize: 13)),
        ]),
      );

  Widget _reviewRow(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(k, style: const TextStyle(color: kUpTextSecondary)),
          Flexible(child: Text(v, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
        ]),
      );

  Widget _equitySection() {
    const types = ['equity', 'convertible_note', 'revenue_share', 'loan', 'grant'];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kUpCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kUpPrimary.withOpacity(_equityEnabled ? 0.4 : 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: kUpPrimary,
            value: _equityEnabled,
            onChanged: (v) => setState(() => _equityEnabled = v),
            title: const Text('Structure equity / deal terms', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            subtitle: const Text('Optional — define what you take in return for funding', style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
          ),
          if (_equityEnabled) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final t in types)
                  ChoiceChip(
                    label: Text(upInvestmentTypeLabel(t)),
                    selected: _investmentType == t,
                    onSelected: (_) => setState(() => _investmentType = t),
                    labelStyle: TextStyle(color: _investmentType == t ? Colors.white : kUpTextSecondary, fontSize: 12),
                    backgroundColor: kUpBg,
                    selectedColor: kUpPrimary,
                    side: BorderSide.none,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _plainField(_equityPct, 'Equity % (per business)', keyboard: TextInputType.number)),
              const SizedBox(width: 10),
              Expanded(child: _plainField(_valuation, 'Valuation ₦ (optional)', keyboard: TextInputType.number)),
            ]),
            const SizedBox(height: 10),
            _plainField(_equityTerms, 'Deal terms / notes (optional)', maxLines: 3),
          ],
        ],
      ),
    );
  }

  Widget _plainField(TextEditingController c, String label, {int maxLines = 1, TextInputType? keyboard}) => TextField(
        controller: c,
        maxLines: maxLines,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: kUpTextSecondary),
          filled: true,
          fillColor: kUpBg,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      );

  Widget _field(TextEditingController c, String label,
      {String? hint, int maxLines = 1, TextInputType? keyboard, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        keyboardType: keyboard,
        style: const TextStyle(color: Colors.white),
        validator: validator ?? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(color: kUpTextSecondary),
          hintStyle: const TextStyle(color: kUpTextSecondary),
          filled: true,
          fillColor: kUpCard,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _datePicker(String label, DateTime? value, ValueChanged<DateTime> onPick) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: () async {
          final now = DateTime.now();
          final d = await showDatePicker(
              context: context, initialDate: now.add(const Duration(days: 14)), firstDate: now, lastDate: now.add(const Duration(days: 365)));
          if (d != null) onPick(d);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: kUpTextSecondary, size: 18),
              const SizedBox(width: 12),
              Text(value == null ? label : '$label: ${value.toLocal().toString().split(' ').first}',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  String? _num(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return double.tryParse(v.trim()) == null ? 'Enter a valid amount' : null;
  }

  String? _int(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return int.tryParse(v.trim()) == null ? 'Enter a whole number' : null;
  }
}
