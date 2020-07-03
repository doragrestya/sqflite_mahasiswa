import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflitemahasiswa/model/model_mahasiswa.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  //DEKLARASI TABLE DAN FIELD
  final String tableMahasiswa = 'noteTable';
  final String columnId = 'id';
  final String columnFirstName = 'firstname';
  final String columnLastName = 'lastname';
  final String columnNim = 'nim';
  final String columnJurusan = 'jurusan';
  final String columnProdi = 'prodi';
  final String columnEmail = 'email';

  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mahasiswa.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  //CREATE TABLE
  void _onCreate(Database db, int NewVersion) async {
    await db.execute(
        'CREATE TABLE $tableMahasiswa($columnId INTEGER PRIMARY KEY, $columnFirstName TEXT, $columnLastName TEXT, $columnNim TEXT, $columnJurusan TEXT, $columnProdi TEXT, $columnEmail TEXT)');
  }

  //save
  Future<int> saveMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableMahasiswa, mahasiswa.toMap());
    return result;
  }

  //get all mahasiswa
  Future<List> getAllMahasiswa() async {
    var dbClient = await db;
    var result = await dbClient.query(tableMahasiswa, columns: [
      columnId,
      columnFirstName,
      columnLastName,
      columnNim,
      columnJurusan,
      columnProdi,
      columnEmail
    ]);
    return result.toList();
  }

  //update
  Future<int> updateMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await db;
    return await dbClient.update(tableMahasiswa, mahasiswa.toMap(),
        where: "$columnId = ?", whereArgs: [mahasiswa.id]);
  }

  //delete
  Future<int> deleteMahasiswa(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableMahasiswa, where: "$columnId = ?", whereArgs: [id]);
  }
}
