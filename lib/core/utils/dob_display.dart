import 'package:intl/intl.dart';

/// HOW A DATE OF BIRTH IS SHOWN TO A CUSTOMER.
///
/// THE CONFUSION THIS REMOVES, seen 2026-11-12. A customer's profile held
/// `1999-07-09` and her BVN record held `1999-09-07`. Every screen showed her
/// the ISO string, which reads as 9 July to someone using day/month and as
/// 7 September to someone using month/day — so the one fact that would have
/// told her what was wrong was displayed in the one format that cannot say
/// it. She re-submitted the same date against a three-attempt cap, was told
/// only that it did not match, and could not get past it.
///
/// Spelling the month out removes the ambiguity entirely: "9 July 1999" means
/// one thing in every convention. ISO stays the wire format — it is what the
/// registry and every API speak — and this is only ever for display.
///
/// Used by the onboarding details screen, the BVN date-of-birth correction
/// and the KYC profile fix, so a customer comparing the three is comparing
/// like with like.

/// The format a customer reads. `9 July 1999`.
final DateFormat _dobHuman = DateFormat('d MMMM yyyy');

/// humanDob renders a date unambiguously.
String humanDob(DateTime d) => _dobHuman.format(d);

/// humanDobFromIso renders a stored `yyyy-MM-dd` for display.
///
/// Returns the input unchanged when it cannot be parsed: showing a raw value
/// is better than showing nothing, and a half-written date must not make the
/// field look empty while the customer is still typing it elsewhere.
String humanDobFromIso(String? iso) {
  final raw = (iso ?? '').trim();
  if (raw.isEmpty) return '';
  final parsed = DateTime.tryParse(raw);
  if (parsed == null) return raw;
  return humanDob(parsed);
}

/// isoDob is the wire format: `yyyy-MM-dd`, zero padded.
///
/// Kept here beside the display form so the two can never drift — every call
/// site that shows a date also has to submit one.
String isoDob(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// The hint shown under a date-of-birth field.
///
/// Names the ORDER and gives a worked example, because the order is the part
/// that goes wrong. Deliberately not "DD/MM/YYYY": a customer who reads that
/// as a label rather than an instruction is exactly the one who transposes.
const String dobFormatHint = 'Day, month, year — for example 9 July 1999';

/// The line shown when a date must match an official record.
const String dobMustMatchHint =
    'This must match the date registered against your BVN, '
    'not the date you usually give.';
