import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert a note
  static Future<void> insertNote(String title) async {
    final db = await getDatabase();
    await db.insert('notes', {'title': title});
  }

  // Get all notes
  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await getDatabase();
    return db.query('notes');
  }

  // Delete a note
  static Future<void> deleteNote(int id) async {
    final db = await getDatabase();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}