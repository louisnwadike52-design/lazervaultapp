import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart' show CallOptions;
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/currency_exchange/data/flutterwave_country_rules.dart';
import 'package:lazervault/src/features/currency_exchange/data/services/transfer_requirements_service.dart';

class _MockDio extends Mock implements Dio {}

class _MockCallOptionsHelper extends Mock implements GrpcCallOptionsHelper {}

ExchangeRequirements _fallback() => const ExchangeRequirements(
      provider: 'flutterwave',
      currency: 'GBP',
      fields: [
        ExchangeFieldSpec(
            name: 'account_number', label: 'Account Number', required: true, type: 'text'),
      ],
    );

Response<dynamic> _resp(int code, dynamic body) => Response<dynamic>(
      requestOptions: RequestOptions(path: '/v1/exchange/transfer-requirements'),
      statusCode: code,
      data: body,
    );

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(Options());
  });

  group('ExchangeRequirements.fromJson', () {
    test('maps fields, keeping dotted provider paths intact', () {
      // beneficiary.transitNumber is how Nomba addresses a nested payload
      // field. Flattening it would break dispatch.
      final req = ExchangeRequirements.fromJson({
        'provider': 'nomba',
        'currency': 'CAD',
        'country': 'CA',
        'requires_bank_code': true,
        'fields': [
          {
            'name': 'beneficiary.transitNumber',
            'label': 'Transit Number',
            'required': true,
            'type': 'text',
            'pattern': r'^\d{5}$',
            'min_length': 5,
            'max_length': 5,
          },
          {'name': 'beneficiary.beneficiaryEmail', 'label': 'Email', 'type': 'email'},
        ],
      });

      expect(req, isNotNull);
      expect(req!.provider, 'nomba');
      expect(req.currency, 'CAD');
      expect(req.countryCode, 'CA');
      expect(req.requiresBankCode, isTrue);
      expect(req.isFlutterwave, isFalse);

      final transit = req.fields.firstWhere((f) => f.name == 'beneficiary.transitNumber');
      expect(transit.label, 'Transit Number');
      expect(transit.required, isTrue);
      expect(transit.minLength, 5);
      expect(transit.maxLength, 5);
      expect(transit.pattern!.hasMatch('12345'), isTrue);
      expect(transit.pattern!.hasMatch('abc'), isFalse);

      final email = req.fields.firstWhere((f) => f.name == 'beneficiary.beneficiaryEmail');
      expect(email.type, 'email');
      expect(email.required, isFalse, reason: 'absent "required" must not default to true');
    });

    test('returns null for an empty field set', () {
      // An empty form would submit a payout with no recipient detail at all.
      expect(ExchangeRequirements.fromJson({'provider': 'nomba', 'fields': []}), isNull);
      expect(ExchangeRequirements.fromJson({'provider': 'nomba'}), isNull);
    });

    test('survives a malformed regex without validating nothing silently', () {
      final req = ExchangeRequirements.fromJson({
        'provider': 'flutterwave',
        'currency': 'GBP',
        'fields': [
          {'name': 'sort_code', 'label': 'Sort Code', 'required': true, 'pattern': '([unclosed'},
        ],
      });
      expect(req, isNotNull);
      expect(req!.fields.single.pattern, isNull,
          reason: 'an uncompilable pattern must be dropped, not crash the form');
      expect(req.fields.single.required, isTrue,
          reason: 'dropping the pattern must not weaken the required flag');
    });

    test('drops nameless fields', () {
      final req = ExchangeRequirements.fromJson({
        'provider': 'flutterwave',
        'fields': [
          {'label': 'Nameless'},
          {'name': 'account_number', 'label': 'Account Number'},
        ],
      });
      expect(req!.fields.map((f) => f.name), ['account_number']);
    });
  });

  group('TransferRequirementsService.fetch', () {
    late _MockDio dio;
    late _MockCallOptionsHelper helper;
    late TransferRequirementsService svc;

    setUp(() {
      dio = _MockDio();
      helper = _MockCallOptionsHelper();
      when(() => helper.withAuth()).thenAnswer((_) async => CallOptions(metadata: {}));
      svc = TransferRequirementsService(
          dio: dio, callOptionsHelper: helper, baseUrl: 'http://test');
    });

    test('uses the server answer and names the carrying rail', () async {
      when(() => dio.get(any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'))).thenAnswer((_) async => _resp(200, {
            'provider': 'nomba',
            'currency': 'CAD',
            'fields': [
              {'name': 'beneficiary.transitNumber', 'label': 'Transit Number', 'required': true},
            ],
          }));

      final got = await svc.fetch(destCurrency: 'CAD', localFallback: _fallback());
      expect(got!.provider, 'nomba');
      expect(got.fields.single.name, 'beneficiary.transitNumber');
    });

    test('404 blocks the corridor and does NOT fall back', () async {
      // A definitive "no wired rail serves this". Rendering the bundled
      // Flutterwave form here would teach the user a corridor works and
      // collect details for a transfer that will be refused.
      when(() => dio.get(any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenAnswer((_) async => _resp(404, {'error': 'unsupported_currency'}));

      final got = await svc.fetch(destCurrency: 'PHP', localFallback: _fallback());
      expect(got, isNull);
    });

    test('serves the last good answer when the network fails', () async {
      var calls = 0;
      when(() => dio.get(any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'))).thenAnswer((_) async {
        calls++;
        if (calls == 1) {
          return _resp(200, {
            'provider': 'nomba',
            'currency': 'CAD',
            'fields': [
              {'name': 'beneficiary.transitNumber', 'label': 'Transit Number', 'required': true},
            ],
          });
        }
        throw DioException(requestOptions: RequestOptions(path: '/'));
      });

      await svc.fetch(destCurrency: 'CAD');
      final second = await svc.fetch(destCurrency: 'CAD', localFallback: _fallback());

      expect(second!.provider, 'nomba',
          reason: 'a cached NON-Flutterwave answer must win over the bundled '
              'Flutterwave map — that map omits the fields this rail requires');
    });

    test('falls back to the bundled map only when no answer was ever had', () async {
      when(() => dio.get(any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/')));

      final got = await svc.fetch(destCurrency: 'GBP', localFallback: _fallback());
      expect(got!.provider, 'flutterwave');

      final none = await svc.fetch(destCurrency: 'GBP');
      expect(none, isNull, reason: 'with no fallback offered there is nothing honest to render');
    });
  });
}
