import 'package:lazervault/core/config/feature_flags.dart';

/// MINIMUM RETAINED BALANCE — the client's half of the transfer floor.
///
/// Mirrors `MinBalancePolicy` in core-payments
/// (internal/service/transfer_min_balance.go). The SERVER is authoritative and
/// refuses the transfer regardless; this exists so a user finds out at the
/// amount field, with a dialog that explains itself, instead of after tapping
/// through to the PIN sheet and getting a snackbar.
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
  });

  /// True when transfers that would breach the floor must be refused.
  final bool enforced;

  /// The balance that must remain, in MINOR units (kobo).
  final int minimumMinor;

  /// Admin-supplied copy. Empty means "use the built-in wording".
  final String message;

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
