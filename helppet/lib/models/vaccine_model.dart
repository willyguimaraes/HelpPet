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