import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Local cache data source for transaction history
/// Uses SQLite for offline-first caching
class TransactionHistoryCacheDataSource {
  static final TransactionHistoryCacheDataSource _instance =
      TransactionHistoryCacheDataSource._internal();
  factory TransactionHistoryCacheDataSource() => _instance;
  TransactionHistoryCacheDataSource._internal();

  Database? _database;
  final String _databaseName = 'transaction_history.db';
  final int _databaseVersion = 1;

  // Table name
  static const String _tableTransactions = 'cached_transactions';

  /// Initialize database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableTransactions (
        id TEXT PRIMARY KEY,
        service_type INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        amount REAL NOT NULL,
        currency TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        status INTEGER NOT NULL,
        flow INTEGER NOT NULL,
        transaction_reference TEXT,
        metadata TEXT,
        user_id TEXT NOT NULL,
        cached_at INTEGER NOT NULL,
        expires_at INTEGER NOT NULL
      )
    ''');

    // Create indexes for performance
    await db.execute('''
      CREATE INDEX idx_user_service ON $_tableTransactions(user_id, service_type)
    ''');
    await db.execute('''
      CREATE INDEX idx_user_status ON $_tableTransactions(user_id, status)
    ''');
    await db.execute('''
      CREATE INDEX idx_user_created ON $_tableTransactions(user_id, created_at)
    ''');
    await db.execute('''
      CREATE INDEX idx_expires ON $_tableTransactions(expires_at)
    ''');
  }

  /// Upgrade database
  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Handle database upgrades
    if (oldVersion < 2) {
      // Add new columns or tables
    }
  }

  /// Cache transactions
  Future<void> cacheTransactions(
    String userId,
    List<UnifiedTransaction> transactions,
    Duration ttl,
  ) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final expiresAt = now + ttl.inMilliseconds;

    final batch = db.batch();

    for (final transaction in transactions) {
      batch.insert(
        _tableTransactions,
        _transactionToMap(
          transaction,
          userId,
          now,
          expiresAt,
        ),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  /// Get cached transactions
  Future<List<UnifiedTransaction>> getCachedTransactions({
    required String userId,
    TransactionServiceType? serviceType,
    int limit = 50,
  }) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;

    String query = '''
      SELECT * FROM $_tableTransactions
      WHERE user_id = ? AND expires_at > ?
    ''';

    final args = [userId, now];

    if (serviceType != null) {
      query += ' AND service_type = ?';
      args.add(serviceType.index);
    }

    query += ' ORDER BY created_at DESC LIMIT ?';
    args.add(limit);

    final maps = await db.rawQuery(query, args);

    return maps.map((map) => _mapToTransaction(map)).toList();
  }

  /// Get single cached transaction
  Future<UnifiedTransaction?> getCachedTransaction(String id) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;

    final maps = await db.query(
      _tableTransactions,
      where: 'id = ? AND expires_at > ?',
      whereArgs: [id, now],
    );

    if (maps.isEmpty) return null;

    return _mapToTransaction(maps.first);
  }

  /// Clear expired transactions
  Future<void> clearExpiredTransactions() async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.delete(
      _tableTransactions,
      where: 'expires_at <= ?',
      whereArgs: [now],
    );
  }

  /// Clear all cached transactions for a user
  Future<void> clearUserTransactions(String userId) async {
    final db = await database;

    await db.delete(
      _tableTransactions,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  /// Delete specific transaction from cache
  Future<void> deleteTransaction(String id) async {
    final db = await database;

    await db.delete(
      _tableTransactions,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get cache size
  Future<int> getCacheSize() async {
    final db = await database;

    final result = await db.rawQuery(
      "SELECT COUNT(*) as count FROM $_tableTransactions",
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Clear all cache (use with caution)
  Future<void> clearAllCache() async {
    final db = await database;

    await db.delete(_tableTransactions);
  }

  /// Convert UnifiedTransaction to Map
  Map<String, dynamic> _transactionToMap(
    UnifiedTransaction tx,
    String userId,
    int cachedAt,
    int expiresAt,
  ) {
    return {
      'id': tx.id,
      'service_type': tx.serviceType.index,
      'title': tx.title,
      'description': tx.description,
      'amount': tx.amount,
      'currency': tx.currency,
      'created_at': tx.createdAt.toIso8601String(),
      'updated_at': tx.createdAt.toIso8601String(),
      'status': tx.status.index,
      'flow': tx.flow.index,
      'transaction_reference': tx.transactionReference,
      'metadata': tx.metadata != null ? jsonEncode(tx.metadata) : null,
      'user_id': userId,
      'cached_at': cachedAt,
      'expires_at': expiresAt,
    };
  }

  /// Convert Map to UnifiedTransaction
  UnifiedTransaction _mapToTransaction(Map<String, dynamic> map) {
    final serviceType = TransactionServiceType.values[map['service_type'] as int];
    final status = UnifiedTransactionStatus.values[map['status'] as int];
    final flow = TransactionFlow.values[map['flow'] as int];

    // Parse metadata
    Map<String, dynamic>? metadata;
    if (map['metadata'] != null && map['metadata'] is String) {
      try {
        final decoded = jsonDecode(map['metadata'] as String);
        if (decoded is Map) {
          metadata = Map<String, dynamic>.from(decoded);
        }
      } catch (_) {
        // Malformed JSON, skip metadata
      }
    }

    return UnifiedTransaction(
      id: map['id'] as String,
      serviceType: serviceType,
      title: map['title'] as String,
      description: map['description'] as String?,
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      status: status,
      flow: flow,
      transactionReference: map['transaction_reference'] as String?,
      metadata: metadata,
    );
  }

  /// Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
