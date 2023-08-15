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
          primary: Color.fromRGBO(91, 154, 139, 1.0),
          secondary: Color.fromARGB(255, 0, 0, 0),
          
        ),
      ),
      home: Scaffold(
        backgroundColor:Color.fromRGBO(37, 43, 72, 1.0),
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.6,
          leading: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
          
        ),
        
        body: Container(
          //color:  Color.fromRGBO(31, 40, 51, 1.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Selecione o pet:',
                  style: TextStyle(fontSize: 34,
                  color: Colors.white),
                ),
                
                Column(
                  children: [
                    PetButton(
                      imagePath: 'assets/images/pet1.png',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => const Aidlist(pet: 'dog',))));
                      },
                      buttonText: 'Cães',
                    ),
                    const SizedBox(height: 20),
                    PetButton(
                      imagePath: 'assets/images/pet2.png',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => const Aidlist(pet: 'cat',))));
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
      ),
    );
  }
}
