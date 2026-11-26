import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/saved_recipients_snapshot.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

import 'recipient_cubit.dart';

/// MAKE SURE THE PAYER'S SAVED PAYEES ARE IN MEMORY BEFORE THEY START TYPING.
///
/// ## The gap this closes
///
/// [SavedRecipientsSnapshot] is deliberately passive: it holds whatever
/// `RecipientCubit` last emitted and never fetches anything itself. The
/// as-you-type account-number suggestions read it synchronously, which is the
/// whole point — a saved payee appears on the keystroke while the bank
/// name-enquiry behind it takes four to six seconds.
///
/// The assumption that made that safe was "every route into these screens
/// passes a recipient LIST first, so it is warm by the time anyone types".
/// That is not true. A payer who goes straight to Send Funds and types an
/// account number has loaded no list, so the snapshot is EMPTY and they are
/// offered nothing — which reads exactly like the feature not existing.
/// Reported 2026-11-19 against external-bank entry, where it matters most:
/// that is the path with the slow provider lookup.
///
/// ## Why a warm-up and not a load inside the snapshot
///
/// The snapshot lives in core/services and must not reach into a feature's
/// cubit. Fetching needs the session token and the active locale, both of
/// which are feature concerns. So the fetch stays here, next to
/// `RecipientCubit`, and the snapshot stays a dumb cache.
///
/// ## It is fire-and-forget, and that is correct
///
/// Nothing waits on it. If the fetch is slow, or fails, or the payer is
/// offline, the field behaves exactly as it does today: no saved rows, and the
/// bank lookup still runs. A suggestion list is a convenience; it must never
/// be able to delay or fail a payment.
void ensureSavedRecipientsWarm(BuildContext context) {
  // Already warm. The commonest case by far once a payer has used the app,
  // and it costs one list-length check.
  if (SavedRecipientsSnapshot.current.isNotEmpty) return;

  // A payer with genuinely no saved payees would otherwise re-fetch on every
  // keystroke-bearing screen for the life of the session. ONE DISPATCHED
  // FETCH is enough: the snapshot is republished by RecipientCubit.onChange
  // the moment they save their first one.
  //
  // DISPATCHED, not merely attempted — and that distinction was the whole
  // bug. The flag used to be set before the preconditions were checked, so a
  // call from a screen with no RecipientCubit above it (Split Bill and Batch
  // Transfer both warm from the dashboard, where there is none) burned the
  // single attempt without sending anything. Every later surface then read an
  // empty snapshot and offered no saved payees for the rest of the session,
  // which is indistinguishable from the matcher being broken. "I could not
  // look" and "there is nothing to find" are different answers and only the
  // second one should stop us looking again.
  if (_dispatched) return;

  final RecipientCubit cubit;
  final String token;
  final LocaleManager locale;
  try {
    final auth = context.read<AuthenticationCubit>().state;
    if (auth is! AuthenticationSuccess) return;
    cubit = context.read<RecipientCubit>();
    token = auth.profile.session.accessToken;
    locale = serviceLocator<LocaleManager>();
  } catch (_) {
    // No RecipientCubit above this screen, no session, or no locale — all of
    // which mean "cannot warm from here", none of which is worth surfacing,
    // and NONE of which should stop the next screen trying.
    return;
  }

  // Past this point a request really is going out, so claim the one attempt.
  _dispatched = true;

  // THE WHOLE BOOK, not the list's first page. See
  // RecipientCubit.warmSavedRecipientsSnapshot: the matcher searches by
  // number and a twenty-row page silently excluded everyone after the
  // twentieth payee.
  //
  // Fire-and-forget: nothing waits on it, and if it fails the field behaves
  // exactly as it does without it — no saved rows, bank lookup unaffected. A
  // suggestion list must never be able to delay or fail a payment.
  cubit
      .warmSavedRecipientsSnapshot(
        accessToken: token,
        countryCode: locale.currentCountry,
        currency: locale.currentCurrency,
      )
      .then((sent) {
    // A fetch that failed outright did not answer the question, so let the
    // next surface ask again rather than leaving the payer with a dead
    // matcher until they restart the app.
    if (!sent) _dispatched = false;
  });
}

/// Whether a warm-up fetch has actually been SENT this session.
///
/// Reset on sign-out alongside the snapshot itself, so the next holder of a
/// shared device gets their own attempt rather than inheriting a flag that
/// says somebody already looked.
bool _dispatched = false;

/// Called from the sign-out purge, beside [SavedRecipientsSnapshot.clear].
void resetSavedRecipientsWarmup() {
  _dispatched = false;
}
