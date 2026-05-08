import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/group_entities.dart';

/// One row on the Past Contributions list. The Flutter side reuses
/// the existing `Contribution` and `GroupAccount` entities for the
/// nested objects so cards, headers, and the cycle-history sub-screen
/// can all be reused without an adapter layer.
class PastContributionEntry {
  final Contribution contribution;
  final GroupAccount group;
  final DateTime? removedAt;
  final String removalReason;
  final int removedAtCycleIndex;
  final String refundStatus;       // none|pending|completed|failed
  final int refundAmount;          // minor units
  final int forfeitedAmount;       // minor units
  final String refundFailedReason;
  final bool selfExit;

  const PastContributionEntry({
    required this.contribution,
    required this.group,
    required this.removedAt,
    required this.removalReason,
    required this.removedAtCycleIndex,
    required this.refundStatus,
    required this.refundAmount,
    required this.forfeitedAmount,
    required this.refundFailedReason,
    required this.selfExit,
  });
}

class PastGroupEntry {
  final GroupAccount group;
  final DateTime? leftAt;
  final bool selfExit;
  final int activeContributionsAtExit;

  const PastGroupEntry({
    required this.group,
    required this.leftAt,
    required this.selfExit,
    required this.activeContributionsAtExit,
  });
}

class PastContributionDetails {
  final Contribution contribution;
  final PastContributionEntry membershipSummary;
  final List<ContributionMember> members;
  final List<ContributionPayment> myPayments;
  final List<ContributionPayment> allPaymentsPage;
  final List<Map<String, dynamic>> closedCycles;
  final Map<String, dynamic>? activeCycleAtExit;

  const PastContributionDetails({
    required this.contribution,
    required this.membershipSummary,
    required this.members,
    required this.myPayments,
    required this.allPaymentsPage,
    required this.closedCycles,
    required this.activeCycleAtExit,
  });
}

