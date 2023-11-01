
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