import 'dart:convert';

class DepositoModel {
  int? id;
  String? criado;
  String? modificado;
  double? valor;
  bool? pendente;
  bool? concluido;
  int? usuarioId;

  DepositoModel({
    this.id,
    this.criado,
    this.modificado,
    this.valor,
    this.pendente,
    this.concluido,
    this.usuarioId,
  });

  DepositoModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    double? valor,
    bool? pendente,
    bool? concluido,
    int? usuarioId,
  }) {
    return DepositoModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      valor: valor ?? this.valor,
      pendente: pendente ?? this.pendente,
      concluido: concluido ?? this.concluido,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'valor': valor,
      'pendente': pendente,
      'concluido': concluido,
      'usuarioId': usuarioId,
    };
  }

  factory DepositoModel.fromMap(Map<String, dynamic> map) {
    return DepositoModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      valor: map['valor'],
      pendente: map['pendente'],
      concluido: map['concluido'],
      usuarioId: map['usuarioId'],
    );
  }

  DepositoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    valor = json['valor'];
    pendente = json['pendente'];
    concluido = json['concluido'];
    usuarioId = json['usuarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['valor'] = this.valor;
    data['pendente'] = this.pendente;
    data['concluido'] = this.concluido;
    data['usuarioId'] = this.usuarioId;
    return data;
  }

  @override
  String toString() {
    return 'DepositoModel(id: $id, criado: $criado, modificado: $modificado, valor: $valor, pendente: $pendente, concluido: $concluido, usuarioId: $usuarioId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepositoModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.valor == valor &&
        other.pendente == pendente &&
        other.concluido == concluido &&
        other.usuarioId == usuarioId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        valor.hashCode ^
        pendente.hashCode ^
        concluido.hashCode ^
        usuarioId.hashCode;
  }
}
