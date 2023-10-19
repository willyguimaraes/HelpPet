import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/consultation_menu.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/disease_menu.dart';
import 'package:helppet/pet_monitoring/monitoring_menus/exam_menu.dart';
import 'package:helppet/resister_page/pets_list.dart';
import '../components/vet_button.dart';

import 'package:helppet/resister_page/pet_model.dart';

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

  const PetDetailsPage({super.key, required this.pet, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ListaPetsPage())));
              },
              child: const Icon(Icons.arrow_back_sharp),
            ),
        title: const Text('Detalhes do Pet'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background_main.jpg"),
                  fit: BoxFit.cover)),
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
                      builder: ((context) => VaccinePage(petId: id, pet: pet,))));
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
                      builder: ((context) => MedicinePage(petId: id, pet: pet,))));
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
                      builder: ((context) => DiseasePage(petId: id, pet: pet,))));
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
                      builder: ((context) => ExamPage(petId: id, pet: pet,))));
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
                      builder: ((context) => ConsultationPage(petId: id, pet: pet,))));
                    },
                    image: 'assets/images/consultas.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
