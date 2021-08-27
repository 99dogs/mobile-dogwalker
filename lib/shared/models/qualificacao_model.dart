import 'dart:convert';

class QualificacaoModel {
  int? id;
  String? criado;
  String? modificado;
  String? titulo;
  String? modalidade;
  String? descricao;
  int? usuarioId;

  QualificacaoModel({
    this.id,
    this.criado,
    this.modificado,
    this.titulo,
    this.modalidade,
    this.descricao,
    this.usuarioId,
  });

  QualificacaoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    titulo = json['titulo'];
    modalidade = json['modalidade'];
    descricao = json['descricao'];
    usuarioId = json['usuarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['titulo'] = this.titulo;
    data['modalidade'] = this.modalidade;
    data['descricao'] = this.descricao;
    data['usuarioId'] = this.usuarioId;
    return data;
  }

  QualificacaoModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    String? titulo,
    String? modalidade,
    String? descricao,
    int? usuarioId,
  }) {
    return QualificacaoModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      titulo: titulo ?? this.titulo,
      modalidade: modalidade ?? this.modalidade,
      descricao: descricao ?? this.descricao,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'titulo': titulo,
      'modalidade': modalidade,
      'descricao': descricao,
      'usuarioId': usuarioId,
    };
  }

  factory QualificacaoModel.fromMap(Map<String, dynamic> map) {
    return QualificacaoModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      titulo: map['titulo'],
      modalidade: map['modalidade'],
      descricao: map['descricao'],
      usuarioId: map['usuarioId'],
    );
  }

  @override
  String toString() {
    return 'QualificacaoModel(id: $id, criado: $criado, modificado: $modificado, titulo: $titulo, modalidade: $modalidade, descricao: $descricao, usuarioId: $usuarioId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QualificacaoModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.titulo == titulo &&
        other.modalidade == modalidade &&
        other.descricao == descricao &&
        other.usuarioId == usuarioId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        titulo.hashCode ^
        modalidade.hashCode ^
        descricao.hashCode ^
        usuarioId.hashCode;
  }
}
