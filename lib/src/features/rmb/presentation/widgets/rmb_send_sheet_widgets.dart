part of 'rmb_send_sheet.dart';

// ── Bank picker sheet ─────────────────────────────────────────────────
class _RmbBankPickerSheet extends StatefulWidget {
  final RmbRail rail;
  final RmbCubit cubit;
  const _RmbBankPickerSheet({required this.rail, required this.cubit});

  @override
  State<_RmbBankPickerSheet> createState() => _RmbBankPickerSheetState();
}

class _RmbBankPickerSheetState extends State<_RmbBankPickerSheet> {
  List<Bank>? _banks;
  String _query = '';
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final banks = await widget.cubit.banks(widget.rail);
      if (mounted) setState(() => _banks = banks);
    } catch (e) {
      if (mounted) setState(() => _error = rmbFriendlyError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final banks = (_banks ?? [])
        .where((b) =>
            _query.isEmpty ||
            b.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    final media = MediaQuery.of(context);
    final height = (media.size.height * 0.8 - media.viewInsets.bottom)
        .clamp(media.size.height * 0.4, media.size.height * 0.8);
    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: RmbUi.bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border.all(color: RmbUi.border),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Choose bank',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700)),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 34.w,
                    width: 34.w,
                    decoration: BoxDecoration(
                      color: RmbUi.card,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: RmbUi.border),
                    ),
                    child: Icon(Icons.close_rounded,
                        color: Colors.white, size: 18.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            TextField(
              onChanged: (v) => setState(() => _query = v),
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search banks',
                hintStyle: TextStyle(color: RmbUi.label, fontSize: 13.sp),
                prefixIcon:
                    Icon(Icons.search, color: RmbUi.textSecondary, size: 18.sp),
                filled: true,
                fillColor: RmbUi.card,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: RmbUi.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: RmbUi.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: RmbUi.accent),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: _error != null
                  ? Center(
                      child: Text(_error!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: RmbUi.textSecondary, fontSize: 13.sp)))
                  : _banks == null
                      ? const Center(
                          child: CircularProgressIndicator(color: RmbUi.accent))
                      : ListView.builder(
                          itemCount: banks.length,
                          itemBuilder: (_, i) {
                            final b = banks[i];
                            return ListTile(
                              dense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 4.w),
                              leading: Icon(Icons.account_balance_outlined,
                                  color: RmbUi.textSecondary, size: 18.sp),
                              title: Text(b.name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp)),
                              onTap: () => Navigator.of(context).pop(b),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Live QR scan sheet (wallet rails) ─────────────────────────────────
class _RmbQrScanSheet extends StatefulWidget {
  final RmbRail rail;
  const _RmbQrScanSheet({required this.rail});

  static Future<String?> show(BuildContext context, {required RmbRail rail}) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RmbQrScanSheet(rail: rail),
    );
  }

  @override
  State<_RmbQrScanSheet> createState() => _RmbQrScanSheetState();
}

class _RmbQrScanSheetState extends State<_RmbQrScanSheet> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  bool _handled = false;
  bool _ready = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    if (!status.isGranted) {
      setState(() => _error = 'Camera permission is needed to scan a QR code.');
      return;
    }
    try {
      await _controller.start();
    } catch (_) {/* benign: already started */}
    if (mounted) setState(() => _ready = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final raw =
        capture.barcodes.isEmpty ? null : capture.barcodes.first.rawValue;
    if (raw == null || raw.isEmpty) return;
    _handled = true;
    Navigator.of(context).pop(raw);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: RmbUi.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: RmbUi.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 12.w, 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Scan a QR code',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 2.h),
                      Text(
                          'Point at a code that holds a phone number or email.',
                          style: TextStyle(
                              color: RmbUi.textSecondary, fontSize: 11.sp)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _controller.toggleTorch(),
                  icon: Icon(Icons.flash_on_outlined,
                      color: RmbUi.textSecondary, size: 20.sp),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 34.w,
                    width: 34.w,
                    decoration: BoxDecoration(
                      color: RmbUi.card,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: RmbUi.border),
                    ),
                    child: Icon(Icons.close_rounded,
                        color: Colors.white, size: 18.sp),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 20.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: _error != null
                    ? Container(
                        color: RmbUi.card,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(24.w),
                        child: Text(_error!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: RmbUi.textSecondary, fontSize: 13.sp)),
                      )
                    : !_ready
                        ? Container(
                            color: RmbUi.card,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                                color: RmbUi.accent),
                          )
                        : MobileScanner(
                            controller: _controller,
                            onDetect: _onDetect,
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
