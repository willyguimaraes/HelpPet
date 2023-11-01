

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