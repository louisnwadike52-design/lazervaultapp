import 'package:intl/intl.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// MINIMUM RETAINED BALANCE — the client's half of the transfer floor.
///
/// Mirrors `minbalance.Policy` in microservices/shared/minbalance — the one
/// place the rule lives on the server, read by core-payments (transfers and
/// batch) and banking-service (withdrawals) alike. The SERVER is authoritative
/// and refuses the payout regardless; this exists so a user finds out at the
/// amount field, with a dialog that explains itself, instead of after tapping
/// through to the PIN sheet and getting a snackbar.
///
/// Dart cannot import a Go module, so this is the one unavoidable second
/// implementation. It is kept honest by reading the SAME admin rows and by
/// matching that package function for function: `blocks` ↔ `Blocks`,
/// `maxSendableMinor` ↔ `MaxPayoutMinor`, `_normaliseAccountType` ↔
/// `NormaliseAccountType`, `formatMinorForCopy` ↔ `FormatMinor`.
///
/// WHY THE CLIENT CAN DECIDE THIS AT ALL. The policy lives in three
/// `system_settings` rows under the `feature_` prefix, which the app already
/// polls and persists (EndpointRegistry → FeatureFlags). So this needs no new
/// request on the transfer path and no round trip at the moment the user is
/// typing — the values are already on the device.
///
/// WHY IT IS STILL CHECKED SERVER-SIDE. Users on builds released before this
/// feature have none of this code, the settings on a device can be stale by up
/// to one poll, and a balance can change between the check and the submit. The
/// server's refusal is the guarantee; this is the explanation.
///
/// THE DEFAULT IS OFF. `gateAvailable` reads an ABSENT key as available, and
/// the gate asks "may a user transfer while below the minimum?" — so with
/// nothing configured the answer is yes and nothing is restricted. Naming it
/// `_enabled` would have inverted that and switched the restriction on for
/// everyone the moment the app shipped.
class MinBalancePolicy {
  const MinBalancePolicy({
    required this.enforced,
    this.minimumMinor = 0,
    this.message = '',
    this.grantRestricted = false,
  });

  /// True when transfers that would breach the floor must be refused.
  final bool enforced;

  /// The balance that must remain, in MINOR units (kobo).
  final int minimumMinor;

  /// Admin-supplied copy. Empty means "use the built-in wording".
  final String message;

  /// True when the binding constraint is the customer's UNSPENT ONBOARDING
  /// GRANT rather than the operator's floor.
  ///
  /// It changes only the WORDING. Telling someone their wallet "must keep
  /// ₦2,000" when the real reason is a bonus we gave them reads as their own
  /// money being withheld — the opposite of what happened, and the support
  /// ticket this flag exists to avoid. Mirrors `Policy.GrantRestricted` in
  /// microservices/shared/minbalance.
  final bool grantRestricted;

  /// Folds the customer's UNSPENT ONBOARDING GRANT into the floor.
  ///
  /// Mirrors `Policy.WithRestricted` on the server, including the two rules
  /// that are easy to get wrong:
  ///
  /// THE GREATER OF THE TWO BINDS, never the sum. A ₦1,500 platform floor and
  /// a ₦2,000 unspent grant mean ₦2,000 must stay, not ₦3,500 — they are
  /// independent reasons to retain money, not additive ones. Adding them would
  /// hold back money for a reason that does not exist.
  ///
  /// IT CAN ARM A POLICY THAT WAS OTHERWISE OFF, and that is correct: the
  /// grant restriction does not depend on the operator's floor being switched
  /// on. It follows the money, not the setting. So
  /// `const MinBalancePolicy(enforced: false).withRestricted(n)` is the
  /// grant-only policy, which is what the flows use where the operator's floor
  /// does not apply (see [blocks]).
  ///
  /// The admin's floor copy describes the FLOOR, so when the grant is what
  /// actually binds that sentence states the wrong number for the wrong
  /// reason. It is dropped, exactly as the server drops it.
  MinBalancePolicy withRestricted(int restrictedMinor) {
    if (restrictedMinor <= 0) return this;
    if (!enforced || restrictedMinor > minimumMinor) {
      return MinBalancePolicy(
        enforced: true,
        minimumMinor: restrictedMinor,
        message: '',
        grantRestricted: true,
      );
    }
    return this;
  }

  /// The grant portion of [availableMinor] — what cannot be moved out.
  ///
  /// Zero unless the grant is the binding constraint, so a caller can use it
  /// to label a balance without first asking which rule won. Clamped to the
  /// balance: a restriction larger than the wallet would otherwise print a
  /// figure the customer does not have.
  int reservedForGrantMinor(int availableMinor) {
    if (!grantRestricted || minimumMinor <= 0 || availableMinor <= 0) return 0;
    return minimumMinor > availableMinor ? availableMinor : minimumMinor;
  }

  static const String _gate = 'feature_transfer_below_minimum';

