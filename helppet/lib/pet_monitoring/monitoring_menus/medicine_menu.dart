import 'package:flutter/material.dart';
import 'package:helppet/database/petDao.dart';
import 'package:helppet/resister_page/pet_model.dart';

import '../monitoring_Forms/medicine_form.dart';
import '../pet_details.dart';

class MedicinePage extends StatefulWidget {
  final int petId;
  final Pet pet;

  const MedicinePage({Key? key, required this.petId, required this.pet}) : super(key: key);

  @override
  _MedicinePageState createState() => _MedicinePageState(petId, pet);
}

class _MedicinePageState extends State<MedicinePage> {
  final _petDao = PetDao();
  final int petId;
    final Pet pet;


  List<Map<String, dynamic>> _medicineList = [];

  _MedicinePageState(this.petId, this.pet);

  @override
  void initState() {
    super.initState();
    _loadmedicinesFromDatabase();
  }

  Future<void> _loadmedicinesFromDatabase() async {
    List<Map<String, dynamic>> medicines =
        await _petDao.getByPetId(petId, 'medicamentos');

    setState(() {
      _medicineList = medicines;
    });
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = ThemeData();
    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color.fromRGBO(91, 154, 139, 1.0),
          secondary: const Color.fromARGB(255, 0, 0, 0),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => PetDetailsPage(pet: pet, id: petId)),
                ),
              );
            },
            child: const Icon(Icons.arrow_back_sharp),
          ),
          title: const Text(
            'Medicamentos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        body: _buildmedicineList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(91, 154, 139, 1.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => MedicineForm(
                          petId: petId, pet: pet,
                        ))));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildmedicineList() {
    if (_medicineList.isEmpty) {
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_main.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(91, 154, 139, 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Nenhum Medicamento cadastrado.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
              )),
        ),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_main.jpg"),
                fit: BoxFit.cover)),
        child: ListView.builder(
          itemCount: _medicineList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> medicine = _medicineList[index];
            return Card(
              color: const Color.fromRGBO(91, 154, 139, 1.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      medicine['nome'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'Dosagem: ${medicine['dosagem']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'Horário: ${medicine['horario']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
