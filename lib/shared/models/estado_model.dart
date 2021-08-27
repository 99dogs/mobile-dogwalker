import 'dart:convert';

class EstadoModel {
  int? id;
  String? nome;
  String? sigla;
  bool? ativo;

  EstadoModel({
    this.id,
    this.nome,
    this.sigla,
    this.ativo,
  });

  EstadoModel copyWith({
    int? id,
    String? nome,
    String? sigla,
    bool? ativo,
  }) {
    return EstadoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      sigla: sigla ?? this.sigla,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'sigla': sigla,
      'ativo': ativo,
    };
  }

  factory EstadoModel.fromMap(Map<String, dynamic> map) {
    return EstadoModel(
      id: map['id'],
      nome: map['nome'],
      sigla: map['sigla'],
      ativo: map['ativo'],
    );
  }

  String toJson() => json.encode(toMap());

  EstadoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    sigla = json['sigla'];
    ativo = json['ativo'];
  }

  @override
  String toString() {
    return 'EstadoModel(id: $id, nome: $nome, sigla: $sigla, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EstadoModel &&
        other.id == id &&
        other.nome == nome &&
        other.sigla == sigla &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ sigla.hashCode ^ ativo.hashCode;
  }
}
