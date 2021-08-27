import 'dart:convert';

class RacaModel {
  int? id;
  String? criado;
  String? modificado;
  String? nome;

  RacaModel({
    this.id,
    this.criado,
    this.modificado,
    this.nome,
  });

  RacaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['nome'] = this.nome;
    return data;
  }

  RacaModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    String? nome,
  }) {
    return RacaModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'nome': nome,
    };
  }

  factory RacaModel.fromMap(Map<String, dynamic> map) {
    return RacaModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      nome: map['nome'],
    );
  }

  @override
  String toString() {
    return 'RacaModel(id: $id, criado: $criado, modificado: $modificado, nome: $nome)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RacaModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.nome == nome;
  }

  @override
  int get hashCode {
    return id.hashCode ^ criado.hashCode ^ modificado.hashCode ^ nome.hashCode;
  }
}
