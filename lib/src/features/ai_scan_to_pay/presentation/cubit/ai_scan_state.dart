import 'package:equatable/equatable.dart';
import '../../domain/entities/scan_entities.dart';

abstract class AiScanState extends Equatable {
  const AiScanState();

  @override
  List<Object?> get props => [];
}

// Initial state
class AiScanInitial extends AiScanState {}

// Loading states
class AiScanLoading extends AiScanState {
  final String? message;

  const AiScanLoading({this.message});

  @override
  List<Object?> get props => [message];
}

// Scan type selection state
class AiScanTypeSelection extends AiScanState {
  final List<ScanType> availableTypes;

  const AiScanTypeSelection(this.availableTypes);

  @override
  List<Object?> get props => [availableTypes];
}

// Scan session active state
class AiScanSessionActive extends AiScanState {
  final ScanSession session;
  final List<AiChatMessage> chatHistory;
  final bool isProcessing;
  final Map<String, dynamic>? extractedData;

  const AiScanSessionActive({
    required this.session,
    required this.chatHistory,
    this.isProcessing = false,
    this.extractedData,
  });

  @override
  List<Object?> get props => [session, chatHistory, isProcessing, extractedData];

  AiScanSessionActive copyWith({
    ScanSession? session,
    List<AiChatMessage>? chatHistory,
    bool? isProcessing,
    Map<String, dynamic>? extractedData,
  }) {
    return AiScanSessionActive(
      session: session ?? this.session,
      chatHistory: chatHistory ?? this.chatHistory,
      isProcessing: isProcessing ?? this.isProcessing,
      extractedData: extractedData ?? this.extractedData,
    );
  }
}

// Camera/scanning state
class AiScanCamera extends AiScanState {
  final ScanSession session;
  final bool isCapturing;

  const AiScanCamera({
    required this.session,
    this.isCapturing = false,
  });

  @override
  List<Object?> get props => [session, isCapturing];

  AiScanCamera copyWith({
    ScanSession? session,
    bool? isCapturing,
  }) {
    return AiScanCamera(
      session: session ?? this.session,
      isCapturing: isCapturing ?? this.isCapturing,
    );
  }
}

// Image processing state
class AiScanProcessing extends AiScanState {
  final ScanSession session;
  final String status;
  final double? progress;

  const AiScanProcessing({
    required this.session,
    required this.status,
    this.progress,
  });

  @override
  List<Object?> get props => [session, status, progress];
}

// Chat state
class AiScanChatActive extends AiScanState {
  final ScanSession session;
  final List<AiChatMessage> messages;
  final bool isTyping;
  final Map<String, dynamic>? extractedData;

  const AiScanChatActive({
    required this.session,
    required this.messages,
    this.isTyping = false,
    this.extractedData,
  });

  @override
  List<Object?> get props => [session, messages, isTyping, extractedData];

  AiScanChatActive copyWith({
    ScanSession? session,
    List<AiChatMessage>? messages,
    bool? isTyping,
    Map<String, dynamic>? extractedData,
  }) {
    return AiScanChatActive(
      session: session ?? this.session,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      extractedData: extractedData ?? this.extractedData,
    );
  }
}

// Payment processing state
class AiScanPaymentProcessing extends AiScanState {
  final PaymentInstruction instruction;
  final String status;

  const AiScanPaymentProcessing({
    required this.instruction,
    required this.status,
  });

  @override
  List<Object?> get props => [instruction, status];
}

// Payment success state
class AiScanPaymentSuccess extends AiScanState {
  final PaymentInstruction instruction;
  final String transactionId;

  const AiScanPaymentSuccess({
    required this.instruction,
    required this.transactionId,
  });

  @override
  List<Object?> get props => [instruction, transactionId];
}

// Scan history state
class AiScanHistoryLoaded extends AiScanState {
  final List<ScanSession> sessions;

  const AiScanHistoryLoaded(this.sessions);

  @override
  List<Object?> get props => [sessions];
}

// Error state
class AiScanError extends AiScanState {
  final String message;
  final String? details;

  const AiScanError({
    required this.message,
    this.details,
  });

  @override
  List<Object?> get props => [message, details];
} 