import 'package:flutter/material.dart';
import 'package:helppet/models/pet_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../database/petDao.dart';
import 'pets_list.dart';

class PetEditForm extends StatefulWidget {
  final Pet pet;
  final int id;

  const PetEditForm({required this.pet, required this.id, Key? key})
      : super(key: key);

  @override
  _PetEditFormState createState() => _PetEditFormState(id: id);
}

const TextStyle customTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Montserrat',
);

class _PetEditFormState extends State<PetEditForm> {
  final _formKey = GlobalKey<FormState>();
  final int id;

  _PetEditFormState({required this.id});

  String imagem = "";
  File? _pickedImage;
  late String nome;
  late String especie;
  late String raca;
  late String cor;
  late String dataNascimento;
  late String proprietarioNome;
  late DateTime? selectedDate;

  final _petDao = PetDao();

  @override
  void initState() {
    super.initState();

    _initializeFields();
  }

  void _initializeFields() {
    nome = widget.pet.nome;
    especie = widget.pet.especie;
    raca = widget.pet.raca;
    cor = widget.pet.cor;
    dataNascimento = widget.pet.dataNascimento;
    proprietarioNome = widget.pet.proprietarioNome;
    selectedDate = DateFormat("dd/MM/yyyy").parse(dataNascimento);
    _pickedImage = File(widget.pet.imagem);
    imagem = widget.pet.imagem;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dataNascimento = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  Future<String> saveImageToFileSystem(File? imageFile) async {
    if (imageFile == null) {
      return '';
    }

    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/pet_images/${DateTime.now().millisecondsSinceEpoch}.png';

    await Directory('${directory.path}/pet_images').create(recursive: true);
    await imageFile.copy(imagePath);

    return imagePath;
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
    imagem = await saveImageToFileSystem(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editar Pet",
          style: customTextStyle,
        ),
      ),
      backgroundColor: const Color.fromRGBO(37, 43, 72, 1),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: ListTile(
                    title: Text(
                      'Imagem do pet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: _pickedImage == null
                        ? Text(
                            'Nenhuma imagem selecionada',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          )
                        : Container(
                            width: 300.0,
                            height: 300.0,
                            child: Image.file(
                              _pickedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                    trailing: _pickedImage == null
                        ? const Icon(Icons.add_a_photo_outlined)
                        : null,
                    onTap: () => _getImage(),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextFormField(
                    initialValue: widget.pet.nome,
                    style: customTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Nome do Pet',
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (states) => customTextStyle),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nome = value!;
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: especie == 'Gato',
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              especie = 'Gato';
                            } else {
                              especie = 'Cachorro';
                            }
                          });
                        },
                      ),
                      Text(
                        'Gato',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Checkbox(
                        value: especie == 'Cachorro',
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              especie = 'Cachorro';
                            } else {
                              especie = 'Gato';
                            }
                          });
                        },
                      ),
                      Text(
                        'Cachorro',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextFormField(
                    initialValue: widget.pet.raca,
                    style: customTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Raça',
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (states) => customTextStyle),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      raca = value!;
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextFormField(
                    initialValue: widget.pet.cor,
                    style: customTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Cor',
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (states) => customTextStyle),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cor = value!;
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: const Text(
                      'Data de Nascimento',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Text(
                      selectedDate == null
                          ? 'Selecione a data'
                          : DateFormat('dd/MM/yyyy').format(selectedDate!),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextFormField(
                    initialValue: widget.pet.proprietarioNome,
                    style: customTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Nome do proprietário',
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (states) => customTextStyle),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      proprietarioNome = value!;
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Pet petAtualizado = Pet(
                        imagem: imagem,
                        nome: nome,
                        especie: especie,
                        raca: raca,
                        cor: cor,
                        dataNascimento: dataNascimento,
                        proprietarioNome: proprietarioNome,
                      );

                      await _petDao.updatePet(petAtualizado, id);

                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: AlertDialog(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              title: const Text(
                                'Atualização realizada',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                "$nome atualizado(a) com sucesso!",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(37, 43, 72, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                ListaPetsPage())));
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
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      'Salvar Alterações',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
