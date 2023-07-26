import 'package:flutter/material.dart';
import 'components/map_utils.dart';
import 'components/pet_buttons.dart';
import 'components/vet_Button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Color.fromRGBO(255, 247, 170, 0.861),
          secondary: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.6,
          leading: Container(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Selecione o pet:',
                style: TextStyle(fontSize: 34),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PetButton(
                    imagePath: 'assets/images/pet1.png',
                    onPressed: () {
                      // Ação do botão 1
                    },
                  ),
                  SizedBox(width: 20),
                  PetButton(
                    imagePath: 'assets/images/pet2.png',
                    onPressed: () {
                      // Ação do botão 2
                    },
                  ),
                ],
              ),
              // ...

              SizedBox(height: 20),

// Botão para pesquisar veterinários próximos no Google Maps
              VetButton(
                buttonText: 'Encontrar Veterinários',
                onPressed: () {
                  openMapsForVeterinarians();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
