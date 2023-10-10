import 'package:flutter/material.dart';
import 'dart:io';

import '../resister_page/pet_model.dart';
import '../database/petDao.dart';
import 'register_main.dart';

class ListaPetsPage extends StatefulWidget {
  @override
  _ListaPetsPageState createState() => _ListaPetsPageState();
}

class _ListaPetsPageState extends State<ListaPetsPage> {
  final _petDao = PetDao();
  List<Pet> _listaPets = [];

  @override
  void initState() {
    super.initState();
    _carregarPetsDoBanco();
  }

  Future<void> _carregarPetsDoBanco() async {
    List<Pet> listaPets = await _petDao.getAllPets();
    setState(() {
      _listaPets = listaPets;
    });
  }

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
        appBar: AppBar(
            leading: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Helppetcadastro())));
              },
              child: const Icon(Icons.arrow_back_sharp),
            ),
            title: const Text(
              'Meus Pets',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Montserrat'),
            )),
        body: _buildListaPets(),
      ),
    );
  }

  Widget _buildListaPets() {
    if (_listaPets.isEmpty) {
      return Center(
        child: Text('Nenhum Pet cadastrado.'),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_main.jpg"),
                fit: BoxFit.cover)),
        child: ListView.builder(
          itemCount: _listaPets.length,
          itemBuilder: (context, index) {
            Pet pet = _listaPets[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (pet.imagem.isNotEmpty)
                        Image.file(
                          File(pet.imagem),
                          width: 50, // Ajuste conforme necessário
                          height: 50, // Ajuste conforme necessário
                          fit: BoxFit.cover,
                        ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet.nome,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                            Text(
                              'Espécie: ${pet.especie}, Raça: ${pet.raca}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
