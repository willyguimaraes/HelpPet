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