import 'package:dio/dio.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/currency_exchange/data/flutterwave_country_rules.dart';

/// Recipient-field requirements for one corridor, as the BACKEND resolved
/// them — including which provider they belong to.
///
/// The provider matters as much as the fields. The same destination asks for
/// different inputs depending on who carries the money: a Canadian payout on
/// Nomba needs a transit number and an Interac security question that
/// Flutterwave never asks for. A field set is only meaningful alongside the
/// rail that wants it, which is why this carries [provider] rather than being
/// a bare list.
class ExchangeRequirements {
  final String provider;
  final String currency;
  final String? countryCode;
  final bool requiresBankCode;
  final bool requiresBranch;
  final List<ExchangeFieldSpec> fields;

  const ExchangeRequirements({
    required this.provider,
    required this.currency,
    required this.fields,
    this.countryCode,
    this.requiresBankCode = false,
    this.requiresBranch = false,
  });

  /// True when these fields came from the incumbent rail, whose requirements
  /// the bundled [FlutterwaveCountryRules] map also describes. Used to decide
  /// whether falling back to that map is honest — see
  /// [TransferRequirementsService.fetch].
  bool get isFlutterwave => provider.toLowerCase() == 'flutterwave';

  static ExchangeRequirements? fromJson(Map<String, dynamic> json) {
    final rawFields = json['fields'];
    if (rawFields is! List || rawFields.isEmpty) {
      // An empty field set would render an empty form and submit a payout
      // carrying no recipient detail at all. Treat it as no answer.
      return null;
    }
    final fields = <ExchangeFieldSpec>[];
    for (final f in rawFields) {
      if (f is! Map) continue;
      final spec = _fieldFromJson(f.cast<String, dynamic>());
      if (spec != null) fields.add(spec);
    }
    if (fields.isEmpty) return null;

    return ExchangeRequirements(
      provider: (json['provider'] as String? ?? '').trim(),
      currency: (json['currency'] as String? ?? '').trim().toUpperCase(),
      countryCode: (json['country'] as String?)?.trim(),
      requiresBankCode: json['requires_bank_code'] == true,
      requiresBranch: json['requires_branch'] == true,
      fields: fields,
    );
  }

  static ExchangeFieldSpec? _fieldFromJson(Map<String, dynamic> f) {
    final name = (f['name'] as String? ?? '').trim();
    if (name.isEmpty) return null;

    // Only compile a pattern we can actually use. A malformed regex from the
    // server must not crash the form or, worse, silently validate nothing.
    RegExp? pattern;
    final rawPattern = (f['pattern'] as String? ?? '').trim();
    if (rawPattern.isNotEmpty) {
      try {
        pattern = RegExp(rawPattern);
      } catch (_) {
        pattern = null;
      }
    }

    int? positive(dynamic v) => (v is int && v > 0) ? v : null;

    final type = (f['type'] as String? ?? 'text').trim();
    return ExchangeFieldSpec(
      name: name,
      label: (f['label'] as String? ?? name).trim(),
      required: f['required'] == true,
      type: type.isEmpty ? 'text' : type,
      hint: (f['hint'] as String?)?.trim(),
      pattern: pattern,
      minLength: positive(f['min_length']),
      maxLength: positive(f['max_length']),
    );
  }
}

/// Fetches the recipient fields the corridor's ACTIVE rail requires.
///
/// This exists to end a duplication: the field rules lived both in the Go
/// service and in a bundled Dart map, with nothing keeping them in step and
/// neither knowing which provider would carry the transfer. Asking the backend
/// means a corridor a provider adds — or a field it starts requiring — reaches
/// the form without an app release.
class TransferRequirementsService {
  final Dio _dio;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final String baseUrl;

  /// Last good answer per corridor key, so a transient failure does not blank
  /// a form the user is part-way through.
  final Map<String, ExchangeRequirements> _cache = {};

  TransferRequirementsService({
    required Dio dio,
    required GrpcCallOptionsHelper callOptionsHelper,
    String? baseUrl,
  })  : _dio = dio,
        _callOptionsHelper = callOptionsHelper,
        baseUrl = baseUrl ?? endpointRegistry.httpFinancial;

  static String _key(String source, String dest) =>
      '${source.toUpperCase()}|${dest.toUpperCase()}';

  /// Returns the fields to render, or null when the corridor cannot be served.
  ///
  /// A null return must BLOCK the form. It means either the backend says no
  /// wired rail can carry this corridor, or we could not establish which
  /// fields are needed — and guessing is how money reaches the wrong account.
  ///
  /// [localFallback] is consulted only when we have never had a good answer
  /// AND the bundled map is an honest description of the corridor. That map
  /// describes FLUTTERWAVE's requirements, so it is a safe stand-in only while
  /// Flutterwave is the rail. Once a corridor is served by another provider,
  /// the cached answer for that corridor names it and the fallback is skipped.
  Future<ExchangeRequirements?> fetch({
    required String destCurrency,
    String sourceCurrency = 'NGN',
    ExchangeRequirements? localFallback,
  }) async {
    final key = _key(sourceCurrency, destCurrency);
    try {
      final opts = await _callOptionsHelper.withAuth();
      final response = await _dio.get(
        '$baseUrl/v1/exchange/transfer-requirements',
        queryParameters: {
          'currency': destCurrency.toUpperCase(),
          'source': sourceCurrency.toUpperCase(),
        },
        options: Options(
          headers: {'Content-Type': 'application/json', ...opts.metadata},
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200 && response.data is Map) {
        final parsed = ExchangeRequirements.fromJson(
          (response.data as Map).cast<String, dynamic>(),
        );
        if (parsed != null) {
          _cache[key] = parsed;
          return parsed;
        }
      }

      // 404 is a definitive "no wired rail serves this corridor". Do NOT fall
      // back — rendering a form for a corridor the backend will refuse wastes
      // the user's time and teaches them it works.
      if (response.statusCode == 404) {
        _cache.remove(key);
        return null;
      }
    } catch (_) {
      // Network/transport failure — fall through to the cache.
    }

    final cached = _cache[key];
    if (cached != null) return cached;

    // No answer, ever, for this corridor. The bundled map is only an honest
    // stand-in for Flutterwave, so use it only when the caller says it applies.
    return localFallback;
  }
}
