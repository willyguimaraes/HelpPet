import 'package:flutter/material.dart';
import 'package:helppet/database/petDao.dart';
import 'package:helppet/models/pet_model.dart';

import '../monitoring_Forms/exam_form.dart';
import '../pet_details.dart';

class ExamPage extends StatefulWidget {
  final int petId;
  final Pet pet;

  const ExamPage({Key? key, required this.petId, required this.pet}) : super(key: key);

  @override
  _ExamPageState createState() => _ExamPageState(petId, pet);
}

class _ExamPageState extends State<ExamPage> {
  final _petDao = PetDao();
  final int petId;
    final Pet pet;


  List<Map<String, dynamic>> _examList = [];

  _ExamPageState(this.petId, this.pet);

  @override
  void initState() {
    super.initState();
    _loadExamsFromDatabase();
  }

  Future<void> _loadExamsFromDatabase() async {
    List<Map<String, dynamic>> exams =
        await _petDao.getByPetId(petId, 'exames');

    setState(() {
      _examList = exams;
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
            'Exames',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        body: _buildexamList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(91, 154, 139, 1.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ExamForm(
                          petId: petId, pet: pet,
                        ))));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildexamList() {
    if (_examList.isEmpty) {
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
                'Nenhuma Exame cadastrado.',
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
          itemCount: _examList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> exam = _examList[index];
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
                      exam['nome'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'Data do Exame: ${exam['data']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'Resultado: ${exam['resultado']}',
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
