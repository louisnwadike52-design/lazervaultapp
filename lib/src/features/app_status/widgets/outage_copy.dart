import 'package:flutter/material.dart';

/// What the app decided was wrong, and what it is therefore allowed to claim.
///
/// Reported from a device mid-signup: the "Under maintenance" card, reading
/// "Our servers are being worked on right now. Your money and data are safe."
///
/// Two things are wrong with saying that to someone on the signup screen, and
/// they are separate problems:
///
///  1. **It may not be true.** A failed health probe used to mean "server down"
///     whenever the phone's radio reported a connection — and the radio reports
///     the RADIO, not the internet. Four bars of 4G with an exhausted data
///     bundle, a captive portal, or a broken APN all look identical to a healthy
///     connection from there, and all produce the same failed probe. See
///     [BackendReachability] for how the two are now told apart.
///
///  2. **It is reassurance about something she does not have.** She is three
///     steps into creating an account. She has no money with us and no data with
///     us, so a sentence promising both are safe answers a question she never
///     asked and quietly implies she has something at stake.
enum OutageKind {
  /// Our infrastructure answered badly, or answered nothing while the device
  /// demonstrably has working internet. Ours to own and ours to fix.
  server,

  /// The device cannot reach the internet at all. Nothing to do with us, and
  /// claiming otherwise would be a lie told at the worst possible moment.
  connection,
}

/// The copy for one outage, chosen by kind and by where the user is standing.
class OutageCopy {
  const OutageCopy({
    required this.icon,
    required this.title,
    required this.message,
    required this.dismissible,
  });

  final IconData icon;
  final String title;
  final String message;

  /// Whether the user may close the card and carry on.
  ///
  /// A server outage is not dismissible: there is genuinely nothing behind it
  /// that works, and it clears itself the moment health returns. A connection
  /// problem IS dismissible — it is the user's to fix, it may take them out of
  /// the app to do it, and trapping them behind a barrier they cannot act on
  /// from here would be the app blaming them for its own certainty.
  final bool dismissible;

  /// [isSignUp] is true anywhere in the create-an-account flow, where the user
  /// has nothing with us yet.
  factory OutageCopy.of(OutageKind kind, {required bool isSignUp}) {
    switch (kind) {
      case OutageKind.server:
        return OutageCopy(
          icon: Icons.construction_rounded,
          // "Under maintenance" reads as planned downtime of unknown length.
          // This is usually a deploy or a brief dependency wobble, and the
          // honest promise is that it is short.
          title: "We'll be right back",
          message: isSignUp
              // No account, so no money and no data to reassure her about. What
              // she actually wants to know is whether she has to start again.
              ? 'Our servers are being updated right now. Nothing you have '
                  'entered has been lost — please try again in a moment.'
              : 'Our servers are being updated right now. Your money and data '
                  'are safe. Please try again in a moment.',
          dismissible: false,
        );
      case OutageKind.connection:
        return const OutageCopy(
          icon: Icons.wifi_off_rounded,
          title: 'No internet connection',
          // Named concretely, because "check your connection" over four bars of
          // signal reads as the app being wrong. These are the things that
          // actually produce this state on a phone that looks connected.
          message: 'Your device cannot reach the internet right now. Check your '
              'mobile data or Wi-Fi — including whether your data bundle has run '
              'out — then try again.',
          dismissible: true,
        );
    }
  }
}
