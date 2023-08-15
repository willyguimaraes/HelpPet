import 'package:flutter/material.dart';

import 'components/map_utils.dart';
import 'components/vet_Button.dart';
import 'first_aid_list.dart';

class EmergencyPage extends StatelessWidget {
  final String urlFoto;
  final String titulo;
  final String emergencia;
  final String adicionais;
  final String pet;

  EmergencyPage({
    required this.urlFoto,
    required this.titulo,
    required this.emergencia,
    required this.adicionais,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Color.fromRGBO(91, 154, 139, 1.0),
          secondary: Color.fromARGB(255, 255, 255, 255),
          background: Color.fromRGBO(37, 43, 72, 1.0),
        ),
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(198, 255, 255, 255),
        appBar: AppBar(
          title: Text(titulo),
          leading: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Aidlist(
                            pet: pet,
                          ))));
            },
            child: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      urlFoto,
                      height: 250, // Altura da imagem
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "O que fazer:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: emergencia.split('.').map((item) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${emergencia.split('.').indexOf(item) + 1} - ",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    item.trim(),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Informações adicionais:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        adicionais,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: VetButton(
                buttonText: 'Encontrar Veterinários',
                onPressed: () {
                  openMapsForVeterinarians();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EmergencyPage(
      urlFoto: '',
      titulo: '',
      emergencia: '',
      adicionais: '',
      pet: '',
    ),
  ));
}
