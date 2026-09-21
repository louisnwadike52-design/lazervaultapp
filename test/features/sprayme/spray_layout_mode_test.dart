import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_layout_mode.dart';

void main() {
  group('spray layout mode', () {
    test('the product default is grid', () {
      expect(kSprayDefaultLayoutMode, SprayLayoutMode.grid);
    });

    test('parses each mode from its own setting value', () {
      for (final mode in SprayLayoutMode.values) {
        expect(sprayLayoutModeFromSetting(mode.settingValue), mode);
      }
    });

    test('parsing is case- and whitespace-insensitive', () {
      expect(sprayLayoutModeFromSetting('  SPOTLIGHT '),
          SprayLayoutMode.spotlight);
      expect(sprayLayoutModeFromSetting('SideBar'), SprayLayoutMode.sidebar);
    });

    test('accepts the names other video products use', () {
      expect(sprayLayoutModeFromSetting('gallery'), SprayLayoutMode.grid);
      expect(sprayLayoutModeFromSetting('tiles'), SprayLayoutMode.grid);
      expect(sprayLayoutModeFromSetting('filmstrip'), SprayLayoutMode.sidebar);
      expect(sprayLayoutModeFromSetting('active_speaker'),
          SprayLayoutMode.spotlight);
      expect(sprayLayoutModeFromSetting('stage'), SprayLayoutMode.spotlight);
    });

    test('a bad or missing admin value falls back to the default, never throws',
        () {
      // A typo in the dashboard must not stop a live from rendering.
      for (final bad in <String?>[null, '', '   ', 'nonsense', '42', 'GRID!!']) {
        expect(sprayLayoutModeFromSetting(bad), kSprayDefaultLayoutMode);
      }
    });

    test('every mode has a distinct label, description and icon', () {
      final labels = SprayLayoutMode.values.map((m) => m.label).toSet();
      final descriptions =
          SprayLayoutMode.values.map((m) => m.description).toSet();
      final icons = SprayLayoutMode.values.map((m) => m.icon).toSet();
      expect(labels, hasLength(SprayLayoutMode.values.length));
      expect(descriptions, hasLength(SprayLayoutMode.values.length));
      expect(icons, hasLength(SprayLayoutMode.values.length));
      for (final m in SprayLayoutMode.values) {
        expect(m.label.trim(), isNotEmpty);
        expect(m.description.trim(), isNotEmpty);
      }
    });

    test('setting values round-trip through the parser', () {
      // Guards the admin dashboard contract: whatever we render as the stored
      // value must parse back to the same mode.
      for (final mode in SprayLayoutMode.values) {
        expect(sprayLayoutModeFromSetting(mode.settingValue), mode);
      }
    });
  });
}
