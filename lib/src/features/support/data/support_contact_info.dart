import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/support/data/support_api.dart';

/// The operator-published support address, for surfaces that cannot wait.
///
/// ## Why a cache and not just a call
///
/// The in-app dialogs fetch the address when they open and render nothing
/// while it is in flight — that is fine for a screen. A PDF is different: it
/// is a DOCUMENT, generated once and then saved, shared or printed. It cannot
/// re-render when a late answer arrives, and it must not be delayed or failed
/// by a settings request. So the address is cached, refreshed opportunistically,
/// and read synchronously at render time.
///
/// ## Never a hardcoded address
///
/// These three PDFs each carried a literal `support@lazervault.com`, while the
/// website, the transactional emails and the app's own help config all publish
/// `support@lazervault.app`. A customer who downloaded an exchange receipt, a
/// batch-transfer report or an invoice receipt was therefore told to write
/// somewhere different from every other surface.
///
/// The fix is not to correct the literal — it is to stop having one. The
/// address is a business commitment that someone reads that inbox, it changes
/// without an app release, and it belongs in the same setting every other
/// surface now reads.
///
/// ## When nothing is configured
///
/// [sentence] omits the email clause entirely rather than printing a guess.
/// A document that tells a customer to email an address nobody monitors is
/// worse than one that simply points them back into the app — and unlike a
/// screen, a PDF keeps saying it for as long as the file exists.
class SupportContactInfo {
  const SupportContactInfo._();

  static String? _cached;

  /// The last known address, or null when none has been fetched or set.
  static String? get address => _cached;

  /// Fetch and cache. Safe to call often; never throws.
  ///
  /// Call before generating a document. It is cheap when warm and, when it
  /// fails, leaves whatever was cached rather than clearing it — a transient
  /// network failure must not silently strip the address off a receipt.
  static Future<void> refresh() async {
    try {
      final settings =
          await SupportApi(serviceLocator<SecureStorageService>())
              .supportSettings();
      final v = settings.contactEmail?.trim() ?? '';
      if (v.isNotEmpty) _cached = v;
    } catch (_) {
      // Keep the previous value. See above.
    }
  }

  /// A complete help sentence for a document footer.
  ///
  /// [lead] is the document-specific opening, e.g. "For questions". The rest
  /// adapts to whether an address is configured, so the sentence always reads
  /// correctly rather than trailing off into a blank.
  static String sentence(String lead) {
    final a = _cached?.trim() ?? '';
    if (a.isEmpty) {
      return '$lead, please contact our support team through the Lazervault app.';
    }
    return '$lead, please contact our support team through the Lazervault app '
        'or email $a.';
  }
}
