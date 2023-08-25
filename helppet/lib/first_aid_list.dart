import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppet/first_aid_detail.dart';

import 'main.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Aidlist(
        pet: '',
      ),
    ),
  );
}

class Aidlist extends StatelessWidget {
  final String pet;

  const Aidlist({super.key, required this.pet});

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
      home: EmergencyListPage(
        pet: pet,
      ),
    );
  }
}

class EmergencyListPage extends StatefulWidget {
  final String pet;

  const EmergencyListPage({super.key, required this.pet});
  @override
  _EmergencyListPageState createState() => _EmergencyListPageState(pet);
}

class _EmergencyListPageState extends State<EmergencyListPage> {
  final String pet;
  String way = 'assets/data/dogs_aid.json';
  String titles = 'Primeiros socorros para cães';

  List<String> emergencyNames = [];
  Map<String, dynamic> data = {};

  _EmergencyListPageState(this.pet);

  @override
  void initState() {
    super.initState();
    _loadEmergencyData();
  }

  Future<void> _loadEmergencyData() async {
    if (pet == "cat") {
      way = 'assets/data/cats_aid.json';
      titles = 'Primeiros socorros para gatos';
    }

    String jsonString = await rootBundle.loadString(way);
    data = jsonDecode(jsonString);
    emergencyNames = data.keys.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Helppet())));
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
        title: Text(titles, style: const TextStyle(fontFamily: 'Montserrat',),),
      ),
      body: ListView.builder(
        itemCount: emergencyNames.length,
        itemBuilder: (context, index) {
          String name = emergencyNames[index];
          String image = data[name]["foto"];
          String emergency = data[name]["Emergência"];
          String more = data[name]["Cuidados adicionais"];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => EmergencyPage(
                                urlFoto: image,
                                titulo: name,
                                emergencia: emergency,
                                adicionais: more, pet: pet,
                              ))));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ), // Valor de arredondamento
                ),
                child: ListTile(
                    title: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Montserrat',
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
