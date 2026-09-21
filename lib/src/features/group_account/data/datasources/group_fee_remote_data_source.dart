import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// Platform-fee quote for a group-funds money movement.
///
/// Amounts are in MAJOR units (naira), converted from the minor units the
/// backend speaks so the UI never has to think about kobo.
class GroupFeeQuote {
  final bool feeApplies;
  final double fee;

  /// What the user ends up with: amount + fee when paying IN, amount − fee
  /// when being paid OUT. Computed server-side so the client never re-derives
  /// (and never disagrees with) the charge.
  final double total;

  /// Which rule produced the number — e.g. "50.00 flat" or "1.00% (max
  /// 1000.00)". Empty when no fee applies.
  final String description;

  const GroupFeeQuote({
    required this.feeApplies,
    required this.fee,
    required this.total,
    required this.description,
  });

  static const none =
      GroupFeeQuote(feeApplies: false, fee: 0, total: 0, description: '');
}

/// Which leg of a group-funds flow is being priced.
enum GroupFeeLeg {
  /// A member paying into a contribution — covers one-time contributions AND
  /// rotating-savings (ROSCA) cycle payments; both settle the same way.
  contribution,

  /// A contribution paying out to its recipient.
  payout,
}

/// Fetches platform-fee quotes from group-accounts' grpc-gateway HTTP route.
///
/// The quote is produced by the SAME server code that later charges the fee,
/// so what the user is shown before paying is what they are actually debited.
class GroupFeeRemoteDataSource {
  GroupFeeRemoteDataSource({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  late final String _base = _resolveBase();

  String _resolveBase() {
    for (final k in const ['FINANCIAL_GATEWAY_HTTP', 'FINANCIAL_HTTP_URL']) {
      final v = dotenv.maybeGet(k);
      if (v != null && v.trim().isNotEmpty) {
        return v.trim().replaceAll(RegExp(r'/$'), '');
      }
    }
    return endpointRegistry.httpFinancial;
  }

  /// Quote the fee on [amount] (major units) for [leg].
  ///
  /// Returns [GroupFeeQuote.none] on ANY failure. A fee display must never
  /// block someone from paying into their group: if we can't price it, we
  /// show no fee line rather than an error, and the server remains the
  /// authority at charge time.
  Future<GroupFeeQuote> quote({
    required String token,
    required double amount,
    GroupFeeLeg leg = GroupFeeLeg.contribution,
  }) async {
    if (amount <= 0) return GroupFeeQuote.none;
    try {
      final res = await _client.post(
        Uri.parse('$_base/v1/group-funds/fee-quote'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          // Server speaks MINOR units.
          'amount_minor': (amount * 100).round(),
          'leg': leg == GroupFeeLeg.payout ? 'payout' : 'contribution',
        }),
      );
      if (res.statusCode < 200 || res.statusCode >= 300) {
        return GroupFeeQuote.none;
      }
      final b = jsonDecode(res.body) as Map<String, dynamic>;
      double minor(dynamic v) =>
          (num.tryParse('${v ?? 0}') ?? 0).toDouble() / 100.0;
      return GroupFeeQuote(
        feeApplies: (b['feeApplies'] ?? b['fee_applies']) as bool? ?? false,
        fee: minor(b['feeMinor'] ?? b['fee_minor']),
        total: minor(b['totalMinor'] ?? b['total_minor']),
        description: (b['description'] as String?) ?? '',
      );
    } catch (_) {
      return GroupFeeQuote.none;
    }
  }
}
