import 'package:flutter/material.dart';
import 'package:helppet/database/petDao.dart';
import 'package:helppet/resister_page/pet_model.dart';


import '../monitoring_Forms/consutation_form.dart';
import '../pet_details.dart';

class ConsultationPage extends StatefulWidget {
  final int petId;
  final Pet pet;

  const ConsultationPage({Key? key, required this.petId, required this.pet}) : super(key: key);

  @override
  _ConsultationPageState createState() => _ConsultationPageState(petId, pet);
}

class _ConsultationPageState extends State<ConsultationPage> {
  final _petDao = PetDao();
  final int petId;
    final Pet pet;


  List<Map<String, dynamic>> _consultationList = [];

  _ConsultationPageState(this.petId, this.pet);

  @override
  void initState() {
    super.initState();
    _loadConsultationsFromDatabase();
  }

  Future<void> _loadConsultationsFromDatabase() async {
    List<Map<String, dynamic>> consultations =
        await _petDao.getByPetId(petId, 'consultas');

    setState(() {
      _consultationList = consultations;
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
            'Consultas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        body: _buildconsultationList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(91, 154, 139, 1.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ConsultationForm(
                          petId: petId, pet: pet,
                        ))));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildconsultationList() {
    if (_consultationList.isEmpty) {
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
                'Nenhuma Consulta cadastrada.',
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
          itemCount: _consultationList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> consultation = _consultationList[index];
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
                      'Data da consulta: ${consultation['data']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'Tipo da consulta: ${consultation['tipo']}',
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
