// Pins Prestmit's documented sell-attachment limits in the client-side
// validator: JPG / PNG only, ≤5MB per file, ≤20 attachments per
// submission. Magic-byte sniff catches the iOS HEIC-renamed-to-jpg
// case that would otherwise reach /sell/create and 422.
//
// Source of truth for the limits: documentation.prestmit.io
// "Common Issues #2 — Missing or Invalid Attachments".

import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/validation/gift_card_validation.dart';

Uint8List _bytes(List<int> head, {int padTo = 0}) {
  final padded = List<int>.from(head);
  while (padded.length < padTo) {
    padded.add(0);
  }
  return Uint8List.fromList(padded);
}

void main() {
  group("GiftCardValidation.validateImageBytes", () {
    test("accepts JPEG magic bytes", () {
      final bytes = _bytes([0xFF, 0xD8, 0xFF, 0xE0, 0x00, 0x10], padTo: 1024);
      final res = GiftCardValidation.validateImageBytes(bytes);
      expect(res.isRight(), isTrue, reason: "JPEG should pass");
    });

    test("accepts PNG magic bytes", () {
      final bytes = _bytes(
        [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A],
        padTo: 1024,
      );
      final res = GiftCardValidation.validateImageBytes(bytes);
      expect(res.isRight(), isTrue, reason: "PNG should pass");
    });

    test("rejects HEIC-renamed-as-jpg (iOS lie)", () {
      // ftypheic at offset 4 — iOS HEIC magic. Even with .jpg
      // extension this would fail Prestmit's content sniff.
      final bytes = _bytes(
        [0x00, 0x00, 0x00, 0x18, 0x66, 0x74, 0x79, 0x70, 0x68, 0x65, 0x69, 0x63],
        padTo: 1024,
      );
      final res = GiftCardValidation.validateImageBytes(bytes);
      expect(res.isLeft(), isTrue, reason: "HEIC must not pass as JPEG");
    });

    test("rejects WEBP", () {
      final bytes = _bytes(
        [0x52, 0x49, 0x46, 0x46, 0x00, 0x00, 0x00, 0x00, 0x57, 0x45, 0x42, 0x50],
        padTo: 1024,
      );
      final res = GiftCardValidation.validateImageBytes(bytes);
      expect(res.isLeft(), isTrue);
    });

    test("rejects empty bytes", () {
      final res = GiftCardValidation.validateImageBytes(Uint8List(0));
      expect(res.isLeft(), isTrue);
    });

    test("rejects file over 5 MB cap", () {
      // JPEG-leading bytes + padding to 5MB + 1 byte.
      const oversize = 5 * 1024 * 1024 + 1;
      final bytes = _bytes([0xFF, 0xD8, 0xFF], padTo: oversize);
      final res = GiftCardValidation.validateImageBytes(bytes);
      expect(res.isLeft(), isTrue, reason: "5MB+1 must be rejected");
    });

    test("accepts file exactly at 5 MB cap", () {
      const exact = 5 * 1024 * 1024;
      final bytes = _bytes([0xFF, 0xD8, 0xFF], padTo: exact);
      final res = GiftCardValidation.validateImageBytes(bytes);
      expect(res.isRight(), isTrue, reason: "Exactly 5MB is the boundary — accept");
    });
  });

  group("GiftCardValidation.validateImageBatch", () {
    test("rejects zero attachments (Physical requires ≥1)", () {
      final res = GiftCardValidation.validateImageBatch(0);
      expect(res.isLeft(), isTrue);
    });

    test("accepts one attachment", () {
      final res = GiftCardValidation.validateImageBatch(1);
      expect(res.isRight(), isTrue);
    });

    test("accepts exactly the documented cap (20)", () {
      final res = GiftCardValidation.validateImageBatch(20);
      expect(res.isRight(), isTrue);
    });

    test("rejects 21st attachment", () {
      final res = GiftCardValidation.validateImageBatch(21);
      expect(res.isLeft(), isTrue);
    });
  });
}
