import 'package:lazervault/core/utils/brand_bank.dart';

/// A single bank suggestion for a bare account number, returned by the
/// account-number-first send-funds UX. Codes are already in the active
/// verification provider's scheme, so [bankCode] can be handed straight back to
/// verification / the transfer flow. [accountName] is already resolved, so
/// selecting a suggestion needs no second verify round-trip.
class AccountSuggestion {
  final String bankCode;
  final String bankName;
  final String accountName;
  final String accountNumber;

  /// True when this suggestion is LAZERVAULT itself rather than an external
  /// institution — i.e. the number resolved to an account on this platform.
  ///
  /// It matters because a Lazervault user's receiving number IS a real NUBAN at
  /// a partner bank, so the external name-enquiry resolves it perfectly well
  /// and the payer was offered only the expensive answer: money leaving over
  /// NIBSS, with a fee and a settlement delay, to land back in a wallet it
  /// never had to leave. This flag is what lets the surface offer the internal
  /// rail — free and instant — alongside it, and mark it as such.
  ///
  /// A surface MUST NOT auto-apply a suggestion with this set: it changes which
  /// rail the money takes, and that is the payer's decision to see and make.
  final bool isLazervault;

  /// Internal routing identities. Set only when [isLazervault].
  ///
  /// [internalAccountId] — not [accountNumber] — is the destination: a
  /// receiving number is a virtual account minted by whichever provider was
  /// active, while the account id is stable (see
  /// `RecipientModel.internalAccountId`). [internalUserId] is what the
  /// internal transfer rail routes on and what `canSendAsInternal` accepts as
  /// positive proof of an internal payee.
  final String internalUserId;
  final String internalAccountId;

  const AccountSuggestion({
    required this.bankCode,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    this.isLazervault = false,
    this.internalUserId = '',
    this.internalAccountId = '',
  });

  /// The Lazervault (internal) suggestion for a number that resolved to an
  /// account on this platform.
  ///
  /// [bankName] is `BrandBank.displayName` — the correct user-facing spelling,
  /// AND a value `BrandBank.isOurs` recognises, so a recipient built from this
  /// routes internally through the decision that already exists rather than a
  /// new one. The sentinel literal itself is untouched (CLAUDE.md §0).
  ///
  /// [bankCode] is empty on purpose: there is no bank to pay out to. A surface
  /// that gates on a non-empty bank code must take the internal branch for
  /// this suggestion instead of pushing it through name-enquiry.
  factory AccountSuggestion.lazervault({
    required String accountNumber,
    required String accountName,
    required String userId,
    required String accountId,
  }) {
    return AccountSuggestion(
      bankCode: '',
      bankName: BrandBank.displayName,
      accountName: accountName,
      accountNumber: accountNumber,
      isLazervault: true,
      internalUserId: userId,
      internalAccountId: accountId,
    );
  }
}
