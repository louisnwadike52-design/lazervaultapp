import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:uuid/uuid.dart';

// CryptoWithdrawCubit (PR6) — drives the Send screen end-to-end. States
// follow the same sealed-class pattern as CryptoSwapCubit so receipt screens
// can `switch` exhaustively.

sealed class CryptoWithdrawState extends Equatable {
  const CryptoWithdrawState();
  @override
  List<Object?> get props => [];
}

class CryptoWithdrawInitial extends CryptoWithdrawState {}

class CryptoWithdrawSubmitting extends CryptoWithdrawState {
  const CryptoWithdrawSubmitting();
}

class CryptoWithdrawProcessing extends CryptoWithdrawState {
  final String transactionId;
  final String reference;
  final String quidaxWithdrawId;
  final String currency;
  final String network;
  final String fundUid;
  const CryptoWithdrawProcessing({
    required this.transactionId,
    required this.reference,
    required this.quidaxWithdrawId,
    required this.currency,
    required this.network,
    required this.fundUid,
  });
  @override
  List<Object?> get props => [transactionId, reference, quidaxWithdrawId];
}

class CryptoWithdrawCompleted extends CryptoWithdrawState {
  final String transactionId;
  final String reference;
  final String txid;
  final String network;
  final String currency;
  const CryptoWithdrawCompleted({
    required this.transactionId,
    required this.reference,
    required this.txid,
    required this.network,
    required this.currency,
  });
  @override
  List<Object?> get props => [transactionId, reference, txid];
}

class CryptoWithdrawFailed extends CryptoWithdrawState {
  final String reason;
  const CryptoWithdrawFailed(this.reason);
  @override
  List<Object?> get props => [reason];
}

class CryptoWithdrawCubit extends Cubit<CryptoWithdrawState> {
  final CryptoGrpcClient _client;
  static const _uuid = Uuid();
  String? _lastIntentId;

  CryptoWithdrawCubit({required CryptoGrpcClient client})
      : _client = client,
        super(CryptoWithdrawInitial());

  /// Initiate a Quidax send. Caller is responsible for collecting all the
  /// inputs from the user (Send screen) and verifying PIN via the standard
  /// bottom-sheet mixin before calling this.
  Future<void> submit({
    required String accountId,
    required String recipientType, // "coin_address" | "internal"
    required String currency,
    required int amountMinor,
    required String fundUid,
    String network = '',
    String destinationTag = '',
    String transactionNote = '',
    String narration = '',
    String transactionPin = '',
    String recipientUserId = '',
    String recipientUsername = '',
    String? clientIntentId,
  }) async {
    emit(const CryptoWithdrawSubmitting());

    // The caller's id wins when provided: the PIN verification token is
    // BOUND server-side to the transaction id the PIN sheet was shown with,
    // and the saga validates it against client_intent_id. Minting a separate
    // UUID here broke that binding — every UI send failed with
    // "PIN verification token is invalid, expired, or already used".
    // Fresh per attempt either way, so retries never short-circuit on the
    // idempotency key with a stale token.
    final intentId = clientIntentId ?? _uuid.v4();
    _lastIntentId = intentId;

    try {
      final resp = await _client.withdraw(
        accountId: accountId,
        recipientType: recipientType,
        currency: currency.toLowerCase(),
        amountMinorUnits: Int64(amountMinor),
        fundUid: fundUid,
        clientIntentId: intentId,
        network: network.toLowerCase(),
        destinationTag: destinationTag,
        transactionNote: transactionNote,
        narration: narration,
        transactionPin: transactionPin,
        recipientUserId: recipientUserId,
        recipientUsername: recipientUsername,
      );

      final terminalDone = _isTerminalDone(resp.status);
      if (terminalDone) {
        emit(CryptoWithdrawCompleted(
          transactionId: resp.transactionId,
          reference: resp.reference,
          txid: '',
          network: network,
          currency: currency,
        ));
        return;
      }

      emit(CryptoWithdrawProcessing(
        transactionId: resp.transactionId,
        reference: resp.reference,
        quidaxWithdrawId: resp.quidaxWithdrawId,
        currency: currency,
        network: network,
        fundUid: fundUid,
      ));
    } catch (e) {
      emit(CryptoWithdrawFailed(_friendlyError(e)));
    }
  }

  /// Poll the server for terminal state. Receipt screen calls this in a
  /// loop with backoff while the webhook delivers asynchronously.
  Future<void> refreshStatus(String transactionId) async {
    try {
      final resp = await _client.getCryptoWithdrawalStatus(transactionId);
      switch (_normalize(resp.status)) {
        case 'done':
          emit(CryptoWithdrawCompleted(
            transactionId: resp.transactionId,
            reference: resp.reference,
            txid: resp.txid,
            network: resp.network,
            currency: resp.currency,
          ));
          return;
        case 'rejected':
          emit(CryptoWithdrawFailed(resp.failReason.isNotEmpty
              ? resp.failReason
              : 'Withdrawal rejected by Quidax'));
          return;
        default:
          // Still in-flight; receipt screen keeps polling.
          return;
      }
    } catch (e) {
      // Network blip; don't tear down the receipt screen. Receipt UI
      // surfaces "Refreshing..." failure non-destructively.
    }
  }

  String? get lastIntentId => _lastIntentId;

  static bool _isTerminalDone(String status) => _normalize(status) == 'done';

  static String _normalize(String raw) {
    final r = raw.toLowerCase().trim();
    if (r == 'done' || r == 'completed' || r == 'accepted') return 'done';
    if (r == 'rejected' || r == 'failed' || r == 'cancelled' || r == 'cancel') return 'rejected';
    return r;
  }

  static String _friendlyError(Object e) {
    if (isFrozenAccountError(e)) return frozenAccountMessage;
    final s = e.toString();
    if (s.contains('insufficient_funds')) return 'Insufficient balance for this send.';
    if (s.contains('min_order')) return 'Amount is below the minimum send for this currency.';
    if (s.contains('invalid_address')) return 'This address is not valid for the selected network.';
    if (s.contains('pin_invalid')) return 'Incorrect transaction PIN.';
    if (s.contains('user_not_provisioned')) {
      return 'Your crypto wallet is still being set up. Try again in a minute.';
    }
    // User-to-user send edge cases (backend maps these to InvalidArgument /
    // FailedPrecondition with clear messages).
    if (s.contains('yourself')) return "You can't send crypto to yourself.";
    if (s.contains("recipient isn't set up") ||
        s.contains('recipient_not_provisioned')) {
      return 'The recipient isn’t set up to receive crypto yet.';
    }
    // Server-authored guidance that should pass through VERBATIM — the saga
    // writes these as complete user-facing sentences (network gates, balance
    // + fee guard, daily cap, ambiguous-provider guidance).
    if (s.contains('you can send up to') ||
        s.contains('daily crypto limit') ||
        s.contains('choose the network') ||
        s.contains('not a supported network') ||
        s.contains('currently disabled') ||
        s.contains('check your send history')) {
      final m = RegExp(r'(?:message:|desc = )\s*(.+)$').firstMatch(s);
      if (m != null) return m.group(1)!.trim();
    }
    // Fallback: NEVER dump the raw gRPC/exception string. Route through the
    // shared sanitizer — clean validation messages (e.g. "minimum send is 0.9
    // USDT") pass through; technical text (distlock, INTERNAL, transport dumps)
    // collapses to a generic line.
    return friendlyError(e, context: 'complete your send');
  }
}
