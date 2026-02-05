import 'dart:convert';
import 'package:uuid/uuid.dart';

/// Types of mutations that can be queued for offline retry.
///
/// NOTE: Financial payment operations (tagPayment, transfer, invoicePayment,
/// groupContribution) are intentionally NOT included. Payments should NEVER
/// be queued offline because:
/// - Stale balance risk (user might not have funds when processed)
/// - Security token expiration
/// - Regulatory compliance concerns
/// - Major fintechs (Revolut, etc.) don't use this pattern
///
/// Only non-payment operations (creation, updates) are safe to queue.
enum MutationType {
  /// TagPay creation (creating a new tag - IOU request, not payment)
  tagCreation,

  /// Invoice creation (creating an invoice, not payment)
  invoiceCreation,

  /// Generic mutation (for extensibility)
  generic,
}

/// Status of a queued mutation.
enum MutationStatus {
  /// Waiting to be processed.
  pending,

  /// Currently being processed.
  processing,

  /// Successfully completed.
  completed,

  /// Failed after max retries.
  failed,

  /// Cancelled by user.
  cancelled,
}

/// Represents a queued mutation for offline retry.
///
/// When a network request fails due to connectivity issues,
/// the mutation is queued and automatically retried when
/// connectivity is restored.
class QueuedMutation {
  /// Unique identifier for this mutation.
  final String id;

  /// Type of mutation (determines how to process it).
  final MutationType type;

  /// Payload data needed to retry the mutation.
  final Map<String, dynamic> payload;

  /// When the mutation was created.
  final DateTime createdAt;

  /// When the mutation was last attempted.
  final DateTime? lastAttemptAt;

  /// Number of retry attempts made.
  final int retryCount;

  /// Current status of the mutation.
  final MutationStatus status;

  /// Error message from the last failed attempt.
  final String? lastError;

  /// Human-readable description for UI display.
  final String? description;

  /// Maximum retries allowed (default: 3).
  static const int maxRetries = 3;

  /// Minimum delay between retries (exponential backoff base).
  static const Duration retryBaseDelay = Duration(seconds: 2);

  const QueuedMutation({
    required this.id,
    required this.type,
    required this.payload,
    required this.createdAt,
    this.lastAttemptAt,
    this.retryCount = 0,
    this.status = MutationStatus.pending,
    this.lastError,
    this.description,
  });

  /// Creates a new mutation with a generated ID.
  factory QueuedMutation.create({
    required MutationType type,
    required Map<String, dynamic> payload,
    String? description,
  }) {
    return QueuedMutation(
      id: const Uuid().v4(),
      type: type,
      payload: payload,
      createdAt: DateTime.now(),
      description: description,
    );
  }

  /// Creates a TagPay creation mutation (NOT a payment - just an IOU request).
  factory QueuedMutation.tagCreation({
    required String taggedUserTagPay,
    required double amount,
    required String currency,
    String? description,
  }) {
    return QueuedMutation.create(
      type: MutationType.tagCreation,
      payload: {
        'taggedUserTagPay': taggedUserTagPay,
        'amount': amount,
        'currency': currency,
        'description': description,
      },
      description: 'Create tag for $taggedUserTagPay',
    );
  }

  /// Whether this mutation can be retried.
  bool get canRetry => retryCount < maxRetries && status == MutationStatus.pending;

  /// Whether this mutation has exhausted all retries.
  bool get isExhausted => retryCount >= maxRetries;

  /// Delay before next retry (exponential backoff).
  Duration get nextRetryDelay {
    // Exponential backoff: 2s, 4s, 8s
    return Duration(
      milliseconds: retryBaseDelay.inMilliseconds * (1 << retryCount),
    );
  }

  /// Creates a copy with updated fields.
  QueuedMutation copyWith({
    String? id,
    MutationType? type,
    Map<String, dynamic>? payload,
    DateTime? createdAt,
    DateTime? lastAttemptAt,
    int? retryCount,
    MutationStatus? status,
    String? lastError,
    String? description,
  }) {
    return QueuedMutation(
      id: id ?? this.id,
      type: type ?? this.type,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      retryCount: retryCount ?? this.retryCount,
      status: status ?? this.status,
      lastError: lastError ?? this.lastError,
      description: description ?? this.description,
    );
  }

  /// Serializes to JSON for persistence.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'payload': payload,
      'createdAt': createdAt.toIso8601String(),
      'lastAttemptAt': lastAttemptAt?.toIso8601String(),
      'retryCount': retryCount,
      'status': status.name,
      'lastError': lastError,
      'description': description,
    };
  }

  /// Deserializes from JSON.
  factory QueuedMutation.fromJson(Map<String, dynamic> json) {
    return QueuedMutation(
      id: json['id'] as String,
      type: MutationType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => MutationType.generic,
      ),
      payload: Map<String, dynamic>.from(json['payload'] as Map),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastAttemptAt: json['lastAttemptAt'] != null
          ? DateTime.parse(json['lastAttemptAt'] as String)
          : null,
      retryCount: json['retryCount'] as int? ?? 0,
      status: MutationStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => MutationStatus.pending,
      ),
      lastError: json['lastError'] as String?,
      description: json['description'] as String?,
    );
  }

  /// Encodes to JSON string.
  String encode() => jsonEncode(toJson());

  /// Decodes from JSON string.
  static QueuedMutation decode(String json) =>
      QueuedMutation.fromJson(jsonDecode(json) as Map<String, dynamic>);

  @override
  String toString() =>
      'QueuedMutation(id: $id, type: ${type.name}, status: ${status.name}, retries: $retryCount)';
}
