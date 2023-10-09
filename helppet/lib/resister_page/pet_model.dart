
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
  List<DoencaLesao> historicoDoencasLesoes;
  List<ExameProcedimento> historicoExamesProcedimentos;
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
    this.historicoExamesProcedimentos = const [],
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
}

class DoencaLesao {
  String nome;
  String data;
  String tratamento;

  DoencaLesao({
    required this.nome,
    required this.data,
    this.tratamento = "",
  });
}

class ExameProcedimento {
  String nome;
  String data;
  String resultado;

  ExameProcedimento({
    required this.nome,
    required this.data,
    this.resultado = "",
  });
}

class Consulta {
  String data;
  String tipo;

  Consulta({
    required this.data,
    required this.tipo,
  });
}
