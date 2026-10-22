import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// `users.profile_picture` is **varchar(500)**. It holds a URL.
///
/// On 2026-10-22 the My Account avatar handed
/// `data:image/jpeg;base64,<~100KB>` straight to UpdateProfile, so auth-service
/// answered
///
///     ERROR: value too long for type character varying(500) (SQLSTATE 22001)
///
/// and the user saw "failed to update profile" on every single attempt. It had
/// never worked and could not have.
///
/// The working path existed the whole time and nothing on that screen called
/// it: ProfileCubit.uploadProfilePicture → storage-service → store the public
/// URL. That is the recurring defect shape here — a capability that is built,
/// wired and consulted by nothing.
///
/// This test fixes the rule in place: whatever is assigned to `profilePicture`
/// must not be image bytes. It scans source rather than behaviour because the
/// failure is a DATABASE error two services away from the widget, which no
/// widget test would surface.
void main() {
  // COMMENTS ARE STRIPPED FIRST. This repository explains its bugs at length
  // and quotes the offending symbols — including the paragraph above and the
  // one in my_account.dart — so a raw text scan would match its own
  // explanation and pass while the defect was back.
  String stripComments(String src) {
    final noBlock = src.replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '');
    return noBlock
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
  }

  test('nothing assigns base64 image data to profilePicture', () {
    final offenders = <String>[];
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .where((f) => !f.path.startsWith('lib/src/generated/'));

    // `profilePicture:` and the 120 characters that follow it — enough to see
    // the value expression without spilling into the next argument.
    final arg = RegExp(r'profilePicture:\s*([^,\)]{0,120})');

    for (final f in files) {
      final src = stripComments(f.readAsStringSync());
      for (final m in arg.allMatches(src)) {
        final value = m.group(1) ?? '';
        if (value.contains('base64') || value.contains('data:image')) {
          offenders.add('${f.path}: profilePicture: $value');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'profile_picture is varchar(500) and holds a URL. These pass '
          'image bytes instead, which fails with SQLSTATE 22001 on every '
          'upload:\n  ${offenders.join('\n  ')}\n'
          'Upload through ProfileCubit.uploadProfilePicture, which stores the '
          'file in storage-service and stamps the public URL.',
    );
  });

  test('the base64 avatar picker is gone, not merely unused', () {
    // Deleted rather than left orphaned: it compiled, it looked usable, and
    // its whole contract was to emit a data URI for an avatar. Leaving it in
    // the tree invites the next screen to wire it up again.
    expect(
      File('lib/src/features/widgets/profile_picture_picker.dart').existsSync(),
      isFalse,
      reason: 'profile_picture_picker.dart emitted '
          'data:image/jpeg;base64,... for an avatar, which can never fit '
          'varchar(500). Use showProfilePictureActions instead.',
    );
  });
}
