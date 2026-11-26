import '../../src/features/recipients/data/models/recipient_model.dart';

/// The payer's saved recipients, readable SYNCHRONOUSLY.
///
/// WHY THIS EXISTS. When a payer types an account number, their own saved
/// payees should be offered before a bank name-enquiry is even attempted — the
/// common case for a typed number is someone they have paid before, and making
/// them wait on a provider round trip to be shown a payee they already saved
/// is latency for nothing.
///
/// That ordering is only possible if the saved set can be read without
/// awaiting. RecipientCubit holds it, but it is registered as a FACTORY, so
/// every caller gets a different instance with its own state; and
/// SWRCacheManager exposes only a Stream, with no public synchronous read.
/// Hence a small published snapshot, following the VendorAccess precedent in
/// this directory.
///
/// IN MEMORY ONLY, deliberately — unlike VendorAccess this is not persisted.
/// A saved-recipient list on disk is a list of who someone pays, which is not
/// something to leave on a device for a convenience that costs one list filter
/// to rebuild.
class SavedRecipientsSnapshot {
  SavedRecipientsSnapshot._();

  static List<RecipientModel> _recipients = const <RecipientModel>[];

  /// The last known saved set. Empty is always a safe answer: it costs a
  /// suggestion, never a payment.
  static List<RecipientModel> get current => _recipients;

  /// Publish a freshly-loaded set. Called from RecipientCubit.onChange, so it
  /// tracks every emit — including the ones that add, rename or delete a
  /// payee — rather than only the initial load.
  static void publish(List<RecipientModel> recipients) {
    _recipients = List<RecipientModel>.unmodifiable(recipients);
  }

  /// Drop it on sign-out. On a shared device the next holder must not be
  /// offered the previous holder's payees from memory.
  static void clear() {
    _recipients = const <RecipientModel>[];
  }

  /// Saved rows whose account number matches [accountNumber].
  ///
  /// Digits-only comparison: saved rows were written by several generations of
  /// this app and some carry spaces or dashes, so literal equality silently
  /// misses them.
  ///
  /// Linear over the payer's OWN list, which is tens of rows — not a directory
  /// scan. This stays correct at platform scale because it never grows with
  /// the number of users, only with how many payees one person has saved.
  static List<RecipientModel> matchingAccount(String accountNumber) {
    final typed = accountNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (typed.isEmpty) return const <RecipientModel>[];
    return _recipients
        .where(
            (r) => r.accountNumber.replaceAll(RegExp(r'[^0-9]'), '') == typed)
        .toList(growable: false);
  }
}
