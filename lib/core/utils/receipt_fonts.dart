import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

/// The typeface every generated receipt is drawn with.
///
/// This exists because the same broken font loader had been copied into
/// fifteen PDF services. Each one fetched Inter from fonts.gstatic.com and had
/// no other source, against a **v18** URL that now returns 404 — so every
/// receipt in the app silently fell back to the PDF package's built-in
/// Helvetica. The fonts were sitting in `assets/fonts/` the whole time.
///
/// Helvetica is not merely a different look. It is a Type 1 font limited to
/// its own encoding, and the pdf package RAISES on a character it cannot draw
/// rather than substituting one. A curly apostrophe or an accented letter in a
/// provider's text is therefore enough to fail a whole receipt, which reaches
/// the customer as "Share failed" with no way to get their document out.
///
/// Loading order:
///   1. The bundled asset — always present, no network, no failure mode.
///   2. The network, on the live v20 URL, so a broken asset bundle degrades
///      rather than failing outright.
///
/// Loaded once per process and shared: fifteen services previously kept
/// fifteen private copies of the same two typefaces.
class ReceiptFonts {
  const ReceiptFonts._();

  static pw.Font? regular;
  static pw.Font? bold;

  /// Whether a real TrueType face is available.
  ///
  /// When false the caller is drawing with the built-in font and MUST route
  /// text through an ASCII-safe fallback first — see `pdfSafe` in the
  /// gift-cards receipt_text.dart for the reference implementation.
  static bool get embedded => regular != null && bold != null;

  /// Loads the receipt typeface. Safe to call repeatedly; only the first call
  /// does work.
  static Future<void> load() async {
    if (embedded) return;
    try {
      regular = pw.Font.ttf(await rootBundle.load('assets/fonts/Inter-Regular.ttf'));
      bold = pw.Font.ttf(await rootBundle.load('assets/fonts/Inter-Bold.ttf'));
      return;
    } catch (_) {
      regular = null;
      bold = null;
    }
    // BOUNDED on purpose. An unbounded fetch here does not just delay the
    // font — it delays the receipt, so Share appears frozen on a bad network
    // with no indication that anything is happening. Five seconds, then draw
    // with what we have.
    try {
      final regularResponse = await http
          .get(Uri.parse(
              'https://fonts.gstatic.com/s/inter/v20/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfMZg.ttf'))
          .timeout(const Duration(seconds: 5));
      final boldResponse = await http
          .get(Uri.parse(
              'https://fonts.gstatic.com/s/inter/v20/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuFuYMZg.ttf'))
          .timeout(const Duration(seconds: 5));
      if (regularResponse.statusCode == 200 && boldResponse.statusCode == 200) {
        regular = pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
        bold = pw.Font.ttf(boldResponse.bodyBytes.buffer.asByteData());
      }
    } catch (_) {
      regular = null;
      bold = null;
    }
  }
}
