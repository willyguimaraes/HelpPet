
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../resister_page/pet_model.dart';

class DBPet {
  static Database? _database;
  static final DBPet instance = DBPet._privateConstructor();

  DBPet._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'pets.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagem TEXT,
        nome TEXT,
        especie TEXT,
        raca TEXT,
        cor TEXT,
        dataNascimento TEXT,
        proprietarioNome TEXT,
        proprietarioEndereco TEXT,
        proprietarioTelefone TEXT,
        proprietarioEmail TEXT
      )
    ''');
  }

  

 

}
