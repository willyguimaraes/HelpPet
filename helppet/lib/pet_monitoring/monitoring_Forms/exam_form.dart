import 'package:flutter/material.dart';
import 'package:helppet/models/exam_model.dart';
import 'package:helppet/models/pet_model.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/exam_menu.dart';
import 'package:intl/intl.dart';

import '../../database/petDao.dart';

class ExamForm extends StatelessWidget {
  final int petId;
  final Pet pet;
  const ExamForm({super.key, required this.petId, required this.pet});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Color.fromRGBO(91, 154, 139, 1.0),
          secondary: Color.fromARGB(255, 0, 0, 0),
          background: Color.fromRGBO(37, 43, 72, 1.0),
        ),
      ),
      home: ExamFormPage(
        id: petId, pet: pet,
      ),
    );
  }
}

class ExamFormPage extends StatefulWidget {
  final int id;
  final Pet pet;
  const ExamFormPage({Key? key, required this.id, required this.pet});

  @override
  _ExamFormPageState createState() => _ExamFormPageState(petId: id, pet: pet);
}

const TextStyle customTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Montserrat',
);

class _ExamFormPageState extends State<ExamFormPage>
    with AutomaticKeepAliveClientMixin<ExamFormPage> {
  final _formKey = GlobalKey<FormState>();

  int petId;
  final Pet pet;

  _ExamFormPageState({required this.pet, required this.petId});

  @override
  bool get wantKeepAlive => true;

  String nome = "";
  String data = "";
  String resultado = "";

  DateTime? selectedDate;

  final _petDao = PetDao();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != selectedDate)
      setState(() {
        selectedDate = picked;
        data = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ExamPage(
                          petId: petId, pet: pet,
                        ))));
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text(
          "Historico de Exames",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextFormField(
                    style: customTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Exame',
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (states) => customTextStyle),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nome = value!;
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text(
                      'Data do Exame',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      selectedDate == null
                          ? 'Selecione a data'
                          : DateFormat('dd/MM/yyyy').format(selectedDate!),
                      style: const TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextFormField(
                    style: customTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Resultados',
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (states) => customTextStyle),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      resultado = value!;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Exame novoExame =
                          Exame(nome: nome, data: data, resultado: resultado);

                      await _petDao.insertexame(petId, novoExame);

                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: AlertDialog(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              title: const Text(
                                'Exame Registrado',
                                style: customTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                "$nome registrado com sucesso!",
                                style: customTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => ExamPage(
                                                  petId: petId, pet: pet,
                                                ))));
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      'Registrar Exame',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
