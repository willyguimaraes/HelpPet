import 'package:flutter/material.dart';
import 'components/map_utils.dart';
import 'components/pet_buttons.dart';
import 'components/vet_Button.dart';
import 'first_aid_list.dart';

void main() {
  runApp(
   MaterialApp(
    home: Helppet(),
    ),
  );
}

class Helppet extends StatelessWidget {
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
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.6,
          leading: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor:
            const Color.fromRGBO(170, 178, 255, 1), // Definir a cor de fundo
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Selecione o pet:',
                style: TextStyle(fontSize: 34),
              ),
              const SizedBox(height: 20),
              // Utilize a Column para agrupar os PetButtons um abaixo do outro
              Column(
                children: [
                  PetButton(
                    imagePath: 'assets/images/pet1.png',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => const Aidlist())));
                    },
                    buttonText: 'Cães',
                  ),
                  const SizedBox(height: 20),
                  PetButton(
                    imagePath: 'assets/images/pet2.png',
                    onPressed: () {
                      // Ação do botão 2
                    },
                    buttonText: 'Gatos',
                  ),
                ],
              ),
              // ...

              const SizedBox(height: 20),

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
