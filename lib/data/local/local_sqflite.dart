import 'dart:developer';

import 'package:path/path.dart';
import 'package:sq_flite_package_grid_wiev/data/local/model/notes_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._init();

  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB("notes_db");
      return _database;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db?.insert(NoteFields.tableName, note.toJson());
    return note.copyWith(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final maps = await db?.query(
      NoteFields.tableName,
      columns: NoteFields.value,
      where: "${NoteFields.id} = ?",
      whereArgs: [id],
    );
    if (maps!.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw ("id $id not found");
    }
  }

  Future<List<Note>> readAll() async {
    final db = await instance.database;
    final orderBy = "${NoteFields.time} ASC";
    final result = await db?.query(NoteFields.tableName, orderBy: orderBy);
    return result!.map((e) => Note.fromJson(e)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    return db!.update(NoteFields.tableName, note.toJson(),
        where: "${NoteFields.id} ?", whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db!.delete(NoteFields.tableName,
        where: "${NoteFields.id} ?", whereArgs: [id]);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCRAMENT";
    const textType = "TEXT NOT NULL";
    const boolType = "BOOLEN NOT NULL";
    const integerType = "INTEGER NOT NULL";
    db.execute("""
    CREATE tABLE ${NoteFields.tableName}(
      ${NoteFields.id} $idType,
      ${NoteFields.isImportant} $boolType,
      ${NoteFields.number} $integerType,
      ${NoteFields.title} $textType,
      ${NoteFields.description} $textType,
      ${NoteFields.time} $textType
    )
    """);
  }

  Future close() async {
    final db = await instance.database;

    db?.close();
  }
}
