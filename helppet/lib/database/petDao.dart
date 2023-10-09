import 'package:sqflite/sqflite.dart';
import '../resister_page/pet_model.dart';
import 'db.dart';

class PetDao {
  DBPet dbPet = DBPet.instance;
  
  Future<int> insertPet(Pet pet) async {
    Database db = await dbPet.database;
    return await db.insert('pets', pet.toMap());
  }

  Future<List<Pet>> getAllPets() async {
    Database db = await dbPet.database;
    List<Map<String, dynamic>> maps = await db.query('pets');

    return List.generate(maps.length, (index) {
      return Pet.fromMap(maps[index]);
    });
  }

  Future<String?> getImagePath(int petId) async {
    Database db = await dbPet.database;
    List<Map<String, dynamic>> result = await db.query('pets',
        columns: ['imagePath'],
        where: 'id = ?',
        whereArgs: [petId]);

    if (result.isNotEmpty) {
      return result[0]['imagePath'] as String?;
    } else {
      return null;
    }
  }
}
