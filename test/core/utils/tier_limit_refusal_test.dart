import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/utils/tier_limit_refusal.dart';

/// The exact sentences accounts-service produces, copied from
/// `internal/service/accounts_spending_limits.go`. Pinned here because the
/// classifier is matching PROSE: if the service rewords a refusal the app stops
/// recognising it, and the failure mode is silent — a tier cap delivered as a
/// generic "Transfer Failed / Try Again".
const _singleTxn =
    'hold failed: single transaction limit exceeded (limit: 5000.00, attempted: 99000.00)';
const _daily =
    'hold failed: daily spending limit exceeded (limit: 50000.00, spent today: 44000.00, remaining: 6000.00, attempted: 10000.00, kyc_tier: 1)';
const _monthly =
    'monthly spending limit exceeded (limit: 300000.00, spent this month: 295000.00, remaining: 5000.00, attempted: 10000.00, kyc_tier: 1)';

/// What friendlyError rewrites the above into before a screen sees it. The
/// classifier has to recognise BOTH forms — the raw refusal (cubit side) and
/// the customer copy (screen side).
const _friendlyDaily =
    'This would go over your daily transfer limit. You can raise it in '
    'Settings → Verification & Limits, or send a smaller amount today.';

/// family_spend_refusal.go / family_accounts_spend.go. NOT tier caps: a family
/// member's allowance is set by another member, and verifying identity does not
/// move it.
const _familyPerTxn = 'amount 10000.00 exceeds per-transaction limit 5000.00';
const _familyDaily =
    'this would exceed your daily limit of 20000.00 (already spent 18000.00)';

