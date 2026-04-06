import 'package:flutter/foundation.dart';

/// Enhanced visual feedback manager for voice session UI state synchronization.
///
/// Edge cases handled:
/// - Multiple dialogs preventing simultaneous display
/// - State transition validation (prevent invalid transitions)
/// - Dialog lifecycle management
/// - Visual feedback flag synchronization
/// - Rapid state change debouncing
/// - Dialog dismissal tracking
/// - State history for debugging
class VoiceVisualFeedbackManager {
  // Active dialog tracking
  _ActiveDialog? _activeDialog;

  // State transition history for debugging
  final List<_StateTransition> _stateHistory = [];
  static const int _maxHistorySize = 50;

  // Debouncing for rapid state changes
  DateTime? _lastStateChangeTime;
  static const Duration _stateChangeDebounce = Duration(milliseconds: 300);

  // Visual feedback flag
  bool _isVisualFeedbackActive = false;

  /// Request to show a dialog
  ///
  /// Returns true if dialog can be shown, false if another dialog is active
  bool requestDialog(_ActiveDialogType type, Map<String, dynamic> data) {
    // Edge case: Prevent multiple dialogs simultaneously
    if (_activeDialog != null) {
      print('VoiceVisualFeedbackManager: Dialog request denied - ${_activeDialog!.type} is already active');
      return false;
    }

    // Edge case: Debounce rapid state changes
    if (_shouldDebounceStateChange()) {
      print('VoiceVisualFeedbackManager: State change debounced');
      return false;
    }

    _activeDialog = _ActiveDialog(type: type, data: data, shownAt: DateTime.now());
    _isVisualFeedbackActive = true;

    _recordStateTransition('dialog_shown', type.toString());

    print('VoiceVisualFeedbackManager: Dialog shown - $type');
    return true;
  }

  /// Dismiss current dialog
  void dismissDialog(_ActiveDialogType type) {
    // Edge case: Only dismiss if it's the active dialog
    if (_activeDialog?.type == type) {
      _recordStateTransition('dialog_dismissed', type.toString());
      _activeDialog = null;

      // Edge case: Reset visual feedback flag after short delay
      // This prevents race conditions with rapid state changes
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_activeDialog == null) {
          _isVisualFeedbackActive = false;
        }
      });

      print('VoiceVisualFeedbackManager: Dialog dismissed - $type');
    } else {
      print('VoiceVisualFeedbackManager: Cannot dismiss dialog $type - active dialog is ${_activeDialog?.type}');
    }
  }

  /// Dismiss any active dialog (emergency cleanup)
  void dismissAnyDialog() {
    if (_activeDialog != null) {
      _recordStateTransition('dialog_dismissed_emergency', _activeDialog!.type.toString());
      print('VoiceVisualFeedbackManager: Emergency dialog dismissal - ${_activeDialog!.type}');
      _activeDialog = null;
      _isVisualFeedbackActive = false;
    }
  }

  /// Check if a specific dialog type is active
  bool isDialogActive(_ActiveDialogType type) {
    return _activeDialog?.type == type;
  }

  /// Check if any dialog is active
  bool get hasActiveDialog => _activeDialog != null;

  /// Get active dialog info
  _ActiveDialog? get activeDialog => _activeDialog;

  /// Check if visual feedback is currently active
  bool get isVisualFeedbackActive => _isVisualFeedbackActive;

  /// Validate state transition
  bool isValidTransition(String fromState, String toState) {
    // Edge case: Define invalid transitions
    final invalidTransitions = {
      'VoiceSessionPinRequired': ['VoiceSessionPinRequired'], // Can't transition to same state
      'VoiceSessionUserSearchRequired': ['VoiceSessionUserSearchRequired'],
      'VoiceSessionTransferConfirmation': ['VoiceSessionTransferConfirmation'],
    };

    final invalidForFromState = invalidTransitions[fromState];
    if (invalidForFromState != null && invalidForFromState!.contains(toState)) {
      print('VoiceVisualFeedbackManager: Invalid transition $fromState -> $toState');
      return false;
    }

    return true;
  }

  bool _shouldDebounceStateChange() {
    if (_lastStateChangeTime == null) return false;

    final timeSinceLastChange = DateTime.now().difference(_lastStateChangeTime!);
    if (timeSinceLastChange < _stateChangeDebounce) {
      return true;
    }

    return false;
  }

  void _recordStateTransition(String transition, String target) {
    _lastStateChangeTime = DateTime.now();

    _stateHistory.add(_StateTransition(
      timestamp: DateTime.now(),
      transition: transition,
      target: target,
      activeDialog: _activeDialog?.type.toString(),
    ));

    // Edge case: Prevent unbounded history growth
    if (_stateHistory.length > _maxHistorySize) {
      _stateHistory.removeAt(0);
    }
  }

  /// Get state transition history for debugging
  List<_StateTransition> getStateHistory() {
    return List.unmodifiable(_stateHistory);
  }

  /// Clear state history
  void clearHistory() {
    _stateHistory.clear();
  }

  /// Get current state as string for debugging
  String getCurrentStateDescription() {
    if (_activeDialog != null) {
      return 'Dialog: ${_activeDialog!.type} (shown at ${_activeDialog!.shownAt})';
    }
    return 'No active dialog';
  }
}

