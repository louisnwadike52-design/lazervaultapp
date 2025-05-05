import 'package:lazervault/src/features/authentication/data/models/chat_message_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ChatDatabase {
  static final ChatDatabase instance = ChatDatabase._init();
  static Database? _database;

  ChatDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('chats.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS chats(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_from TEXT NOT NULL,
        user_to TEXT NOT NULL,
        message TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        reply_to_id INTEGER,
        message_type TEXT NOT NULL
      )
    ''');
  }

  Future<ChatMessageModel> create(ChatMessageModel chat) async {
    final db = await instance.database;
    final id = await db.insert('chats', chat.toMap());
    return chat.copyWith(id: id);
  }

  Future<List<ChatMessageModel>> getChatMessages(
      String userFrom, String userTo) async {
    final db = await instance.database;
    final result = await db.query(
      'chats',
      where:
          '(user_from = ? AND user_to = ?) OR (user_from = ? AND user_to = ?)',
      whereArgs: [userFrom, userTo, userTo, userFrom],
      orderBy: 'timestamp ASC',
    );

    return result.map((map) => ChatMessageModel.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> initialize() async {
    await database; // This will ensure the database is created
  }

  Future<ChatMessageModel?> getMessageById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'chats',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return ChatMessageModel.fromMap(result.first);
  }
}
