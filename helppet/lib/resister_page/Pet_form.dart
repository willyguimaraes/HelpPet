import 'package:flutter/material.dart';
import 'package:helppet/resister_page/register_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../database/petDao.dart';
import 'package:helppet/resister_page/pet_model.dart';


void main() {
  runApp(
    const MaterialApp(
      home: PetForm(),
    ),
  );
}

class PetForm extends StatelessWidget {
  const PetForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Color.fromRGBO(91, 154, 139, 1.0),
          secondary: Color.fromARGB(255, 0, 0, 0),
          background: Color.fromRGBO(37, 43, 72, 1.0),
        ),
      ),
      home: PetFormPage(),
    );
  }
}

const TextStyle customTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Montserrat',
);

class PetFormPage extends StatefulWidget {
  const PetFormPage({super.key});
  @override
  _PetFormPageState createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage>
    with AutomaticKeepAliveClientMixin<PetFormPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  bool get wantKeepAlive => true;
  String imagem = "";
  File? _pickedImage;
  String nome = "";
  String especie = "";
  String raca = "";
  String cor = "";
  String dataNascimento = "";
  String proprietarioNome = "";
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dataNascimento = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
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

  final _petDao = PetDao();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => Helppetcadastro())));
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text(
          "Cadastrar Pet",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 8.0),
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
                      style: customTextStyle,
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
                              fit: BoxFit
                                  .cover, // Para fazer a imagem ocupar todo o container
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
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      selectedDate == null
                          ? 'Selecione a data'
                          : DateFormat('dd/MM/yyyy').format(selectedDate!),
                      style: TextStyle(fontFamily: 'Montserrat'),
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

                      Pet novoPet = Pet(
                        imagem: imagem,
                        nome: nome,
                        especie: especie,
                        raca: raca,
                        cor: cor,
                        dataNascimento: dataNascimento,
                        proprietarioNome: proprietarioNome,
                      );

                      await _petDao.insertPet(novoPet);

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
                                'Cadastro realizado',
                                style: customTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                "$nome cadastrado(a) com sucesso!",
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
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                Helppetcadastro())));
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
                      'Cadastrar Pet',
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
