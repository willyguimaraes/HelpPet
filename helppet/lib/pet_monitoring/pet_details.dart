import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helppet/database/petDao.dart';
import 'package:helppet/models/pet_model.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/consultation_menu.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/disease_menu.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/exam_menu.dart';
import 'package:helppet/resister_page/pets_list.dart';
import 'package:helppet/resister_page/pet_edit.dart';
import '../components/vet_button.dart';
import 'monitoring_menus/medicine_menu.dart';
import 'monitoring_menus/vaccine_menu.dart';

const TextStyle customTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Montserrat',
);

class PetDetailsPage extends StatelessWidget {
  final Pet pet;
  final int id;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PetDetailsPage({super.key, required this.pet, required this.id});

  @override
  Widget build(BuildContext context) {
    final _petDao = PetDao();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => ListaPetsPage())));
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text('Detalhes do Pet'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.4,
          margin: EdgeInsets.zero,
          child: Drawer(
            backgroundColor: const Color.fromRGBO(37, 43, 72, 1),
            width: MediaQuery.of(context).size.width * 0.6,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(37, 43, 72, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                MaterialPageRoute(builder: ((context) => PetEditForm(pet: pet, id: id))));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 30),
                      ),
                      child: const Text(
                        'Editar Pet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 30),
                      ),
                      child: const Text(
                        'Excluir Pet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      onPressed: () async {
                        bool confirmacao = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              title: Text(
                                'Deseja excluir ${pet.nome}?',
                                style: customTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                "Todas as informações serão perdidas",
                                style: customTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(false); // Não confirma a exclusão
                                  },
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // Confirma a exclusão
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmacao) {
                          await _petDao.deletePet(id);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            await const SnackBar(
                              content: Text('Pet deletado com sucesso'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ListaPetsPage()),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )),
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background_main.jpg"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                Card(
                  color: const Color.fromRGBO(91, 154, 139, 1.0),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: SizedBox(
                            width: 80,
                            height: 100,
                            child: Image.file(
                              File(pet.imagem),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text('Nome: ${pet.nome}', style: customTextStyle),
                        Text('Espécie: ${pet.especie}', style: customTextStyle),
                        Text('Raça: ${pet.raca}', style: customTextStyle),
                        Text('Cor: ${pet.cor}', style: customTextStyle),
                        Text('Data de Nascimento: ${pet.dataNascimento}',
                            style: customTextStyle),
                        Text('Proprietário: ${pet.proprietarioNome}',
                            style: customTextStyle),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 12.0),
                    VetButton(
                      buttonText: 'Vacinas',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => VaccinePage(
                                      petId: id,
                                      pet: pet,
                                    ))));
                      },
                      image: 'assets/images/vacina.png',
                    ),
                    const SizedBox(height: 12.0),
                    VetButton(
                      buttonText: 'Medicamentos',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MedicinePage(
                                      petId: id,
                                      pet: pet,
                                    ))));
                      },
                      image: 'assets/images/medicamentos.png',
                    ),
                    const SizedBox(height: 12.0),
                    VetButton(
                      buttonText: 'Doenças',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DiseasePage(
                                      petId: id,
                                      pet: pet,
                                    ))));
                      },
                      image: 'assets/images/doencas.png',
                    ),
                    const SizedBox(height: 12.0),
                    VetButton(
                      buttonText: 'Exames',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ExamPage(
                                      petId: id,
                                      pet: pet,
                                    ))));
                      },
                      image: 'assets/images/exames.png',
                    ),
                    const SizedBox(height: 12.0),
                    VetButton(
                      buttonText: 'Consultas',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ConsultationPage(
                                      petId: id,
                                      pet: pet,
                                    ))));
                      },
                      image: 'assets/images/consultas.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