/// Talks to the financial-gateway grpc-gateway HTTP routes for the
/// new past-membership RPCs. Mirrors how the chat / cycles screens
/// already call grpc-gateway endpoints from Flutter — no new gRPC
/// channel needed in the app.
class PastMembershipsRemoteDataSource {
  PastMembershipsRemoteDataSource({http.Client? client})
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
    return 'http://10.0.2.2:8016';
  }

  Map<String, String> _headers(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  Future<List<PastContributionEntry>> listPastContributions({
    required String token,
    String filter = '',
    int page = 1,
    int pageSize = 20,
  }) async {
    final qp = <String, String>{
      'page': '$page',
      'pageSize': '$pageSize',
      if (filter.isNotEmpty) 'filter': filter,
    };
    final uri = Uri.parse('$_base/v1/me/past-contributions')
        .replace(queryParameters: qp);
    final res = await _client.get(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'past-contributions list failed (${res.statusCode}): ${res.body}';
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final entries = (body['entries'] as List?) ?? const [];
    return entries.map((e) => _entryFromJson(e as Map<String, dynamic>)).toList(growable: false);
  }

  Future<List<PastGroupEntry>> listPastGroups({
    required String token,
    String filter = '',
    int page = 1,
    int pageSize = 20,
  }) async {
    final qp = <String, String>{
      'page': '$page',
      'pageSize': '$pageSize',
      if (filter.isNotEmpty) 'filter': filter,
    };
    final uri =
        Uri.parse('$_base/v1/me/past-groups').replace(queryParameters: qp);
    final res = await _client.get(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'past-groups list failed (${res.statusCode}): ${res.body}';
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final entries = (body['entries'] as List?) ?? const [];
    return entries
        .map((e) => _groupEntryFromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<PastContributionDetails> getPastContributionDetails({
    required String token,
    required String contributionId,
  }) async {
    final uri = Uri.parse('$_base/v1/me/past-contributions/$contributionId');
    final res = await _client.get(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'past-contribution details failed (${res.statusCode}): ${res.body}';
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return PastContributionDetails(
      contribution: _contributionFromJson(
          body['contribution'] as Map<String, dynamic>),
      membershipSummary: _entryFromJson(
          body['membershipSummary'] as Map<String, dynamic>),
      members: ((body['members'] as List?) ?? const [])
          .map((m) => _memberFromJson(m as Map<String, dynamic>))
          .toList(growable: false),
      myPayments: ((body['myPayments'] as List?) ?? const [])
          .map((p) => _paymentFromJson(p as Map<String, dynamic>))
          .toList(growable: false),
      allPaymentsPage: ((body['allPaymentsPage'] as List?) ?? const [])
          .map((p) => _paymentFromJson(p as Map<String, dynamic>))
          .toList(growable: false),
      closedCycles:
          ((body['closedCycles'] as List?) ?? const []).cast<Map<String, dynamic>>(),
      activeCycleAtExit:
          body['activeCycleAtExit'] as Map<String, dynamic>?,
    );
  }

  // ----- JSON → entity adapters (kept private to this file) -----

  PastContributionEntry _entryFromJson(Map<String, dynamic> m) =>
      PastContributionEntry(
        contribution: _contributionFromJson(
            (m['contribution'] as Map<String, dynamic>?) ?? const {}),
        group: _groupFromJson(
            (m['group'] as Map<String, dynamic>?) ?? const {}),
        removedAt: _ts(m['removedAt']),
        removalReason: m['removalReason'] as String? ?? '',
        removedAtCycleIndex:
            (m['removedAtCycleIndex'] as num?)?.toInt() ?? 0,
        refundStatus: m['refundStatus'] as String? ?? 'none',
        refundAmount: int.tryParse('${m['refundAmount'] ?? 0}') ?? 0,
        forfeitedAmount: int.tryParse('${m['forfeitedAmount'] ?? 0}') ?? 0,
        refundFailedReason: m['refundFailedReason'] as String? ?? '',
        selfExit: (m['selfExit'] as bool?) ?? false,
      );

  PastGroupEntry _groupEntryFromJson(Map<String, dynamic> m) =>
      PastGroupEntry(
        group: _groupFromJson(
            (m['group'] as Map<String, dynamic>?) ?? const {}),
        leftAt: _ts(m['leftAt']),
        selfExit: (m['selfExit'] as bool?) ?? false,
        activeContributionsAtExit:
            (m['activeContributionsAtExit'] as num?)?.toInt() ?? 0,
      );

  GroupAccount _groupFromJson(Map<String, dynamic> m) {
    return GroupAccount(
      id: (m['id'] as String?) ?? '',
      name: (m['name'] as String?) ?? '',
      description: (m['description'] as String?) ?? '',
      visibility: _parseVisibility(m['visibility'] as String?),
      adminId: (m['createdBy'] as String?) ?? '',
      members: const [],
      contributions: const [],
      status: _parseGroupStatus(m['status'] as String?),
      imageUrl: (m['imageUrl'] as String?) ?? '',
      createdAt: _ts(m['createdAt']) ?? DateTime.now(),
      updatedAt: _ts(m['updatedAt']) ?? DateTime.now(),
      metadata: m['metadata'] is Map<String, dynamic>
          ? (m['metadata'] as Map<String, dynamic>)
          : null,
    );
  }

  Contribution _contributionFromJson(Map<String, dynamic> m) {
    final type = _parseContributionType(m['type'] as String?);
    return Contribution(
      id: (m['id'] as String?) ?? '',
      groupId: (m['groupId'] as String?) ?? '',
      title: (m['title'] as String?) ?? '',
      description: (m['description'] as String?) ?? '',
      targetAmount: double.tryParse('${m['targetAmount'] ?? 0}') ?? 0,
      currentAmount: double.tryParse('${m['currentAmount'] ?? 0}') ?? 0,
      currency: (m['currency'] as String?) ?? 'NGN',
      deadline: _ts(m['deadline']) ?? DateTime.now(),
      status: _parseContributionStatus(m['status'] as String?),
      createdBy: (m['createdBy'] as String?) ?? '',
      payments: const [],
      members: const [],
      createdAt: _ts(m['createdAt']) ?? DateTime.now(),
      updatedAt: _ts(m['updatedAt']) ?? DateTime.now(),
      type: type,
      currentCycle: (m['currentCycle'] as num?)?.toInt(),
      regularAmount: double.tryParse('${m['regularAmount'] ?? 0}'),
      autoPayEnabled: (m['autoPayEnabled'] as bool?) ?? false,
      allowPartialPayments: (m['allowPartialPayments'] as bool?) ?? false,
    );
  }

  ContributionMember _memberFromJson(Map<String, dynamic> m) {
    return ContributionMember(
      id: (m['id'] as String?) ?? '',
      contributionId: (m['contributionId'] as String?) ?? '',
      userId: (m['userId'] as String?) ?? '',
      userName: (m['userName'] as String?) ?? '',
      email: (m['email'] as String?) ?? '',
      profileImage: (m['profileImage'] as String?) ?? '',
      joinedAt: _ts(m['joinedAt']) ?? DateTime.now(),
      totalPaid: double.tryParse('${m['totalPaid'] ?? 0}') ?? 0,
      expectedAmount: double.tryParse('${m['expectedAmount'] ?? 0}') ?? 0,
      hasPaidCurrentCycle:
          (m['hasPaidCurrentCycle'] as bool?) ?? false,
      cyclePaidAmount:
          double.tryParse('${m['cyclePaidAmount'] ?? 0}') ?? 0,
      missedCycles: (m['missedCycles'] as num?)?.toInt() ?? 0,
      membershipStatus:
          _parseMembershipStatus(m['membershipStatus'] as String?),
    );
  }

  ContributionPayment _paymentFromJson(Map<String, dynamic> m) {
    return ContributionPayment(
      id: (m['id'] as String?) ?? '',
      contributionId: (m['contributionId'] as String?) ?? '',
      groupId: (m['groupId'] as String?) ?? '',
      userId: (m['userId'] as String?) ?? '',
      userName: (m['userName'] as String?) ?? '',
      amount: double.tryParse('${m['amount'] ?? 0}') ?? 0,
      currency: (m['currency'] as String?) ?? 'NGN',
      paymentDate: _ts(m['paymentDate']) ?? DateTime.now(),
      status: _parsePaymentStatus(m['status'] as String?),
      transactionId: m['transactionId'] as String?,
      receiptId: m['receiptId'] as String?,
      notes: m['notes'] as String?,
    );
  }

  // ----- enum / timestamp helpers -----

  DateTime? _ts(dynamic v) {
    if (v == null) return null;
    if (v is String && v.isNotEmpty) {
      return DateTime.tryParse(v);
    }
    return null;
  }

  GroupVisibility _parseVisibility(String? s) {
    switch (s) {
      case 'GROUP_VISIBILITY_PRIVATE':
      case 'private':
        return GroupVisibility.private;
      default:
        return GroupVisibility.public;
    }
  }

  GroupAccountStatus _parseGroupStatus(String? s) {
    switch (s) {
      case 'GROUP_ACCOUNT_STATUS_ACTIVE':
      case 'active':
        return GroupAccountStatus.active;
      case 'GROUP_ACCOUNT_STATUS_SUSPENDED':
      case 'suspended':
        return GroupAccountStatus.suspended;
      case 'GROUP_ACCOUNT_STATUS_DELETED':
      case 'deleted':
        return GroupAccountStatus.deleted;
      default:
        return GroupAccountStatus.active;
    }
  }

  ContributionType _parseContributionType(String? s) {
    switch (s) {
      case 'CONTRIBUTION_TYPE_ROTATING_SAVINGS':
      case 'rotating_savings':
        return ContributionType.rotatingSavings;
      default:
        return ContributionType.oneTime;
    }
  }

  ContributionStatus _parseContributionStatus(String? s) {
    switch (s) {
      case 'CONTRIBUTION_STATUS_PAUSED':
      case 'paused':
        return ContributionStatus.paused;
      case 'CONTRIBUTION_STATUS_COMPLETED':
      case 'completed':
        return ContributionStatus.completed;
      case 'CONTRIBUTION_STATUS_CANCELLED':
      case 'cancelled':
        return ContributionStatus.cancelled;
      default:
        return ContributionStatus.active;
    }
  }

  ContributionMembershipStatus _parseMembershipStatus(String? s) {
    switch (s) {
      case 'pending_invite':
        return ContributionMembershipStatus.pendingInvite;
      case 'declined':
        return ContributionMembershipStatus.declined;
      default:
        return ContributionMembershipStatus.active;
    }
  }

  PaymentStatus _parsePaymentStatus(String? s) {
    switch (s) {
      case 'PAYMENT_STATUS_PENDING':
      case 'pending':
        return PaymentStatus.pending;
      case 'PAYMENT_STATUS_PROCESSING':
      case 'processing':
        return PaymentStatus.processing;
      case 'PAYMENT_STATUS_AWAITING_VERIFICATION':
      case 'awaiting_verification':
        return PaymentStatus.awaitingVerification;
      case 'PAYMENT_STATUS_COMPLETED':
      case 'completed':
        return PaymentStatus.completed;
      case 'PAYMENT_STATUS_FAILED':
      case 'failed':
        return PaymentStatus.failed;
      case 'PAYMENT_STATUS_REFUNDING':
      case 'refunding':
        return PaymentStatus.refunding;
      case 'PAYMENT_STATUS_REFUNDED':
      case 'refunded':
        return PaymentStatus.refunded;
      case 'PAYMENT_STATUS_MANUAL_REVIEW':
      case 'manual_review':
        return PaymentStatus.manualReview;
      default:
        return PaymentStatus.pending;
    }
  }
}
