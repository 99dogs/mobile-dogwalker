import 'dart:convert';

class FormaDePagamentoModel {
  int? id;
  String? criado;
  String? modificado;
  String? nome;
  String? tipo;
  bool? ativo;

  FormaDePagamentoModel({
    this.id,
    this.criado,
    this.modificado,
    this.nome,
    this.tipo,
    this.ativo,
  });

  FormaDePagamentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    nome = json['nome'];
    tipo = json['tipo'];
    ativo = json['ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['ativo'] = this.ativo;
    return data;
  }

  FormaDePagamentoModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    String? nome,
    String? tipo,
    bool? ativo,
  }) {
    return FormaDePagamentoModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'nome': nome,
      'tipo': tipo,
      'ativo': ativo,
    };
  }

  factory FormaDePagamentoModel.fromMap(Map<String, dynamic> map) {
    return FormaDePagamentoModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      nome: map['nome'],
      tipo: map['tipo'],
      ativo: map['ativo'],
    );
  }

  @override
  String toString() {
    return 'FormaDePagamentoModel(id: $id, criado: $criado, modificado: $modificado, nome: $nome, tipo: $tipo, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormaDePagamentoModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.nome == nome &&
        other.tipo == tipo &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        nome.hashCode ^
        tipo.hashCode ^
        ativo.hashCode;
  }
}
