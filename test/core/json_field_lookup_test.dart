import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/json_field_lookup.dart';

/// A FIELD MUST BE READABLE WHICHEVER CONVENTION THE SERVER USED.
///
/// THE CASE, 2026-11-12. The BVN lookup service read only `error_code` /
/// `error_message`. grpc-gateway emits camelCase, so every failure decoded
/// with an empty code and an empty message — and the sheet fell through to
/// "That code didn't match." A customer whose DATE OF BIRTH disagreed with
/// her BVN record was told her one-time code was wrong, repeatedly, against a
/// three-attempt cap, while the server was returning the exact reason.
void main() {
  test('every spelling of the same field resolves', () {
    for (final key in [
      'error_code',
      'errorCode',
      'ErrorCode',
      'ERROR_CODE',
      'error-code',
    ]) {
      expect(jsonString({key: 'IDENTITY_DOB_MISMATCH'}, 'errorcode'),
          'IDENTITY_DOB_MISMATCH',
          reason: '$key must resolve — the wire convention is not ours to pin');
    }
  });

  test('lowercasing alone would NOT have been enough', () {
    // The underscore is the half that bites: 'error_code'.toLowerCase() is
    // still not 'errorcode'. This asserts the separator is stripped too.
    expect(canonicalJsonKey('error_code'), 'errorcode');
    expect(canonicalJsonKey('errorCode'), 'errorcode');
    expect(canonicalJsonKey('error_code'), canonicalJsonKey('errorCode'));
  });

  test('the real payload that went unread now reads', () {
    final gateway = <String, dynamic>{
      'success': false,
      'errorCode': 'IDENTITY_DOB_MISMATCH',
      'errorMessage':
          "That date doesn't match the one registered against this BVN. "
              'Check it and try again — 2 tries left.',
    };
    expect(jsonString(gateway, 'errorcode'), 'IDENTITY_DOB_MISMATCH');
    expect(jsonString(gateway, 'errormessage'), contains('2 tries left'));
  });

  test('absent, non-string and blank values are all empty, never null', () {
    expect(jsonString({}, 'errorcode'), '');
    expect(jsonString({'errorCode': 42}, 'errorcode'), '');
    expect(jsonString({'errorCode': '   '}, 'errorcode'), '');
    expect(jsonString({'errorCode': null}, 'errorcode'), '');
  });

  test('values are untouched — only keys are normalised', () {
    expect(jsonString({'errorCode': 'IDENTITY_DOB_MISMATCH'}, 'errorcode'),
        'IDENTITY_DOB_MISMATCH',
        reason: 'the CODE is compared upstream and must keep its casing');
  });
}
