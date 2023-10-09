import 'package:flutter/material.dart';
import 'dart:io';

import '../resister_page/pet_model.dart';
import '../database/petDao.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pets'),
      ),
      body: _buildListaPets(),
    );
  }

  Widget _buildListaPets() {
    if (_listaPets.isEmpty) {
      return Center(
        child: Text('Nenhum Pet cadastrado.'),
      );
    } else {
      return ListView.builder(
        itemCount: _listaPets.length,
        itemBuilder: (context, index) {
          Pet pet = _listaPets[index];
          return ListTile(
            title: Text(pet.nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Espécie: ${pet.especie}, Raça: ${pet.raca}'),
                // Adicione um widget Image.file para exibir a imagem do pet
                if (pet.imagem.isNotEmpty)
                  Image.file(
                    File(pet.imagem),
                    width: 50, // Ajuste conforme necessário
                    height: 50, // Ajuste conforme necessário
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          );
        },
      );
    }
  }
}
