import 'package:sqflite/sqflite.dart';
import 'package:helppet/resister_page/pet_model.dart';
import 'db.dart';

class PetDao {
  DBPet dbPet = DBPet.instance;


  Future<int> insertPet(Pet pet) async {
    Database db = await dbPet.database;
    return await db.insert('pets', pet.toMap());
  }

  Future<List<int>> getAllPetIds() async {
    Database db = await dbPet.database;

    List<Map<String, dynamic>> result = await db.query('pets', columns: ['id']);

    return List<int>.from(result.map((map) => map['id']));
  }

  Future<Pet?> getPetById(int petId) async {
    Database db = await dbPet.database;

    List<Map<String, dynamic>> result = await db.query(
      'pets',
      where: 'id = ?',
      whereArgs: [petId],
    );

    if (result.isNotEmpty) {
      return Pet.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<Map<int, Pet>> getAllPets() async {
    Database db = await dbPet.database;
    List<Map<String, dynamic>> maps = await db.query('pets');
    if (maps.isEmpty) {
      return Map<int, Pet>();
    } else {
      return {for (var map in maps) map['id']: Pet.fromMap(map)};
    }
  }

  Future<int> insertVacina(int petId, Vacina vacina) async {
    Database db = await dbPet.database;
    return await db.insert('vacinas', vacina.toMap(petId));
  }

  Future<int> insertMedicamento(int petId, Medicamento medicamento) async {
    Database db = await dbPet.database;
    return await db.insert('medicamentos', medicamento.toMap(petId));
  }

  Future<int> insertDoenca(int petId, Doenca doenca) async {
    Database db = await dbPet.database;
    return await db.insert('doencas', doenca.toMap(petId));
  }

  Future<int> insertexame(int petId, Exame exame) async {
    Database db = await dbPet.database;
    return await db.insert('exames', exame.toMap(petId));
  }

  Future<int> insertconsulta(int petId, Consulta consulta) async {
    Database db = await dbPet.database;
    return await db.insert('consultas', consulta.toMap(petId));
  }

  Future<List<Map<String, dynamic>>> getByPetId(int petId, String table) async {
    return await dbPet.getByPetId(petId, table);
  }
}
