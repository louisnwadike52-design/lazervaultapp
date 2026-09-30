import '../../domain/repositories/electricity_bill_repository.dart';
import '../../domain/entities/bill_payment_entity.dart';

/// How the customer's meter details reached us.
///
/// WHY MANUAL EXISTS
/// -----------------
/// The disco name-lookup does not answer for every meter. Some discos are
/// intermittently down, some meters are simply absent from the vendor's
/// directory, and a few return a blank name for an account that pays fine.
/// Until now that was a dead end: a red snackbar, and no way past it. The
/// customer's electricity is real and their meter number is on the card in
/// their hand — the app refusing to take it is our problem, not theirs.
///
/// Manual mode accepts what the customer knows: their disco and their meter
/// number. It does NOT pretend the lookup succeeded, and the confirmation
/// screen says the name could not be confirmed, because paying the wrong
/// meter is unrecoverable and the user is the only one who can catch it.
enum MeterEntryMode {
  /// We asked the disco and it told us who the meter belongs to.
  auto,

  /// The customer told us. Nobody verified the name.
  manual;

  bool get isManual => this == MeterEntryMode.manual;
}

/// The stand-in result for a manual entry.
///
/// `isValid: false` is the important part and is deliberate: downstream code
/// asking "did this verify?" must get NO. Naming it valid to make the screens
/// simpler would be a lie told at the one moment it costs money.
MeterValidationResult manualMeterResult({
  required String meterNumber,
  required MeterType meterType,
}) =>
    MeterValidationResult(
      customerName: '',
      customerAddress: null,
      meterNumber: meterNumber,
      meterType: meterType,
      isValid: false,
    );

/// What to show where a verified customer name would go.
///
/// Never an empty string: a blank line reads as a rendering bug and invites
/// the user to tap on. It has to say the thing out loud.
String meterHolderLabel(MeterValidationResult r) {
  final name = r.customerName.trim();
  if (name.isNotEmpty) return name;
  return 'Not confirmed by the disco';
}
