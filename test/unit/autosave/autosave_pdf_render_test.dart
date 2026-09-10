import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/services/autosave_pdf_service.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Fake path_provider so the generator can write its temp file under test.
class _FakePathProvider extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  _FakePathProvider(this.dir);
  final String dir;

  @override
  Future<String?> getTemporaryPath() async => dir;
  @override
  Future<String?> getApplicationSupportPath() async => dir;
}

/// The rule export must survive the ₦ sign.
///
/// The built-in PDF font has no glyph for ₦ and the pdf package RAISES rather
/// than substituting, so a missing embedded font does not degrade to a tofu
/// box — it throws and the export fails outright. The generator therefore
/// loads the Inter faces BEFORE deciding on a currency symbol. These tests
/// pin that end to end by actually producing the document.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tmp;
  setUp(() {
    tmp = Directory.systemTemp.createTempSync('autosave_pdf_test');
    PathProviderPlatform.instance = _FakePathProvider(tmp.path);
  });
  tearDown(() => tmp.deleteSync(recursive: true));

  AutoSaveRuleEntity rule({
    String currency = 'NGN',
    String name = 'Save on wallet deposit',
  }) =>
      AutoSaveRuleEntity(
        id: 'c66745c2-84a9-4031-8f52-fe01b52220b0',
        userId: '806fd9c5-f872-4047-a9ab-19a156a25c64',
        name: name,
        description: 'Round up and tuck it away',
        triggerType: TriggerType.onDeposit,
        amountType: AmountType.percentage,
        amountValue: 10,
        sourceAccountId: '90cdbd14-8344-4521-a70a-8322fa8aec2e',
        destinationAccountId: '8c00c957-da32-4a9a-9828-4ec5e400c530',
        status: AutoSaveStatus.active,
        currency: currency,
        targetAmount: 1000,
        minimumBalance: 500,
        maximumPerSave: 100,
        createdAt: DateTime(2026, 9, 10, 2, 39),
        updatedAt: DateTime(2026, 9, 10, 2, 41),
        triggerCount: 1,
        totalSaved: 100,
      );

  Future<File> generate(AutoSaveRuleEntity r) =>
      AutoSavePdfService.generateRuleDetails(
        rule: r,
        sourceAccountLabel: 'Personal (****3115)',
        destinationAccountLabel: 'Savings (****2268)',
        triggerDescription: r.triggerDescription,
        amountDescription: r.amountDescription,
      );

  test('a naira rule renders to a real PDF instead of throwing on ₦', () async {
    final file = await generate(rule());
    expect(file.existsSync(), isTrue);
    final bytes = await file.readAsBytes();
    // %PDF- magic, and enough content that it is a page rather than a stub.
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    expect(bytes.length, greaterThan(2000));
  });

  test('non-naira currencies still render', () async {
    for (final c in const ['USD', 'GBP', 'EUR', 'KES']) {
      final file = await generate(rule(currency: c));
      expect(file.existsSync(), isTrue, reason: c);
      expect(await file.length(), greaterThan(2000), reason: c);
    }
  });

  test('user-supplied text with punctuation does not break the export',
      () async {
    // Rule names are free text. An em-dash / bullet / quotes reaching a font
    // without those glyphs is the same failure mode as ₦.
    final file = await generate(
        rule(name: 'Rent — “big” goal • 50% · café fund'));
    expect(file.existsSync(), isTrue);
    expect(await file.length(), greaterThan(2000));
  });
}
