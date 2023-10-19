import 'package:flutter/material.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/medicine_menu.dart';

import '../../database/petDao.dart';
import 'package:helppet/resister_page/pet_model.dart';

class MedicineForm extends StatelessWidget {
  final int petId; 
  final Pet pet;
  const MedicineForm({super.key, required this.petId, required this.pet});

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
      home: MedicineFormPage(
        id: petId, pet: pet,
      ),
    );
  }
}

class MedicineFormPage extends StatefulWidget {
  final int id;
  final Pet pet;
  const MedicineFormPage({Key? key, required this.id, required this.pet});

  @override
  _MedicineFormPageState createState() => _MedicineFormPageState(petId: id, pet: pet, );
}

const TextStyle customTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Montserrat',
);

class _MedicineFormPageState extends State<MedicineFormPage>
    with AutomaticKeepAliveClientMixin<MedicineFormPage> {
  final _formKey = GlobalKey<FormState>();

  int petId; 
  final Pet pet;

  _MedicineFormPageState({required this.pet, required this.petId});

  @override
  bool get wantKeepAlive => true;

  String nome = "";
  String dosagem = "";
  String horario = "";

  final _petDao = PetDao();

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
                    builder: ((context) => MedicinePage(
                          petId: petId, pet: pet,
                        ))));
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text(
          "Cadastro de Medicamentos",
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
                      labelText: 'Nome do Medicamento',
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
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextFormField(
                    style: customTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Dosagem',
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
                      dosagem = value!;
                    },
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
                      labelText: 'Horário',
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
                      horario = value!;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Medicamento novoMedicamento = Medicamento(
                        nome: nome,
                        dosagem: dosagem,
                        horario: horario,
                      );

                      await _petDao.insertMedicamento(petId, novoMedicamento);

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
                                'Medicamento Registrado',
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
                                            builder: ((context) => MedicinePage(
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
                      'Registrar Medicamento',
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
