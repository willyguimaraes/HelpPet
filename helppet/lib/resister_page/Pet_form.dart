import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

void main() {
  final ThemeData tema = ThemeData();
  runApp(
    MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Color.fromRGBO(91, 154, 139, 1.0),
          secondary: Color.fromARGB(255, 0, 0, 0),
          background: Color.fromRGBO(37, 43, 72, 1.0),
        ),
      ),
      home: PetFormPage(),
    ),
  );
}

const TextStyle customTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black, // Altere a cor conforme necessário
  fontFamily: 'Montserrat',
);

class PetFormPage extends StatefulWidget {
  @override
  _PetFormPageState createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Variáveis para armazenar os dados do formulário
  Image? _pickedImage;
  String nome = "";
  String especie = "";
  String raca = "";
  String cor = "";
  String dataNascimento = "";
  String proprietarioNome = "";
  String proprietarioEndereco = "";
  String proprietarioTelefone = "";
  String proprietarioEmail = "";
  String tipoAlimentacao = "";
  double quantidadeAlimentacao = 0.0;
  String comportamento = "";

  // Variável para armazenar a data selecionada
  DateTime? selectedDate;

  // Função para exibir o seletor de data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dataNascimento = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = Image.file(File(pickedImage.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Pet',
          style: customTextStyle,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Espaço inicial
              SizedBox(height: 8.0),

              // Imagem do pet
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    'Imagem do pet',
                    style: customTextStyle,
                  ),
                  subtitle: _pickedImage == null
                      ? Text(
                          'Nenhuma imagem selecionada',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        )
                      : _pickedImage!,
                  onTap: () => _getImage(),
                ),
              ),

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Nome do Pet
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration: InputDecoration(labelText: 'Nome do Pet'),
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

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Especie
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

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Raça
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration: InputDecoration(labelText: 'Raça'),
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

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Cor
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration: InputDecoration(labelText: 'Cor'),
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

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Data de Nascimento
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(
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

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Nome do Proprietário
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration:
                      InputDecoration(labelText: 'Nome do proprietário'),
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

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Endereço do Proprietário
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration:
                      InputDecoration(labelText: 'Endereço do proprietário'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    proprietarioEndereco = value!;
                  },
                ),
              ),

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Email do Proprietário
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration:
                      InputDecoration(labelText: 'Email do Proprietário'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    proprietarioEmail = value!;
                  },
                ),
              ),

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Telefone do Proprietário
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration:
                      InputDecoration(labelText: 'Telefone do proprietário'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    proprietarioTelefone = value!;
                  },
                ),
              ),

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Tipo de Alimentação
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration: InputDecoration(labelText: 'Tipo de alimentação'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    tipoAlimentacao = value!;
                  },
                ),
              ),

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Quantidade da Alimentação
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration:
                      InputDecoration(labelText: 'Quantidade da alimentação'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    try {
                      double doubleValue = double.parse(value);
                      return null;
                    } catch (e) {
                      return 'Digite um número válido';
                    }
                  },
                  onSaved: (value) {
                    quantidadeAlimentacao = double.parse(value!);
                  },
                ),
              ),

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Comportamento
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextFormField(
                  style: customTextStyle,
                  decoration: InputDecoration(labelText: 'Comportamento'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    comportamento = value!;
                  },
                ),
              ),

              // Espaço entre os elementos
              SizedBox(height: 8.0),

              // Botão de cadastro
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aqui você pode enviar os dados do formulário para onde desejar
                    // Por exemplo, você pode criar uma instância da classe Pet e armazenar os dados nela.
                    // Depois, pode exibir ou salvar esses dados conforme necessário.
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
                )),
              ),

              // Espaço final
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
