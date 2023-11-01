import 'package:flutter/material.dart';
import 'package:helppet/models/pet_model.dart';


import '../components/pet_buttons.dart';
import '../database/petDao.dart';
import '../main.dart';
import 'pet_form.dart';

import 'pets_list.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Helppetcadastro(),
    ),
  );
}

class Helppetcadastro extends StatelessWidget {
  const Helppetcadastro({super.key});

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
          leading: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Helppet())));
            },
            child: const Icon(Icons.arrow_back_sharp),
          ),
          title: const Text(
            "Meus Pets",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Montserrat',
            ),
          ),
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
                              builder: ((context) => const PetForm())));
                    },
                    buttonText: '  Cadastrar pet',
                  ),
                  const SizedBox(height: 20),
                  PetButton(
                    imagePath: 'assets/images/listpet.png',
                    onPressed: () async {
                      final petDao = PetDao();
                      // ignore: unused_local_variable
                      Map<int, Pet> listaPets = await petDao.getAllPets();
                      
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ListaPetsPage())));
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
