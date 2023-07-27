import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
   const MaterialApp(
    home: Aidlist(),
    ),
  );
}

class Aidlist extends StatelessWidget {
  const Aidlist({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: const Color.fromRGBO(255, 247, 170, 0.861),
          secondary: Color.fromARGB(255, 8, 8, 8),
          background: const Color.fromRGBO(170, 178, 255, 1),
        ),
      ),
      home: EmergencyListPage(),
    );
  }
}

class EmergencyListPage extends StatefulWidget {
  @override
  _EmergencyListPageState createState() => _EmergencyListPageState();
}

class _EmergencyListPageState extends State<EmergencyListPage> {
  List<String> emergencyNames = [];

  @override
  void initState() {
    super.initState();
    _loadEmergencyData();
  }

  Future<void> _loadEmergencyData() async {
    String jsonString =
        await rootBundle.loadString('assets/images/data/dogs_aid.json');
    Map<String, dynamic> data = jsonDecode(jsonString);
    emergencyNames = data.keys.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Primeiros socorros para cães'),
      ),
      body: ListView.builder(
        itemCount: emergencyNames.length,
        itemBuilder: (context, index) {
          String name = emergencyNames[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Handle the button click here
                  print('$name button clicked!');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ), // Valor de arredondamento
                ),
                child: ListTile(
                  title: Text(name),
                ),
              ),
              
              
            ),
          );
        },
      ),
    );
  }
}
