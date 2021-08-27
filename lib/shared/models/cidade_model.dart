import 'dart:convert';

class CidadeModel {
  int? id;
  String? nome;
  bool? ativo;

  CidadeModel({
    this.id,
    this.nome,
    this.ativo,
  });

  CidadeModel copyWith({
    int? id,
    String? nome,
    bool? ativo,
  }) {
    return CidadeModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'ativo': ativo,
    };
  }

  factory CidadeModel.fromMap(Map<String, dynamic> map) {
    return CidadeModel(
      id: map['id'],
      nome: map['nome'],
      ativo: map['ativo'],
    );
  }

  String toJson() => json.encode(toMap());

  CidadeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    ativo = json['ativo'];
  }

  @override
  String toString() => 'CidadeModel(id: $id, nome: $nome, ativo: $ativo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CidadeModel &&
        other.id == id &&
        other.nome == nome &&
        other.ativo == ativo;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ ativo.hashCode;
}
