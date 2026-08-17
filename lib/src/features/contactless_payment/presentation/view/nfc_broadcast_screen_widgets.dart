part of 'nfc_broadcast_screen.dart';

class NfcBroadcastScreen extends StatelessWidget {
  final PaymentSessionEntity session;
  final String nfcPayload;

  const NfcBroadcastScreen({
    super.key,
    required this.session,
    required this.nfcPayload,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: _NfcBroadcastView(session: session, nfcPayload: nfcPayload),
    );
  }
}

class _NfcBroadcastView extends StatefulWidget {
  final PaymentSessionEntity session;
  final String nfcPayload;

  const _NfcBroadcastView({
    required this.session,
    required this.nfcPayload,
  });

  @override
  State<_NfcBroadcastView> createState() => _NfcBroadcastViewState();
}

/// Why a receiver is in Session ID mode instead of NFC tap. Drives both the
/// one-time snackbar copy and the persistent in-screen alert, so the messaging
/// is consistent and tailored to the real cause.
abstract class _SessionIdReason {
  String get snackTitle;
  String get snackBody;
  String get title;
  String get body;
  bool get showOpenNfcSettings;
}

/// iPhone: Apple forbids third-party HCE, so an iPhone can never be tapped.
class _IosNoNfc implements _SessionIdReason {
  @override
  String get snackTitle => 'Use Session ID on iPhone';
  @override
  String get snackBody =>
      'iPhone can’t share payments by NFC tap. Tap “Copy Session ID”, then send '
      'it to the payer — they enter it under “Enter Session ID” in Scan to Pay.';
  @override
  String get title => 'NFC tap isn’t available on iPhone';
  @override
  String get body =>
      'Apple doesn’t allow iPhone-to-iPhone NFC payments. Tap “Copy Session ID” '
      'below and send it to the payer — they enter it under “Enter Session ID” '
      'in Scan to Pay to complete this payment.';
  @override
  bool get showOpenNfcSettings => false;
}

/// Android with NFC turned off (or no HCE hardware): tapping could work once
/// NFC is enabled, so we offer the settings shortcut AND the Session ID path.
class _AndroidNfcOff implements _SessionIdReason {
  @override
  String get snackTitle => 'NFC is off';
  @override
  String get snackBody =>
      'Turn on NFC to let the payer tap your phone, or tap “Copy Session ID” and '
      'send it to them to pay without tapping.';
  @override
  String get title => 'NFC is off on this phone';
  @override
  String get body =>
      'Turn on NFC so the payer can tap your phone, or tap “Copy Session ID” '
      'below and send it — they enter it under “Enter Session ID” in Scan to Pay.';
  @override
  bool get showOpenNfcSettings => true;
}
