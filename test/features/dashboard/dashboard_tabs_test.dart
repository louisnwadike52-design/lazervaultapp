import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_tabs.dart';

/// These tests exist because the five bottom-nav destinations were previously
/// described in three separate places that had silently drifted apart: index 1
/// was "AI Analytics" in the MotionTabBar, "Statistics" in the dashboard's
/// curved nav and "Budget" in the Lazerspray room's nav, each with a different
/// icon. The list is now the single source; these guards keep it that way.
void main() {
  group('dashboard tab destinations', () {
    test('there are exactly five, matching the TabController length', () {
      expect(kDashboardTabs, hasLength(5));
    });

    test('labels are sentence case, not Title Case', () {
      for (final tab in kDashboardTabs) {
        final words = tab.label.split(' ');
        for (var i = 1; i < words.length; i++) {
          final word = words[i];
          if (word.isEmpty) continue;
          // Acronyms (AI, NGN…) stay capitalised; ordinary words must not be.
          final isAcronym = word == word.toUpperCase();
          if (isAcronym) continue;
          expect(
            word[0],
            equals(word[0].toLowerCase()),
            reason: 'Non-leading word "$word" in "${tab.label}" is capitalised; '
                'bottom-nav labels are sentence case.',
          );
        }
      }
    });

    test('every label is non-empty and unique', () {
      final labels = kDashboardTabs.map((t) => t.label).toList();
      expect(labels.where((l) => l.trim().isEmpty), isEmpty);
      expect(labels.toSet(), hasLength(labels.length));
    });

    test('every destination has its own icon', () {
      final icons = kDashboardTabs.map((t) => t.icon).toList();
      expect(icons.toSet(), hasLength(icons.length));
    });

    test('lookup helpers return the list entry for in-range indices', () {
      for (var i = 0; i < kDashboardTabs.length; i++) {
        expect(dashboardTabLabel(i), equals(kDashboardTabs[i].label));
        expect(dashboardTabIcon(i), equals(kDashboardTabs[i].icon));
      }
    });

    test('lookup helpers degrade instead of throwing when out of range', () {
      // Called from build methods: a blank label beats crashing the app shell.
      for (final bad in <int>[-1, kDashboardTabs.length, 99]) {
        expect(dashboardTabLabel(bad), isEmpty);
        expect(dashboardTabIcon(bad), equals(Icons.circle));
      }
    });

    test('index 4 is Lifestyle — the spray room nav marks it active by index',
        () {
      expect(kDashboardTabs[4].label, equals('Lifestyle'));
    });
  });
}
