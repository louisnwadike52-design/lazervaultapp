import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The gate that decides whether someone is nagged to verify, and (when the
/// admin switch is on) whether they reach the dashboard at all. Both read the
/// same two fields, so the edges of this function are the edges of both.
void main() {
  group('resolveKycState — the three ways to be verified', () {
    test('tier 2 or better is verified whatever the status says', () {
      expect(resolveKycState(tier: 2, status: 'not_started'), KycState.verified);
      expect(resolveKycState(tier: 3, status: ''), KycState.verified);
    });

    test('an APPROVED status at a KNOWN tier 1 is NOT verified', () {
      // THIS TEST ASSERTED THE OPPOSITE, AND THE ASSUMPTION IN IT WAS THE BUG.
      //
      // It read "an approved status is verified even before the tier replica
      // lands", reasoning that the tier and the status are written by separate
      // paths so a freshly-approved user holds one before the other, and that
      // requiring both would gate a verified user on a race.
      //
      // The race is real in ONE direction only — tier up, status lagging — and
      // resolveKycState answers that first, with `t >= kMinVerifiedKycTier`,
      // before it ever looks at the status. The direction this test pinned is
      // not a race at all. auth-service's SyncVerifiedTier ends with
      // `UpdateKYCStatus(userID, tier, KYCStatusApproved)`: it writes the tier
      // and the status TOGETHER, with the status approved at whatever tier was
      // synced. A NIN verifies to Tier 1 (a NIN alone is not Tier 2), so
      // `tier 1 + approved` is not a transient skew — it is the permanent,
      // correct, steady state of every NIN-verified holder.
      //
      // Reading that as verified opened the dashboard to a Tier-1 holder, who
      // has no account number, because only Tier 2 mints one and both Nomba
      // and Flutterwave require a BVN to mint. A wallet that cannot receive a
      // transfer and nothing on screen explaining why.
      expect(resolveKycState(tier: 1, status: 'approved'), KycState.unverified);
      expect(resolveKycState(tier: 1, status: 'verified'), KycState.unverified);
      expect(resolveKycState(tier: 1, status: 'completed'), KycState.unverified);
    });

    test('an UNKNOWN tier still falls through to the status', () {
      // The guard is on a tier we were actually TOLD. Biometric and voice
      // logins rebuild the profile from a proto with no KYC fields, so the
      // tier arrives absent — and locking out a verified holder because the
      // payload omitted it would be the opposite mistake. A real account
      // always carries a tier of at least 1, so "0 or null" means "not told".
      expect(resolveKycState(tier: 0, status: 'approved'), KycState.verified);
      expect(resolveKycState(tier: null, status: 'approved'), KycState.verified);
    });

    test('a sub-tier-2 holder in review or rejected keeps that state', () {
      // The floor only intercepts the statuses that GRANT verification. A
      // Tier-1 holder waiting on a review must still read as inReview, or the
      // app would walk them back into a form whose documents we already hold.
      expect(resolveKycState(tier: 1, status: 'pending_review'), KycState.inReview);
      expect(resolveKycState(tier: 1, status: 'rejected'), KycState.rejected);
    });

    test('tier 1 is NOT verified — it is the baseline everyone starts on', () {
      expect(resolveKycState(tier: 1, status: 'not_started'), KycState.unverified);
    });
  });

  group('resolveKycState — absent is not the same as unverified', () {
    // THE BIOMETRIC BUG. UserModel.fromProto maps the `common` proto, which has
    // no KYC fields, and it builds the profile behind Face ID and voice login.
    // Reading that as "unverified" prompted fully verified users to verify, on
    // the app's most-used daily path.
    test('no tier and no status is UNKNOWN, and prompts nobody', () {
      final s = resolveKycState(tier: 0, status: null);
      expect(s, KycState.unknown);
      expect(s.shouldPrompt, isFalse);
    });

    test('nulls and blanks are all unknown, not unverified', () {
      for (final blank in <String?>[null, '', '   ']) {
        expect(resolveKycState(tier: null, status: blank), KycState.unknown,
            reason: 'status ${blank == null ? "null" : "\'$blank\'"}');
      }
    });

    test("but a real account's 'not_started' IS unverified and DOES prompt", () {
      // The users table defaults kyc_status to 'not_started', so a genuine
      // unverified holder always carries it. This is what stops the unknown
      // state swallowing the people the prompt exists for.
      final s = resolveKycState(tier: 0, status: 'not_started');
      expect(s, KycState.unverified);
      expect(s.shouldPrompt, isTrue);
    });
  });

  group('resolveKycState — in review is its own answer', () {
    test('pending_review prompts nobody', () {
      // They have done their part. Routing them back into the form invites a
      // second submission of documents already with us.
      expect(resolveKycState(tier: 1, status: 'pending_review').shouldPrompt,
          isFalse);
    });

    test('rejected DOES prompt — they must redo it', () {
      final s = resolveKycState(tier: 1, status: 'rejected');
      expect(s, KycState.rejected);
      expect(s.shouldPrompt, isTrue);
    });

    test('an unrecognised status falls back to the tier, not to a refusal', () {
      // A value added server-side tomorrow must degrade to "judge by tier",
      // never to "unverified — go and do it again".
      expect(resolveKycState(tier: 3, status: 'some_new_state'), KycState.verified);
      expect(resolveKycState(tier: 1, status: 'some_new_state'), KycState.unverified);
    });
  });

  group('KycLoginGate — the hard gate and the prompt never both fire', () {
    test('across every state and both switch positions', () {
      for (final required in [true, false]) {
        for (final state in KycState.values) {
          final g = KycLoginGate(state: state, isRequired: required);
          expect(g.blocksDashboard && g.shouldPromptOnDashboard, isFalse,
              reason: 'state=$state required=$required');
        }
      }
    });

    test('unknown neither blocks nor prompts, whatever the switch says', () {
      // The safety property: a payload that never carried the fields must not
      // be able to lock anyone out of the app.
      for (final required in [true, false]) {
        final g = KycLoginGate(state: KycState.unknown, isRequired: required);
        expect(g.blocksDashboard, isFalse);
        expect(g.shouldPromptOnDashboard, isFalse);
      }
    });

    test('none blocks nobody', () {
      expect(KycLoginGate.none.blocksDashboard, isFalse);
      expect(KycLoginGate.none.shouldPromptOnDashboard, isFalse);
    });
  });

  group('KycSnapshot — the biometric fallback', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await KycSnapshot.init();
    });

    test('a login that saw nothing does not erase what the last one knew', () {
      // This is the whole point. Biometric login carries no KYC fields; if it
      // overwrote the mirror with blanks, the fallback would be empty exactly
      // when it is needed.
      return () async {
        await KycSnapshot.remember(tier: 2, status: 'approved');
        await KycSnapshot.remember(tier: 0, status: '');
        expect(KycSnapshot.tier, 2);
        expect(KycSnapshot.status, 'approved');
      }();
    });

    test('an absent payload falls back to the mirror, so Face ID still asks',
        () async {
      await KycSnapshot.remember(tier: 1, status: 'not_started');
      final g = KycLoginGate.forHolder(kycTier: 0, kycStatus: null);
      expect(g.state, KycState.unverified);
      expect(g.shouldPromptOnDashboard, isTrue,
          reason: 'the once-per-login prompt must work on the most-used path');
    });

    test('a verified mirror means Face ID does NOT nag', () async {
      await KycSnapshot.remember(tier: 2, status: 'approved');
      final g = KycLoginGate.forHolder(kycTier: 0, kycStatus: null);
      expect(g.state, KycState.verified);
      expect(g.shouldPromptOnDashboard, isFalse);
    });

    test('a live reading always beats the mirror', () async {
      // The mirror can be stale; the payload cannot. A present value wins.
      await KycSnapshot.remember(tier: 1, status: 'not_started');
      final g = KycLoginGate.forHolder(kycTier: 3, kycStatus: 'approved');
      expect(g.state, KycState.verified);
    });

    test('a STALE mirror can prompt but must never block the dashboard',
        () async {
      // The safety property. A mirror that lags behind a verification done on
      // another device would otherwise lock someone out of the app entirely
      // when the admin switch is on.
      await KycSnapshot.remember(tier: 1, status: 'not_started');
      final g = KycLoginGate.forHolder(kycTier: 0, kycStatus: null);
      expect(g.fromMirror, isTrue);
      expect(g.blocksDashboard, isFalse,
          reason: 'a possibly-stale reading must not refuse the dashboard');
    });

    test('a LIVE unverified reading does block when the admin requires it',
        () async {
      final g = KycLoginGate(
          state: KycState.unverified, isRequired: true, fromMirror: false);
      expect(g.blocksDashboard, isTrue);
    });

    test('clearing it stops the next user inheriting the last one', () async {
      await KycSnapshot.remember(tier: 3, status: 'approved');
      await KycSnapshot.clear();
      expect(KycSnapshot.tier, 0);
      expect(KycSnapshot.status, '');
      expect(KycLoginGate.forHolder(kycTier: 0, kycStatus: null).state,
          KycState.unknown);
    });
  });
}
