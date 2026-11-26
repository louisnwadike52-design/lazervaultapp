import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_moderation.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_status_display.dart';

Crowdfund _campaign({
  CrowdfundStatus status = CrowdfundStatus.active,
  CrowdfundModeration moderation = CrowdfundModeration.unreviewed,
  DateTime? deadline,
}) {
  return Crowdfund(
    id: 'c1',
    creatorUserId: 1,
    creator: const CrowdfundCreator(
      userId: 1,
      username: 'baker',
      firstName: 'A',
      lastName: 'B',
      verified: false,
      facialRecognitionEnabled: false,
    ),
    title: 'Rebuild the bakery oven',
    description: 'd',
    story: '',
    crowdfundCode: 'CF-TEST01',
    targetAmount: 500000,
    currentAmount: 0,
    currency: 'NGN',
    deadline: deadline,
    category: 'business',
    status: status,
    donorCount: 0,
    progressPercentage: 0,
    createdAt: DateTime.utc(2026, 11, 1),
    updatedAt: DateTime.utc(2026, 11, 1),
    moderation: moderation,
  );
}

void main() {
  group('an unreviewed campaign cannot take money', () {
    // THE REQUIREMENT, IN ONE TEST. The operator's words: "somebody does not
    // create a campaign and then, before our AI system flags it, it starts
    // receiving money."
    //
    // The backend enforces this inside the row lock, so a contribution WOULD
    // be refused. What this pins is that the app does not OFFER the button
    // first — a donor who taps Donate, enters an amount, enters their PIN and
    // is then told no has been failed by the app, not protected by the
    // server.
    test('pending refuses contributions', () {
      final c = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.pending,
        ),
      );
      expect(crowdfundAcceptsContributions(c), isFalse);
      expect(c.canAcceptMoney, isFalse);
    });

    test('escalated refuses contributions', () {
      final c = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.escalated,
        ),
      );
      expect(crowdfundAcceptsContributions(c), isFalse);
    });

    test('blocked refuses contributions', () {
      final c = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.blocked,
        ),
      );
      expect(crowdfundAcceptsContributions(c), isFalse);
    });

    // RESTRICTED CAN TAKE MONEY, and that is deliberate on both sides. It is
    // a real campaign the platform does not recommend, not one it refused —
    // a donor who reads the badge and gives anyway is making an informed
    // choice, and blocking them would be the platform overruling its own
    // user. The app must agree with the backend's Fundable(), or a badge
    // would silently become a block.
    test('restricted still accepts contributions', () {
      final c = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.restricted,
        ),
      );
      expect(crowdfundAcceptsContributions(c), isTrue);
    });

    test('approved accepts contributions', () {
      final c = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.approved,
        ),
      );
      expect(crowdfundAcceptsContributions(c), isTrue);
    });

    // The lifecycle gate still rules. An approved campaign that is paused,
    // completed or past its deadline takes nothing — moderation ADDS a gate,
    // it does not replace one.
    test('approved but paused still refuses', () {
      final c = _campaign(
        status: CrowdfundStatus.paused,
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.approved,
        ),
      );
      expect(crowdfundAcceptsContributions(c), isFalse);
    });

    test('approved but past its deadline still refuses', () {
      final c = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.approved,
        ),
        deadline: DateTime.utc(2020, 1, 1),
      );
      expect(crowdfundAcceptsContributions(c), isFalse);
    });
  });

  group('an unknown moderation state reads as pending, never approved', () {
    // Rows written before moderation existed carry an empty string, and a
    // future backend state this build has not heard of arrives as a word the
    // parser does not know. Both mean "nobody has told me this is fine".
    // Defaulting to approved would make the app present an unreviewed
    // campaign as endorsed AND offer its Donate button.
    for (final raw in <String?>[null, '', '   ', 'quarantined', 'APPROVED_ISH']) {
      test('${raw ?? 'null'} is pending', () {
        expect(
          crowdfundModerationStateFrom(raw),
          CrowdfundModerationState.pending,
          reason: 'an unrecognised state must never resolve to approved',
        );
      });
    }

    // The ones it DOES know, including mixed case, which the wire can carry.
    test('known states parse, case-insensitively', () {
      expect(crowdfundModerationStateFrom('approved'),
          CrowdfundModerationState.approved);
      expect(crowdfundModerationStateFrom('Restricted'),
          CrowdfundModerationState.restricted);
      expect(crowdfundModerationStateFrom(' BLOCKED '),
          CrowdfundModerationState.blocked);
      expect(crowdfundModerationStateFrom('escalated'),
          CrowdfundModerationState.escalated);
    });
  });

  group('moderation survives the cache round trip', () {
    // THE BUG THIS EXISTS FOR.
    //
    // CrowdfundCubit caches whole pages by serialising through toJson and
    // reading back through fromJson. Moderation was not in either, so every
    // campaign read from cache arrived as `unreviewed` — which resolves to
    // PENDING. An APPROVED campaign would therefore render "Under review" and
    // hide its Donate button on every cache hit, and the cache is the normal
    // path rather than the exception.
    test('an approved campaign is still approved after a round trip', () {
      final before = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.approved,
        ),
      );
      final after = Crowdfund.fromJson(
          jsonDecode(jsonEncode(before.toJson())) as Map<String, dynamic>);

      expect(after.moderation.status, CrowdfundModerationState.approved);
      expect(crowdfundAcceptsContributions(after), isTrue,
          reason: 'a cached approved campaign must keep its Donate button');
    });

    test('a blocked campaign keeps its reason and appeal state', () {
      final moderatedAt = DateTime.utc(2026, 11, 20, 9, 30);
      final before = _campaign(
        moderation: CrowdfundModeration(
          status: CrowdfundModerationState.blocked,
          category: 'prohibited',
          reason: 'It falls outside what our crowdfunding policy allows.',
          moderatedAt: moderatedAt,
          appealCount: 1,
          canAppeal: false,
        ),
      );
      final after = Crowdfund.fromJson(
          jsonDecode(jsonEncode(before.toJson())) as Map<String, dynamic>);

      expect(after.moderation.status, CrowdfundModerationState.blocked);
      expect(after.moderation.reason, before.moderation.reason);
      expect(after.moderation.category, 'prohibited');
      expect(after.moderation.moderatedAt, moderatedAt);
      expect(after.moderation.appealCount, 1);
      // canAppeal is the SERVER's answer and must round-trip exactly: a
      // cached `true` would offer a button the server then refuses, and a
      // cached `false` would hide the creator's only recourse.
      expect(after.moderation.canAppeal, isFalse);
    });

    // A page cached by an older build has no moderation keys at all.
    test('a page cached before moderation existed reads as pending', () {
      final legacy = _campaign().toJson()
        ..remove('moderationStatus')
        ..remove('moderationReason')
        ..remove('moderationCategory')
        ..remove('moderatedAt')
        ..remove('appealCount')
        ..remove('canAppeal');

      final after = Crowdfund.fromJson(
          jsonDecode(jsonEncode(legacy)) as Map<String, dynamic>);
      expect(after.moderation.status, CrowdfundModerationState.pending);
      expect(after.moderation.canAppeal, isFalse);
    });
  });

  group('copyWith does not lose moderation', () {
    // A screen that copies a campaign to change one field would otherwise
    // silently reset moderation to `unreviewed` — hiding the Donate button on
    // a perfectly approved campaign, and only on whichever screen happened to
    // copy it.
    test('an unrelated copyWith keeps the verdict', () {
      final c = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.approved,
        ),
      ).copyWith(currentAmount: 25000);

      expect(c.moderation.status, CrowdfundModerationState.approved);
      expect(crowdfundAcceptsContributions(c), isTrue);
    });
  });

  group('Equatable sees a moderation change', () {
    // Equatable DROPS an emit whose state compares equal. With moderation
    // outside props, a campaign blocked while the screen was open would
    // re-fetch, compare equal on every other field, and never repaint — the
    // creator would keep looking at a live campaign the platform had refused.
    test('two campaigns differing only in moderation are not equal', () {
      final approved = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.approved,
        ),
      );
      final blocked = _campaign(
        moderation: const CrowdfundModeration(
          status: CrowdfundModerationState.blocked,
          reason: 'It falls outside what our crowdfunding policy allows.',
        ),
      );
      expect(approved == blocked, isFalse);
    });
  });

  group('the moderation model agrees with the backend', () {
    // isFundable mirrors models.CrowdfundModeration.Fundable(). If these
    // diverge the app offers a button the server refuses, or hides one it
    // would have allowed.
    test('fundable states are exactly approved and restricted', () {
      final fundable = CrowdfundModerationState.values
          .where((s) => CrowdfundModeration(status: s).isFundable)
          .toSet();
      expect(
        fundable,
        {
          CrowdfundModerationState.approved,
          CrowdfundModerationState.restricted,
        },
        reason: 'must match Fundable() in '
            'internal/models/crowdfund_moderation.go',
      );
    });

    test('under review is exactly pending and escalated', () {
      final waiting = CrowdfundModerationState.values
          .where((s) => CrowdfundModeration(status: s).isUnderReview)
          .toSet();
      expect(waiting, {
        CrowdfundModerationState.pending,
        CrowdfundModerationState.escalated,
      });
    });

    // An approved campaign must need NO moderation treatment in the UI, so
    // every existing screen renders exactly as it did before moderation
    // existed for the overwhelming majority of campaigns.
    test('only approved needs no UI treatment', () {
      final untreated = CrowdfundModerationState.values
          .where((s) => !CrowdfundModeration(status: s).needsTreatment)
          .toSet();
      expect(untreated, {CrowdfundModerationState.approved});
    });
  });
}
