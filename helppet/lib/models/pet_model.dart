
class Pet {
  String imagem;
  String nome;
  String especie;
  String raca;
  String cor;
  String dataNascimento;
  String proprietarioNome;

  Pet({
    required this.imagem,
    required this.nome,
    required this.especie,
    required this.raca,
    required this.cor,
    required this.dataNascimento,
    required this.proprietarioNome,
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








