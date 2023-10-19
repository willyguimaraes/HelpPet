
class Pet {
  String imagem;
  String nome;
  String especie;
  String raca;
  String cor;
  String dataNascimento;
  String proprietarioNome;
  List<Vacina> historicoVacinas;
  List<Medicamento> historicoMedicamentos;
  List<Doenca> historicoDoencasLesoes;
  List<Exame> historicoExames;
  List<Consulta> agendaConsultas;

  Pet({
    required this.imagem,
    required this.nome,
    required this.especie,
    required this.raca,
    required this.cor,
    required this.dataNascimento,
    required this.proprietarioNome,
    this.historicoVacinas = const [],
    this.historicoMedicamentos = const [],
    this.historicoDoencasLesoes = const [],
    this.historicoExames= const [],
    this.agendaConsultas = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'imagem': imagem,
      'nome': nome,
      'especie': especie,
      'raca': raca,
      'cor': cor,
      'dataNascimento': dataNascimento,
      'proprietarioNome': proprietarioNome,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
       imagem: map['imagem'],
      nome: map['nome'],
      especie: map['especie'],
      raca: map['raca'],
      cor: map['cor'],
      dataNascimento: map['dataNascimento'],
      proprietarioNome: map['proprietarioNome'],
    );
  }
}

class Vacina {
  String nome;
  String data;
  String reacao;

  Vacina({
    required this.nome,
    required this.data,
    this.reacao = "",
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'nome': nome,
      'data': data,
      'reacao': reacao,
      'petId' : id,
    };
  }

  factory Vacina.fromMap(Map<String, dynamic> map) {
    return Vacina(
      nome: map['nome'],
      data: map['data'],
      reacao: map['reacao'] ?? "",
    );
  }
}

class Medicamento {
  String nome;
  String dosagem;
  String horario;

  Medicamento({
    required this.nome,
    required this.dosagem,
    required this.horario,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'nome': nome,
      'dosagem': dosagem,
      'horario': horario,
      'petId' : id,
    };
  }

  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      nome: map['nome'],
      dosagem: map['dosagem'],
      horario: map['horario'],
    );
  }
}

class Doenca {
  String nome;
  String data;
  String tratamento;

  Doenca({
    required this.nome,
    required this.data,
    this.tratamento = "",
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'nome': nome,
      'data': data,
      'tratamento': tratamento,
      'petId' : id,
    };
  }

  factory Doenca.fromMap(Map<String, dynamic> map) {
    return Doenca(
      nome: map['nome'],
      data: map['data'],
      tratamento: map['tratamento'] ?? "",
    );
  }
}

class Exame {
  String nome;
  String data;
  String resultado;

  Exame({
    required this.nome,
    required this.data,
    this.resultado = "",
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'nome': nome,
      'data': data,
      'resultado': resultado,
      'petId' : id,
    };
  }

  factory Exame.fromMap(Map<String, dynamic> map) {
    return Exame(
      nome: map['nome'],
      data: map['data'],
      resultado: map['resultado'] ?? "",
    );
  }
}

class Consulta {
  String data;
  String tipo;

  Consulta({
    required this.data,
    required this.tipo,
  });

  Map<String, dynamic> toMap(int id) {
    return {
      'data': data,
      'tipo': tipo,
      'petId' : id,
    };
  }

  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      data: map['data'],
      tipo: map['tipo'],
    );
  }
}

