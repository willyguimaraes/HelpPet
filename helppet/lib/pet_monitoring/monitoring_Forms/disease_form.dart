import 'package:flutter/material.dart';
import 'package:helppet/models/disease_model.dart';
import 'package:helppet/models/pet_model.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/disease_menu.dart';
import 'package:intl/intl.dart';

import '../../database/petDao.dart';



class DiseaseForm extends StatelessWidget {
  final int petId;
  final Pet pet;
  const DiseaseForm({super.key,required this.pet, required this.petId, });

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
      home: DiseaseFormPage(
        id: petId, pet: pet,
      ),
    );
  }
}

class DiseaseFormPage extends StatefulWidget {
  final int id;
  final Pet pet;
  const DiseaseFormPage({Key? key, required this.id, required this.pet});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _DiseaseFormPageState createState() => _DiseaseFormPageState(petId: id, pet: pet);
}

const TextStyle customTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Montserrat',
);

class _DiseaseFormPageState extends State<DiseaseFormPage>
    with AutomaticKeepAliveClientMixin<DiseaseFormPage> {
  final _formKey = GlobalKey<FormState>();

  int petId;
  final Pet pet;

  _DiseaseFormPageState({required this.pet, required this.petId});

  @override
  bool get wantKeepAlive => true;

  String nome = "";
  String data = "";
  String tratamento = "";

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
                    builder: ((context) => DiseasePage(
                          petId: petId, pet: pet,
                        ))));
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text(
          "Historico de Doenças",
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
                      labelText: 'Doença',
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
                      'Data',
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
                      labelText: 'Tratamento',
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
                      tratamento = value!;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Doenca novaDoenca = Doenca(
                          nome: nome, data: data, tratamento: tratamento);

                      await _petDao.insertDoenca(petId, novaDoenca);

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
                                'Doença Registrada',
                                style: customTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                "$nome registrada com sucesso!",
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
                                            builder: ((context) => DiseasePage(
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
                      'Registrar Doença',
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