void main() {
  group('isTierCapRefusal', () {
    test('recognises the three accounts-service refusals', () {
      expect(isTierCapRefusal(_singleTxn), isTrue);
      expect(isTierCapRefusal(_daily), isTrue);
      expect(isTierCapRefusal(_monthly), isTrue);
    });

    test('recognises the single-transaction cap, which names no window', () {
      // The regression this exists for: 'single transaction limit exceeded'
      // contains neither 'daily', 'monthly' nor 'tier', so the earlier
      // predicate missed it and the customer got "Try Again" on a refusal that
      // fails identically every time.
      expect(_singleTxn.toLowerCase().contains('daily'), isFalse);
      expect(_singleTxn.toLowerCase().contains('monthly'), isFalse);
      expect(isTierCapRefusal(_singleTxn), isTrue);
    });

    test('recognises the KYC tier code', () {
      expect(isTierCapRefusal('rpc error: KYC_TIER_INSUFFICIENT'), isTrue);
    });

    test('recognises the customer copy friendlyError produces', () {
      expect(isTierCapRefusal(_friendlyDaily), isTrue);
    });

    test('a throttle is not a cap', () {
      expect(
          isTierCapRefusal('rate limit exceeded, try again shortly'), isFalse);
    });

    test('a family allowance is not a tier cap', () {
      expect(isTierCapRefusal(_familyPerTxn), isFalse);
      expect(isTierCapRefusal(_familyDaily), isFalse);
    });

    test('ordinary failures are not caps', () {
      for (final m in <String>[
        '',
        'insufficient available balance (available: 10.00, required: 99000.00)',
        'Unable to reach the server. Please check your internet connection.',
        'Your session has expired. Please sign in again.',
      ]) {
        expect(isTierCapRefusal(m), isFalse, reason: m);
      }
    });
  });

  group('enforcedTierFromRefusal', () {
    test('reads the tier the server said it applied', () {
      expect(enforcedTierFromRefusal(_daily), 1);
      expect(enforcedTierFromRefusal(_monthly), 1);
    });

    test('returns null rather than a guess when the server named none', () {
      // A wrong tier here renders a sheet that states something false about
      // the customer's account, so "no answer" must stay distinguishable from
      // "tier 1".
      expect(enforcedTierFromRefusal(_singleTxn), isNull);
      expect(enforcedTierFromRefusal(_friendlyDaily), isNull);
      expect(enforcedTierFromRefusal(null), isNull);
      expect(enforcedTierFromRefusal(''), isNull);
    });

    test('rejects values outside the real ladder', () {
      expect(enforcedTierFromRefusal('kyc_tier: 0'), isNull);
      expect(enforcedTierFromRefusal('kyc_tier: 4'), isNull);
      expect(enforcedTierFromRefusal('kyc_tier: 99'), isNull);
    });
  });

  group('resolveTierRefusal', () {
    test('ordinary case: offers the next tier up', () {
      final s = resolveTierRefusal(profileTier: 1, enforcedTier: 1);
      expect(s.currentTier, 1);
      expect(s.requiredTier, 2);
      expect(s.limitsOutOfSync, isFalse);
    });

    test('tier 2 offers tier 3', () {
      final s = resolveTierRefusal(profileTier: 2, enforcedTier: 2);
      expect(s.requiredTier, 3);
      expect(s.limitsOutOfSync, isFalse);
    });

    test('DRIFT: the ledger refused below the approved tier', () {
      // The reported case. auth-service has the customer at Tier 3;
      // accounts-service enforced Tier-1 limits, which is why ₦1,000 went
      // through and ₦10,000 did not. Verifying is NOT the remedy — there is
      // nothing left for them to verify.
      final s = resolveTierRefusal(profileTier: 3, enforcedTier: 1);
      expect(s.currentTier, 1, reason: 'the ENFORCING tier, not the profile');
      expect(s.profileTier, 3);
      expect(s.limitsOutOfSync, isTrue);
    });

    test('top of the ladder is never an upgrade prompt', () {
      // currentTier == requiredTier == 3 produced "You need Tier 3 … you're
      // currently Tier 3, verify your identity", over a button leading to a
      // flow already completed.
      final s = resolveTierRefusal(profileTier: 3);
      expect(s.currentTier, 3);
      expect(s.limitsOutOfSync, isTrue);
    });

    test('the server tier wins over the cached profile', () {
      final s = resolveTierRefusal(profileTier: 2, enforcedTier: 1);
      expect(s.currentTier, 1);
      expect(s.requiredTier, 2);
      expect(s.limitsOutOfSync, isTrue);
    });

    test('profile is the fallback when the server named no tier', () {
      final s = resolveTierRefusal(profileTier: 1);
      expect(s.currentTier, 1);
      expect(s.requiredTier, 2);
      expect(s.limitsOutOfSync, isFalse);
    });
  });

  // THE TWO COPIES OF THE EXCLUSION LIST HAVE TO AGREE.
  //
  // friendlyError cannot import this file — it is a widget-free core util and
  // tier_limit_refusal pulls in the KYC sheet — so the family and throttle
  // exclusions are written twice. That is tolerable only while something
  // checks they still say the same thing: a message one treats as a spending
  // limit and the other does not is a refusal that gets customer copy and
  // then no sheet to act on it, which is the exact failure both were written
  // to remove.
  group('spendingLimitMessage agrees with isTierCapRefusal', () {
    test('every message rewritten as a spending limit also routes to the sheet',
        () {
      for (final m in <String>[_singleTxn, _daily, _monthly]) {
        expect(spendingLimitMessage(Exception(m)), isNotNull, reason: m);
        expect(isTierCapRefusal(m), isTrue, reason: m);
      }
    });

    test('the copy it produces is itself still recognised downstream', () {
      // The screen classifies the REWRITTEN sentence, not the server's. If the
      // copy stops matching, the sheet silently stops appearing.
      for (final m in <String>[_singleTxn, _daily, _monthly]) {
        final copy = spendingLimitMessage(Exception(m));
        expect(copy, isNotNull, reason: m);
        expect(isTierCapRefusal(copy!), isTrue,
            reason: 'copy for "$m" was: $copy');
      }
    });

    test('both refuse family allowances', () {
      for (final m in <String>[_familyPerTxn, _familyDaily]) {
        expect(spendingLimitMessage(Exception(m)), isNull, reason: m);
        expect(isTierCapRefusal(m), isFalse, reason: m);
      }
    });

    test('both refuse throttles', () {
      const m = 'rate limit exceeded, try again shortly';
      expect(spendingLimitMessage(Exception(m)), isNull);
      expect(isTierCapRefusal(m), isFalse);
    });
  });
}
