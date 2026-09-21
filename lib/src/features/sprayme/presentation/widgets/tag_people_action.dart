import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_invite.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/tag_people_sheet.dart';

/// Opening the picker and sending the invites, in one place.
///
/// Both the create-session flow and the session detail screen tag people, and
/// the sequencing is the fiddly part: invites can only be sent once the session
/// EXISTS, and the result has to distinguish "tagged" from "already tagged" or
/// the host sees fewer people than they selected with no explanation.
class TagPeopleAction {
  const TagPeopleAction._();

  /// Shows the picker. Returns the chosen people, or null if dismissed.
  static Future<List<SprayInvitee>?> pick(
    BuildContext context, {
    Set<String> alreadyTagged = const {},
    List<SprayInvitee> initialSelection = const [],
  }) {
    return showModalBottomSheet<List<SprayInvitee>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TagPeopleSheet(
        alreadyTagged: alreadyTagged,
        initialSelection: initialSelection,
      ),
    );
  }

  /// Sends invites for an EXISTING session and reports the outcome.
  ///
  /// Returns true when at least one new person was tagged. Never throws: a
  /// failure here is surfaced to the host as a message, because the session
  /// itself is fine and the tagging can simply be retried.
  static Future<bool> send(
    BuildContext context, {
    required String sessionId,
    required List<SprayInvitee> invitees,
  }) async {
    if (invitees.isEmpty) return false;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final result = await serviceLocator<ISprayMeRepository>().inviteToSession(
        sessionId: sessionId,
        invitees: invitees,
      );
      HapticFeedback.lightImpact();
      messenger.showSnackBar(
        SnackBar(
          content: Text(_summarise(result)),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return result.invited.isNotEmpty;
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(_message(e)),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
  }

  /// Picks and sends in one step, for surfaces that already have a session.
  static Future<bool> pickAndSend(
    BuildContext context, {
    required String sessionId,
    Set<String> alreadyTagged = const {},
  }) async {
    final picked = await pick(context, alreadyTagged: alreadyTagged);
    if (picked == null || picked.isEmpty) return false;
    if (!context.mounted) return false;
    return send(context, sessionId: sessionId, invitees: picked);
  }

  /// States the outcome honestly.
  ///
  /// "Tagged 3 people" when two of the five were already tagged would look like
  /// two invites silently failed — so the already-tagged count is named.
  static String _summarise(InviteResult r) {
    final n = r.invited.length;
    final dupes = r.alreadyInvited;
    if (n == 0 && dupes > 0) {
      return dupes == 1
          ? 'That person was already tagged'
          : 'Those $dupes people were already tagged';
    }
    final tagged = n == 1 ? 'Tagged 1 person' : 'Tagged $n people';
    if (dupes == 0) return tagged;
    return '$tagged · $dupes already tagged';
  }

  static String _message(Object e) {
    final raw = e.toString().replaceFirst('Exception: ', '').trim();
    return raw.isEmpty ? 'Could not tag those people' : raw;
  }
}
