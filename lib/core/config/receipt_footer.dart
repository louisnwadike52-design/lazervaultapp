import 'package:lazervault/core/config/feature_flags.dart';

/// The single source of the text printed at the bottom of every shareable
/// receipt — the PDFs, and the PNG/JPG produced by capturing a receipt screen.
///
/// ## Why this exists
///
/// The company name and the legal disclaimer were hardcoded in sixteen PDF
/// services and fifteen receipt screens, one copy each. Two consequences, both
/// of which actually bit:
///
///  * Correcting a legal detail meant editing thirty-one files and shipping a
///    store release. The receipts said "Lazervault Technologies Ltd" — a
///    company that does not exist; the registration is "Lazervault LTD".
///  * The copies drifted. One said "licensed financial technology company"
///    where the rest said "financial technology company" — a materially
///    different claim to print on a document a user keeps as proof of payment,
///    and nobody chose it; it was a typo nobody could see across sixteen files.
///
/// Now admin-tunable, so a legal correction is a dashboard edit that reaches
/// every receipt at once instead of a release.
class ReceiptFooter {
  const ReceiptFooter._();

  /// Registered company name, e.g. `Lazervault LTD`.
  static String get company => FeatureFlags.receiptFooterCompany;

  /// Short support line for the footer's left column.
  static String get support => FeatureFlags.receiptFooterSupport;

  /// `© <year> <company>`.
  ///
  /// The year is always the real current year rather than part of the
  /// tunable text — an operator cannot forget to roll it over, and a stale
  /// year on a receipt looks like a forgery.
  static String copyright() => '(C) ${DateTime.now().year} $company';

  /// The legal paragraph, with `{company}` and `{subject}` substituted.
  ///
  /// [subject] is the thing the document confirms, as a noun phrase that
  /// reads after "a confirmation of" — e.g. `a data bundle purchase`,
  /// `an electricity bill payment`. It stays in code because it describes
  /// which receipt this is, not company policy.
  ///
  /// If an admin edits the template and drops a placeholder, the sentence
  /// simply loses that part rather than printing a literal `{company}` on a
  /// financial document — the failure mode has to be quiet, not visibly
  /// broken, because nobody proofreads every receipt type after an edit.
  static String disclaimer(String subject) {
    final template = FeatureFlags.receiptFooterDisclaimer;
    return template
        .replaceAll('{company}', company)
        .replaceAll('{subject}', subject.trim());
  }
}
