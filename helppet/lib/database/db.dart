import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
        proprietarioNome TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE vacinas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        data TEXT,
        reacao TEXT,
        petId INTEGER,
        FOREIGN KEY (petId) REFERENCES pets(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE medicamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        dosagem TEXT,
        horario TEXT,
        petId INTEGER,
        FOREIGN KEY (petId) REFERENCES pets(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE doencas_lesoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        data TEXT,
        tratamento TEXT,
        petId INTEGER,
        FOREIGN KEY (petId) REFERENCES pets(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE exames_procedimentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        data TEXT,
        resultado TEXT,
        petId INTEGER,
        FOREIGN KEY (petId) REFERENCES pets(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE consultas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT,
        tipo TEXT,
        petId INTEGER,
        FOREIGN KEY (petId) REFERENCES pets(id)
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getByPetId(int petId, String table) async {
    final db = await database;
    return await db.query(
      table,
      where: 'petId = ?',
      whereArgs: [petId],
    );
  }
}
