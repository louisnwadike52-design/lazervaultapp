import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utilities/invite_link.dart';

/// The invite URL is parsed at BOTH ends — here, and by the website's
/// lib/appStore.ts. They have to agree on the key and on what counts as a
/// valid code, because a disagreement is an invite that silently drops the
/// referral and costs somebody their commission with nothing on screen to say
/// so.
void main() {
  group('building the link', () {
    test('points at /download and carries the code', () {
      final url = InviteLink.forCode('LV4K2M');
      expect(url, 'https://lazervault.app/download?ref=LV4K2M');
    });

    test('falls back to the bare page when there is no code', () {
      // An invite without a referral is still a good invite. A trailing
      // "?ref=" would be a worse link than none.
      for (final empty in <String?>[null, '', '   ']) {
        expect(InviteLink.forCode(empty), 'https://lazervault.app/download');
      }
    });

    test('the URL is the download page, never the homepage', () {
      // The homepage is where this used to point, and it knows nothing about
      // the code — the whole defect this replaced.
      expect(InviteLink.downloadUrl, contains('/download'));
      expect(InviteLink.downloadUrl, isNot(endsWith('.app')));
    });

    test('the query key matches the one the website reads', () {
      expect(InviteLink.refKey, 'ref');
    });
  });

  group('reading a code off an incoming link', () {
    test('reads the code from an invite link', () {
      final code = InviteLink.codeFrom(
          Uri.parse('https://lazervault.app/download?ref=LV4K2M'));
      expect(code, 'LV4K2M');
    });

    test('normalises case and stray punctuation', () {
      // Links go through chat apps, email clients and a paste before they get
      // here. Handing a subtly different string to the backend would have it
      // rejected as unknown, losing the attribution silently.
      for (final raw in <String>['lv4k2m', ' LV4K2M ', 'LV4K-2M', 'lv4k2m%20']) {
        final code = InviteLink.codeFrom(
            Uri.parse('https://lazervault.app/download?ref=$raw'));
        expect(code, 'LV4K2M', reason: 'from "$raw"');
      }
    });

    test('honours the code on any path, not just /download', () {
      // Forwarded, shortened and re-shared links lose their path long before
      // they lose their query string.
      final code = InviteLink.codeFrom(
          Uri.parse('https://lazervault.app/?ref=LV4K2M'));
      expect(code, 'LV4K2M');
    });

    test('rejects anything that is not plausibly a code', () {
      // Dropping a mangled value is better than sending it to the backend to
      // be refused — a refusal reads to the user as "your code is wrong".
      for (final bad in <String>['', '   ', 'AB', '!!!', 'A-B', '-', '%%%']) {
        expect(
          InviteLink.codeFrom(
              Uri.parse('https://lazervault.app/download?ref=$bad')),
          isNull,
          reason: 'should reject "$bad"',
        );
      }
      // Too long to be one of ours.
      expect(
        InviteLink.codeFrom(Uri.parse(
            'https://lazervault.app/download?ref=ABCDEFGHIJKLMNOPQRST')),
        isNull,
      );
    });

    test('a link with no ref yields null, not an empty code', () {
      expect(
        InviteLink.codeFrom(Uri.parse('https://lazervault.app/download')),
        isNull,
      );
      // An empty value must not become "" — the signup prefill checks for
      // null, and "" would present as a filled-in field containing nothing.
      expect(
        InviteLink.codeFrom(Uri.parse('https://lazervault.app/download?ref=')),
        isNull,
      );
    });
  });

  test('round-trips: what we build is what we read', () {
    const code = 'LV4K2M';
    final parsed = InviteLink.codeFrom(Uri.parse(InviteLink.forCode(code)));
    expect(parsed, code);
  });
}
