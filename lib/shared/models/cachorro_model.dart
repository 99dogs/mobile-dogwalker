import 'dart:convert';

import 'package:dogwalker/shared/models/porte_model.dart';
import 'package:dogwalker/shared/models/raca_model.dart';

class CachorroModel {
  int? id;
  String? nome;
  DateTime? dataNascimento;
  String? comportamento;
  int? racaId;
  int? porteId;
  RacaModel? raca;
  PorteModel? porte;
  CachorroModel({
    this.id,
    this.nome,
    this.dataNascimento,
    this.comportamento,
    this.racaId,
    this.porteId,
    this.raca,
    this.porte,
  });

  CachorroModel copyWith({
    int? id,
    String? nome,
    DateTime? dataNascimento,
    String? comportamento,
    int? racaId,
    int? porteId,
    RacaModel? raca,
    PorteModel? porte,
  }) {
    return CachorroModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      comportamento: comportamento ?? this.comportamento,
      racaId: racaId ?? this.racaId,
      porteId: porteId ?? this.porteId,
      raca: raca ?? this.raca,
      porte: porte ?? this.porte,
    );
  }

  String? validarNome(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;

  String? validarPorte(PorteModel? value) =>
      value?.nome!.isEmpty ?? true ? "O porte não pode ser vazio" : null;

  String? validarRaca(RacaModel? value) =>
      value?.nome!.isEmpty ?? true ? "A raça não pode ser vazia" : null;

  String? validarComportamento(String? value) =>
      value?.isEmpty ?? true ? "O comportamento não pode ser vazio" : null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'dataNascimento':
          dataNascimento != null ? dataNascimento!.millisecondsSinceEpoch : '',
      'comportamento': comportamento,
      'racaId': racaId,
      'porteId': porteId,
      'raca': raca!.toMap(),
      'porte': porte!.toMap(),
    };
  }

  factory CachorroModel.fromMap(Map<String, dynamic> map) {
    return CachorroModel(
      id: map['id'],
      nome: map['nome'],
      dataNascimento:
          DateTime.fromMillisecondsSinceEpoch(map['dataNascimento']),
      comportamento: map['comportamento'],
      racaId: map['racaId'],
      porteId: map['porteId'],
      raca: RacaModel.fromMap(map['raca']),
      porte: PorteModel.fromMap(map['porte']),
    );
  }

  String toJson() => json.encode(toMap());

  CachorroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataNascimento = json['dataNascimento'] != null
        ? DateTime.parse(json['dataNascimento'])
        : null;
    comportamento = json['comportamento'];
    racaId = json['racaId'];
    porteId = json['porteId'];
    raca = json['raca'] != null ? new RacaModel.fromJson(json['raca']) : null;
    porte =
        json['porte'] != null ? new PorteModel.fromJson(json['porte']) : null;
  }

  @override
  String toString() {
    return 'CachorroModel(id: $id, nome: $nome, dataNascimento: $dataNascimento, comportamento: $comportamento, racaId: $racaId, porteId: $porteId, raca: $raca, porte: $porte)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CachorroModel &&
        other.id == id &&
        other.nome == nome &&
        other.dataNascimento == dataNascimento &&
        other.comportamento == comportamento &&
        other.racaId == racaId &&
        other.porteId == porteId &&
        other.raca == raca &&
        other.porte == porte;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        dataNascimento.hashCode ^
        comportamento.hashCode ^
        racaId.hashCode ^
        porteId.hashCode ^
        raca.hashCode ^
        porte.hashCode;
  }
}
