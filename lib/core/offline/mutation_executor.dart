import 'mutation.dart';
import 'mutation_queue.dart';

/// Executes queued mutations using registered handlers.
///
/// This class connects the MutationQueue to actual repository methods.
/// Each mutation type has a registered handler that knows how to
/// process that specific type of mutation.
///
/// Usage in DI setup:
/// ```dart
/// serviceLocator.registerLazySingleton<MutationExecutor>(() {
///   final executor = MutationExecutor(
///     mutationQueue: serviceLocator<MutationQueue>(),
///   );
///
///   // Register handlers
///   executor.registerHandler(
///     MutationType.tagPayment,
///     (mutation) => serviceLocator<TagPayRepository>().payTag(
///       tagId: mutation.payload['tagId'],
///       sourceAccountId: mutation.payload['sourceAccountId'],
///       transactionPin: mutation.payload['transactionPin'],
///     ),
///   );
///
///   return executor;
/// });
/// ```
class MutationExecutor {
  /// The mutation queue to process.
  final MutationQueue _mutationQueue;

  /// Registered handlers for each mutation type.
  final Map<MutationType, Future<void> Function(QueuedMutation)> _handlers = {};

  /// Callback for successful mutation execution.
  void Function(QueuedMutation mutation, dynamic result)? onSuccess;

  /// Callback for failed mutation execution.
  void Function(QueuedMutation mutation, Object error)? onError;

  MutationExecutor({
    required MutationQueue mutationQueue,
  }) : _mutationQueue = mutationQueue {
    // Wire up the queue processor
    _mutationQueue.onProcess = _processMutation;
  }

  /// Registers a handler for a specific mutation type.
  ///
  /// The handler receives the mutation and should execute the
  /// corresponding repository method.
  void registerHandler(
    MutationType type,
    Future<void> Function(QueuedMutation mutation) handler,
  ) {
    _handlers[type] = handler;
    print('[MutationExecutor] Registered handler for ${type.name}');
  }

  /// Removes a handler for a mutation type.
  void unregisterHandler(MutationType type) {
    _handlers.remove(type);
  }

  /// Processes a single mutation by delegating to its registered handler.
  Future<void> _processMutation(QueuedMutation mutation) async {
    final handler = _handlers[mutation.type];

    if (handler == null) {
      throw Exception('No handler registered for mutation type: ${mutation.type.name}');
    }

    print('[MutationExecutor] Processing ${mutation.type.name} (${mutation.id})');

    try {
      await handler(mutation);
      print('[MutationExecutor] Success: ${mutation.id}');
      onSuccess?.call(mutation, null);
    } catch (e) {
      print('[MutationExecutor] Error processing ${mutation.id}: $e');
      onError?.call(mutation, e);
      rethrow;
    }
  }

  /// Checks if a handler is registered for a mutation type.
  bool hasHandler(MutationType type) => _handlers.containsKey(type);

  /// Gets all registered mutation types.
  Set<MutationType> get registeredTypes => _handlers.keys.toSet();

  /// Initializes the executor and the mutation queue.
  Future<void> initialize() async {
    await _mutationQueue.initialize();
    print('[MutationExecutor] Initialized with ${_handlers.length} handlers');
  }

  /// Disposes of resources.
  Future<void> dispose() async {
    await _mutationQueue.dispose();
  }
}
