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
          primary: const Color.fromRGBO(91, 154, 139, 1.0),
          secondary: const Color.fromARGB(255, 0, 0, 0),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(37, 43, 72, 1),
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.6,
          leading: Image.asset('assets/images/logo.png',
              fit: BoxFit.cover, alignment: Alignment.centerLeft),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background_main.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(
                        37, 43, 72, 1), // Cor do fundo
                    borderRadius:
                        BorderRadius.circular(10), // Bordas arredondadas
                  ),
                  padding: const EdgeInsets.all(20), // Espaçamento interno
                  child: const Text(
                    'Selecione o pet:',
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Column(children: [
                  PetButton(
                    imagePath: 'assets/images/pet1.png',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const Aidlist(pet: 'dog'))));
                    },
                    buttonText: 'Cães',
                    

                  ),
                  const SizedBox(height: 20),
                  PetButton(
                    imagePath: 'assets/images/pet2.png',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const Aidlist(pet: 'cat'))));
                    },
                    buttonText: 'Gatos',
                  ),
                ]),
                const SizedBox(height: 20),
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
      ),
    );
  }
}
