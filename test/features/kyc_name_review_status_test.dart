import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';

/// THE GATE ON THE NAME-COMPARISON CARD.
///
/// The card shows the BVN holder's name. The server sends that name for a
/// REVIEW (the customer passed a facial match against that record, and the
/// difference is the only thing they can act on) and withholds it for a
/// REFUSAL (nothing agreed, so we have evidence the asker is someone else).
/// If the UI ever rendered on the refusal path it would be displaying a
/// disclosure the backend deliberately declined to make — so the gate is
/// pinned here rather than left to the widget's caller.
ProveKycStatus status({
  String sessionState = 'pending',
  String failureReason = '',
  String bvnName = '',
  String profileName = '',
}) =>
    ProveKycStatus(
      verified: false,
      tier: 1,
      tierName: 'Tier 1',
      completedSteps: const [],
      nextTier: 2,
      nextRequirements: const [],
      message: 'some copy',
      sessionState: sessionState,
      failureReason: failureReason,
      bvnName: bvnName,
      profileName: profileName,
    );

void main() {
  group('nameUnderReview', () {
    test('true for a review carrying both names', () {
      expect(
        status(
          failureReason: 'name_review',
          bvnName: 'Nmesomachi Favour',
          profileName: 'mienye Favour',
        ).nameUnderReview,
        isTrue,
      );
    });

    test('FALSE for a refusal, even if names somehow arrive', () {
      // Defence in depth: the server does not send them on a refusal, and if
      // a future change ever did, the card must still not render.
      expect(
        status(
          sessionState: 'failed',
          failureReason: 'name_mismatch',
          bvnName: 'Sodiq Olalekan',
          profileName: 'Ronke Odabira',
        ).nameUnderReview,
        isFalse,
      );
    });

    test('false when the server sent no names (an older backend)', () {
      // Must degrade to `message`, not render a comparison of two blanks.
      expect(status(failureReason: 'name_review').nameUnderReview, isFalse);
      expect(
        status(failureReason: 'name_review', bvnName: 'Only One')
            .nameUnderReview,
        isFalse,
      );
      expect(
        status(failureReason: 'name_review', profileName: 'Only One')
            .nameUnderReview,
        isFalse,
      );
    });

    test('false for every unrelated failure reason', () {
      for (final r in [
        'cancelled',
        'expired',
        'data_mismatch',
        'rejected',
        ''
      ]) {
        expect(
          status(failureReason: r, bvnName: 'A B', profileName: 'C D')
              .nameUnderReview,
          isFalse,
          reason: 'reason "$r" must not open the name card',
        );
      }
    });
  });

  _lockoutGroup();

  group('wire parsing', () {
    test('reads camelCase and snake_case alike', () {
      // grpc-gateway's marshaller can be configured either way; this client
      // must not depend on which, exactly as it already does for every other
      // field on this response.
      for (final data in <Map<String, Object?>>[
        {'bvnName': 'A B', 'profileName': 'C D'},
        {'bvn_name': 'A B', 'profile_name': 'C D'},
      ]) {
        final s = ProveKycHttpService.parseStatusPayload({
          'verified': false,
          'tier': 1,
          'failureReason': 'name_review',
          ...data,
        });
        expect(s.bvnName, 'A B');
        expect(s.profileName, 'C D');
        expect(s.nameUnderReview, isTrue);
      }
    });

    test('nameCorrectionReceived reads both casings and defaults false', () {
      // Drives whether the card still ASKS for a correction. Defaulting true
      // would hide the only action a held customer has; defaulting null would
      // throw on an older server that does not send it.
      expect(
        ProveKycHttpService.parseStatusPayload({'nameCorrectionReceived': true})
            .nameCorrectionReceived,
        isTrue,
      );
      expect(
        ProveKycHttpService.parseStatusPayload(
            {'name_correction_received': true}).nameCorrectionReceived,
        isTrue,
      );
      expect(
        ProveKycHttpService.parseStatusPayload({}).nameCorrectionReceived,
        isFalse,
      );
      // A non-bool must not be read as truthy.
      expect(
        ProveKycHttpService.parseStatusPayload(
            {'nameCorrectionReceived': 'yes'}).nameCorrectionReceived,
        isFalse,
      );
    });

    test('absent fields read as empty, not null', () {
      final s = ProveKycHttpService.parseStatusPayload({
        'verified': false,
        'tier': 1,
      });
      expect(s.bvnName, '');
      expect(s.profileName, '');
      expect(s.nameUnderReview, isFalse);
    });
  });
}

/// THE LOCKOUT THIS PREVENTS.
///
/// `_allowSkip` on the KYC screen was `_reachedTier2` alone, and the tier is
/// deliberately WITHHELD while a name decision is outstanding. So a customer
/// who had completed a Prove session, passed its facial check, and was waiting
/// on a human to compare two spellings sat on a compulsory screen with no
/// skip, nothing to pop back to, and only "Sign in as someone else" — locked
/// out of the app for a delay that is ours, not theirs.
///
/// `nameUnderReview` is what opens that gate, so these are the cases that
/// decide whether someone is trapped.
void _lockoutGroup() {
  group('the gate-opening condition', () {
    test('a held review opens it', () {
      expect(
        status(
          failureReason: 'name_review',
          bvnName: 'Nmesomachi Favour',
          profileName: 'mienye Favour',
        ).nameUnderReview,
        isTrue,
      );
    });

    test('a REFUSAL does not open it', () {
      // name_mismatch means the records had nothing in common — the evidence
      // says this is not their BVN. That holder stays gated, with the
      // correction sheet as their route.
      expect(
        status(
          sessionState: 'failed',
          failureReason: 'name_mismatch',
          bvnName: 'Sodiq Olalekan',
          profileName: 'Ronke Odabira',
        ).nameUnderReview,
        isFalse,
      );
    });

    test('an ordinary unstarted/failed session does not open it', () {
      // Below Tier 2 the step is compulsory for someone who has not
      // submitted, and that must stay true — this is not a general bypass.
      for (final r in [
        '',
        'cancelled',
        'expired',
        'data_mismatch',
        'rejected'
      ]) {
        expect(status(failureReason: r).nameUnderReview, isFalse,
            reason: 'reason "$r" must not open the gate');
      }
    });
  });
}
