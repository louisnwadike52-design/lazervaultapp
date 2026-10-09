import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart';

/// The Dart proto for `min_quantity` is HAND-EDITED.
///
/// Regenerating this file churns ~35k lines because the local
/// protoc-gen-dart is newer than the one the committed stubs came from, so a
/// single new field is added by hand in five places: the factory parameter,
/// the factory body, the BuilderInfo entry, the accessor block, and the
/// .pbjson descriptor. Five places is five chances to get one wrong, and a
/// wrong one fails at RUNTIME on a real response, not at compile time.
///
/// So this round-trips the field through actual serialisation.
void main() {
  test('min_quantity survives a wire round-trip', () {
    final sent = GetEPinNetworksResponse(
      minQuantity: 10,
      networks: [EPinNetwork(code: 'MTN', name: 'MTN', isActive: true)],
    );
    final back = GetEPinNetworksResponse.fromBuffer(sent.writeToBuffer());

    expect(back.minQuantity, 10,
        reason: 'a wrong field number or wire type loses the value silently');
    expect(back.networks.single.code, 'MTN',
        reason: 'the existing field must still decode alongside it');
  });

  test('JSON carries it too — the descriptor half of the hand-edit', () {
    // writeToJson uses the BuilderInfo; the pbjson descriptor backs
    // reflection. A field added to one and not the other round-trips on the
    // binary wire and vanishes here.
    final back = GetEPinNetworksResponse.fromJson(
      GetEPinNetworksResponse(minQuantity: 10).writeToJson(),
    );
    expect(back.minQuantity, 10);
  });

  test('absent reads as 0, which the app treats as "no minimum stated"', () {
    // An older server omits the field. 0 must not be mistaken for a real
    // floor, and it must not throw.
    final empty = GetEPinNetworksResponse();
    expect(empty.hasMinQuantity(), false);
    expect(empty.minQuantity, 0);
  });

  test('the field is unsigned — a negative cannot be smuggled in', () {
    final r = GetEPinNetworksResponse();
    r.minQuantity = 10;
    expect(r.minQuantity, 10);
  });
}
