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