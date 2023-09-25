import 'package:flutter/material.dart';

import '../components/pet_buttons.dart';
import 'Pet_form.dart';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Column(children: [
                  PetButton(
                    imagePath: 'assets/images/addpet.png',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  PetFormPage())));
                    },
                    buttonText: '  Cadastrar pet',
                    
                  ),
                  const SizedBox(height: 20),
                  PetButton(
                    imagePath: 'assets/images/listpet.png',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  PetFormPage())));
                    },
                    buttonText: '  Listar pets',
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