enum _ActiveDialogType {
  userSearch,
  transferConfirmation,
  pinEntry,
  transactionSuccess,
  transactionError,
}

class _ActiveDialog {
  final _ActiveDialogType type;
  final Map<String, dynamic> data;
  final DateTime shownAt;

  _ActiveDialog({
    required this.type,
    required this.data,
    required this.shownAt,
  });
}

class _StateTransition {
  final DateTime timestamp;
  final String transition;
  final String target;
  final String? activeDialog;

  _StateTransition({
    required this.timestamp,
    required this.transition,
    required this.target,
    this.activeDialog,
  });

  @override
  String toString() {
    return '$transition -> $target${activeDialog != null ? " (dialog: $activeDialog)" : ""}';
  }
}

/// Enhanced conversation state manager for handling complex state flows
class VoiceConversationStateManager {
  final VoiceVisualFeedbackManager _feedbackManager = VoiceVisualFeedbackManager();

  // Current conversation state
  String _currentState = 'initial';
  Map<String, dynamic> _currentStateData = {};

  // State change listeners
  final List<void Function(String, Map<String, dynamic>)> _stateListeners = [];

  /// Register listener for state changes
  void addStateListener(void Function(String, Map<String, dynamic>) listener) {
    _stateListeners.add(listener);
  }

  /// Remove state listener
  void removeStateListener(void Function(String, Map<String, dynamic>) listener) {
    _stateListeners.remove(listener);
  }

  /// Transition to new state with validation
  bool transitionTo(String newState, Map<String, dynamic> data) {
    // Edge case: Validate transition
    if (!_feedbackManager.isValidTransition(_currentState, newState)) {
      print('VoiceConversationStateManager: Invalid transition $_currentState -> $newState blocked');
      return false;
    }

    // Edge case: Handle dialog states specially
    if (_isDialogState(newState)) {
      final dialogType = _getDialogTypeForState(newState);
      if (!_feedbackManager.requestDialog(dialogType, data)) {
        print('VoiceConversationStateManager: Dialog $newState blocked - another dialog active');
        return false;
      }
    } else {
      // Edge case: Dismiss dialog if leaving dialog state
      if (_isDialogState(_currentState)) {
        final oldDialogType = _getDialogTypeForState(_currentState);
        _feedbackManager.dismissDialog(oldDialogType);
      }
    }

    // Update state
    final previousState = _currentState;
    _currentState = newState;
    _currentStateData = data;

    // Notify listeners
    for (final listener in _stateListeners) {
      try {
        listener(newState, data);
      } catch (e) {
        print('VoiceConversationStateManager: Error in state listener: $e');
      }
    }

    print('VoiceConversationStateManager: $previousState -> $newState');
    return true;
  }

  /// Force dismiss any active dialog (emergency cleanup)
  void forceDismissAllDialogs() {
    _feedbackManager.dismissAnyDialog();
  }

  /// Get current state
  String get currentState => _currentState;

  /// Get current state data
  Map<String, dynamic> get currentStateData => Map.unmodifiable(_currentStateData);

  /// Check if visual feedback is active
  bool get isVisualFeedbackActive => _feedbackManager.isVisualFeedbackActive;

  /// Check if specific dialog is active
  bool isDialogActive(String state) {
    if (!_isDialogState(state)) return false;
    final dialogType = _getDialogTypeForState(state);
    return _feedbackManager.isDialogActive(dialogType);
  }

  bool _isDialogState(String state) {
    return state.startsWith('VoiceSessionUserSearchRequired') ||
        state.startsWith('VoiceSessionTransferConfirmation') ||
        state.startsWith('VoiceSessionPinRequired') ||
        state.startsWith('VoiceSessionTransactionSuccess') ||
        state.startsWith('VoiceSessionTransactionError');
  }

  _ActiveDialogType _getDialogTypeForState(String state) {
    if (state.contains('UserSearchRequired')) return _ActiveDialogType.userSearch;
    if (state.contains('TransferConfirmation')) return _ActiveDialogType.transferConfirmation;
    if (state.contains('PinRequired')) return _ActiveDialogType.pinEntry;
    if (state.contains('TransactionSuccess')) return _ActiveDialogType.transactionSuccess;
    if (state.contains('TransactionError')) return _ActiveDialogType.transactionError;
    throw ArgumentError('Unknown dialog state: $state');
  }

  /// Get state history for debugging
  List<_StateTransition> getStateHistory() {
    return _feedbackManager.getStateHistory();
  }

  /// Get current state description
  String getStateDescription() {
    final dialogDesc = _feedbackManager.getCurrentStateDescription();
    return 'State: $_currentState, $dialogDesc';
  }
}