  /// Resolves the policy for a wallet from the settings already on the device.
  ///
  /// [accountType] selects a per-wallet override
  /// (`feature_transfer_below_minimum_<type>_amount`) before falling back to
  /// the global amount — account types are data, so an operator can hold a
  /// floor on savings while leaving a current account alone.
  factory MinBalancePolicy.resolve({String? accountType}) {
    // `available == true` means transferring below the minimum is allowed,
    // i.e. the policy is NOT enforced.
    if (FeatureFlags.gateAvailable(_gate)) {
      return const MinBalancePolicy(enforced: false);
    }

    var minimum = 0;
    final type = _normaliseAccountType(accountType);
    if (type.isNotEmpty) {
      minimum = FeatureFlags.gateAmountMinor('${_gate}_$type');
    }
    if (minimum <= 0) {
      minimum = FeatureFlags.gateAmountMinor(_gate);
    }
    if (minimum <= 0) {
      // Switched on with no amount set is a half-finished change, not an
      // instruction to block every transfer. Matches the server exactly: off is
      // the only reading that cannot strand a user's money.
      return const MinBalancePolicy(enforced: false);
    }
    return MinBalancePolicy(
      enforced: true,
      minimumMinor: minimum,
      message: FeatureFlags.gateMessageOrEmpty(_gate),
    );
  }

  /// Folds case and spacing so "Personal Savings" and "personal_savings" reach
  /// the same override instead of silently falling back to the global floor.
  /// Must stay in step with `normaliseAccountType` on the server.
  static String _normaliseAccountType(String? raw) {
    final s = (raw ?? '').trim().toLowerCase();
    final b = StringBuffer();
    for (final ch in s.split('')) {
      final c = ch.codeUnitAt(0);
      final isLower = c >= 0x61 && c <= 0x7A;
      final isDigit = c >= 0x30 && c <= 0x39;
      if (isLower || isDigit) {
        b.write(ch);
      } else if (ch == ' ' || ch == '-' || ch == '_') {
        b.write('_');
      }
    }
    // Trim leading/trailing underscores without a RegExp on a hot path.
    var out = b.toString();
    while (out.startsWith('_')) {
      out = out.substring(1);
    }
    while (out.endsWith('_')) {
      out = out.substring(0, out.length - 1);
    }
    return out;
  }

  /// Whether sending [spendMinor] (amount plus any known fee) from
  /// [availableMinor] would breach the floor.
  ///
  /// Returns false on a zero or unknown balance: the client must never refuse
  /// on data it does not have. The server fails open for the same reason, and a
  /// dialog raised over a balance we could not read would be a refusal the user
  /// cannot act on or verify.
  bool blocks({required int availableMinor, required int spendMinor}) {
    if (!enforced || minimumMinor <= 0) return false;
    if (availableMinor <= 0 || spendMinor <= 0) return false;
    return availableMinor - spendMinor < minimumMinor;
  }

  /// The most that can be sent while respecting the floor. Clamped at zero,
  /// which is the honest answer when the wallet is already at or under it.
  int maxSendableMinor({required int availableMinor, int feeMinor = 0}) {
    if (!enforced) return availableMinor;
    final max = availableMinor - minimumMinor - feeMinor;
    return max < 0 ? 0 : max;
  }
}

/// What the refusal copy calls the thing being refused.
///
/// A withdrawal described as a transfer is the kind of wrongness a customer
/// notices, and `withdraw_funds_screen.dart` shows the same sheet the send
/// flows do. Mirrors `minbalance.Action` on the server so the app's dialog and
/// the server's backstop sentence name the same action.
enum MinBalanceAction {
  transfer(verb: 'transfer', noun: 'transfer'),
  withdrawal(verb: 'withdraw', noun: 'withdrawal');

  const MinBalanceAction({required this.verb, required this.noun});

  final String verb;
  final String noun;
}

/// Renders minor units the way the SERVER renders them, dropping a trailing
/// `.00` on a whole amount — "1,500" rather than "1,500.00".
///
/// WHY THIS EXISTS RATHER THAN A BARE NumberFormat. The server's fallback
/// sentence is what an older app renders into a snackbar, and a newer app
/// raises this policy's own dialog instead. Those are the same refusal reached
/// two ways, so they must read the same. They did not: the app used
/// `#,##0.00` and printed "₦1,500.00" while the server printed "₦1,500". The
/// server's shorter form won the consolidation on 31 Oct 2026 (it reads as a
/// sentence, and the floors are whole naira in practice), so this matches
/// `FormatMinor` in microservices/shared/minbalance — the canonical rule. If
/// one changes, change the other.
String formatMinorForCopy(int minor) {
  final neg = minor < 0;
  final abs = neg ? -minor : minor;
  var out = NumberFormat('#,##0').format(abs ~/ 100);
  final kobo = abs % 100;
  if (kobo != 0) {
    out = '$out.${kobo.toString().padLeft(2, '0')}';
  }
  return neg ? '-$out' : out;
}
