import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/dashboard_adverts_service.dart';

/// THE SEED ADVERTS EXIST IN TWO REPOSITORIES AND MUST AGREE.
///
/// `kSeedDashboardAdverts` is what every installation renders until an admin
/// configures `dashboard_adverts` (live value today: `[]`, so the seeds ARE
/// what users see). `AFRICAN_STARTER_ADVERTS` in the admin dashboard's
/// DashboardAdvertsTab.tsx is the operator's "start from the defaults" button.
/// The Dart file has always carried a comment asking for the two to be kept in
/// step; nothing enforced it, so a slide replaced in one could sit unnoticed in
/// the other and an operator clicking "use the defaults" would silently roll
/// the artwork back.
///
/// Checked by image URL because that is the part that actually changes — and
/// because the URL is the VERSION: objects are edge-cached for four hours, so
/// new art always means a new key rather than new bytes under an old name.
void main() {
  final tab = File(
    '../apps/admin-dashboard/src/app/settings/page/DashboardAdvertsTab.tsx',
  );

  test('every seed advert has a usable image and link', () {
    expect(kSeedDashboardAdverts, isNotEmpty);
    for (final a in kSeedDashboardAdverts) {
      expect(a.imageUrl, startsWith('https://api.lazervault.app/'),
          reason: '${a.title}: art must be served from our own storage — '
              'hotlinked stock puts a third party in control of whether the '
              'dashboard renders');
      expect(a.imageUrl, endsWith('.webp'));
      expect(a.title.trim(), isNotEmpty);
      expect(a.link.trim(), isNotEmpty);
    }
  });

  test('image keys are unique — a reused key serves stale art for 4h', () {
    final urls = kSeedDashboardAdverts.map((a) => a.imageUrl).toList();
    expect(urls.toSet().length, urls.length,
        reason: 'two slides sharing a key means one of them is wrong');
  });

  test('sort order is dense and starts at zero', () {
    final sorts = kSeedDashboardAdverts.map((a) => a.sort).toList()..sort();
    expect(sorts, List<int>.generate(sorts.length, (i) => i));
  });

  test('the admin dashboard starter list serves the SAME art', () {
    if (!tab.existsSync()) {
      // The dashboard lives in another repository and may not be checked out
      // beside the app. Skip rather than fail — a missing sibling repo is not
      // a defect in this one.
      return;
    }
    final tsx = tab.readAsStringSync();
    for (final a in kSeedDashboardAdverts) {
      expect(
        tsx,
        contains(a.imageUrl),
        reason: 'DashboardAdvertsTab.tsx is missing the art for "${a.title}". '
            'An operator pressing "use the defaults" would roll the artwork '
            'back to whatever that file still names.',
      );
    }
  });
}
