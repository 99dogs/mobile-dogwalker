import 'dart:convert';

class ConfiguracaoHorarioModel {
  int? id;
  String? criado;
  String? modificado;
  int? diaSemana;
  String? horaInicio;
  String? horaFinal;
  int? usuarioId;

  ConfiguracaoHorarioModel({
    this.id,
    this.criado,
    this.modificado,
    this.diaSemana,
    this.horaInicio,
    this.horaFinal,
    this.usuarioId,
  });

  ConfiguracaoHorarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    diaSemana = json['diaSemana'];
    horaInicio = json['horaInicio'];
    horaFinal = json['horaFinal'];
    usuarioId = json['usuarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['diaSemana'] = this.diaSemana;
    data['horaInicio'] = this.horaInicio;
    data['horaFinal'] = this.horaFinal;
    data['usuarioId'] = this.usuarioId;
    return data;
  }

  ConfiguracaoHorarioModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    int? diaSemana,
    String? horaInicio,
    String? horaFinal,
    int? usuarioId,
  }) {
    return ConfiguracaoHorarioModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      diaSemana: diaSemana ?? this.diaSemana,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFinal: horaFinal ?? this.horaFinal,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'diaSemana': diaSemana,
      'horaInicio': horaInicio,
      'horaFinal': horaFinal,
      'usuarioId': usuarioId,
    };
  }

  factory ConfiguracaoHorarioModel.fromMap(Map<String, dynamic> map) {
    return ConfiguracaoHorarioModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      diaSemana: map['diaSemana'],
      horaInicio: map['horaInicio'],
      horaFinal: map['horaFinal'],
      usuarioId: map['usuarioId'],
    );
  }

  @override
  String toString() {
    return 'ConfiguracaoHorarioModel(id: $id, criado: $criado, modificado: $modificado, diaSemana: $diaSemana, horaInicio: $horaInicio, horaFinal: $horaFinal, usuarioId: $usuarioId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfiguracaoHorarioModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.diaSemana == diaSemana &&
        other.horaInicio == horaInicio &&
        other.horaFinal == horaFinal &&
        other.usuarioId == usuarioId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        diaSemana.hashCode ^
        horaInicio.hashCode ^
        horaFinal.hashCode ^
        usuarioId.hashCode;
  }
}
