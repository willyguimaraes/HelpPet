class Pet {
  String nome;
  String especie;
  String raca;
  String cor;
  String dataNascimento;
  String proprietarioNome;
  String proprietarioEndereco;
  String proprietarioTelefone;
  String proprietarioEmail;
  List<Vacina> historicoVacinas;
  List<Medicamento> historicoMedicamentos;
  List<DoencaLesao> historicoDoencasLesoes;
  List<ExameProcedimento> historicoExamesProcedimentos;
  String tipoAlimentacao;
  double quantidadeAlimentacao;
  String comportamento;
  List<Consulta> agendaConsultas;

  Pet({
    required this.nome,
    required this.especie,
    required this.raca,
    required this.cor,
    required this.dataNascimento,
    required this.proprietarioNome,
    required this.proprietarioEndereco,
    required this.proprietarioTelefone,
    this.proprietarioEmail = "",
    this.historicoVacinas = const [],
    this.historicoMedicamentos = const [],
    this.historicoDoencasLesoes = const [],
    this.historicoExamesProcedimentos = const [],
    required this.tipoAlimentacao,
    required this.quantidadeAlimentacao,
    required this.comportamento,
    this.agendaConsultas = const [],
  });
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


