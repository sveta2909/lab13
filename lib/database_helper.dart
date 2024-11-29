@@ -3,12 +3,11 @@ import 'package:path/path.dart';
import 'note_model.dart';

class DatabaseHelper {
static final DatabaseHelper _instance = DatabaseHelper._();
static Database? _database;
DatabaseHelper._();
static final DatabaseHelper _instance = DatabaseHelper._internal();
factory DatabaseHelper() => _instance;
DatabaseHelper._internal();
static Database? _database;

Future<Database> get database async {
if (_database != null) return _database!;
@@ -17,34 +16,37 @@ class DatabaseHelper {
}

Future<Database> _initDatabase() async {
final dbPath = await getDatabasesPath();
final path = join(dbPath, 'notes.db');
String path = join(await getDatabasesPath(), 'notes.db');
return await openDatabase(
path,
version: 1,
onCreate: (db, version) {
return db.execute(
'''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT NOT NULL,
            date TEXT NOT NULL
          )
          ''',
);
},
onCreate: _onCreate,
);
}

Future<void> _onCreate(Database db, int version) async {
await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT,
        date TEXT
      )
    ''');
}
Future<int> addNote(Note note) async {
final db = await database;
Database db = await database;
return await db.insert('notes', note.toMap());
}

Future<List<Note>> getNotes() async {
final db = await database;
final notes = await db.query('notes', orderBy: 'id DESC');
return notes.map((note) => Note.fromMap(note)).toList();
Database db = await database;
final List<Map<String, dynamic>> maps = await db.query(
'notes',
orderBy: 'id DESC',
);
return List.generate(maps.length, (i) {
return Note.fromMap(maps[i]);
});
}
}