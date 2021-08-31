import 'package:flutter/foundation.dart';

import 'package:dogwalker/shared/models/cachorro_model.dart';
import 'package:dogwalker/shared/models/usuario_model.dart';

class PasseioModel {
  int? id;
  String? criado;
  String? modificado;
  String? datahora;
  String? status;
  String? datahorafinalizacao;
  int? dogwalkerId;
  int? tutorId;
  List<dynamic>? cachorrosIds;
  List<CachorroModel>? cachorros;
  UsuarioModel? dogwalker;
  UsuarioModel? tutor;

  PasseioModel({
    this.id,
    this.criado,
    this.modificado,
    this.datahora,
    this.status,
    this.datahorafinalizacao,
    this.dogwalkerId,
    this.tutorId,
    this.cachorrosIds,
    this.cachorros,
    this.dogwalker,
    this.tutor,
  });

  PasseioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    datahora = json['datahora'];
    status = json['status'];
    datahorafinalizacao = json['datahorafinalizacao'];
    dogwalkerId = json['dogwalkerId'];
    tutorId = json['tutorId'];
    if (json['cachorros'] != null) {
      cachorros = [];
      json['cachorros'].forEach((v) {
        cachorros!.add(new CachorroModel.fromJson(v));
      });
    }
    dogwalker = json['dogwalker'] != null
        ? new UsuarioModel.fromJson(json['dogwalker'])
        : null;
    tutor =
        json['tutor'] != null ? new UsuarioModel.fromJson(json['tutor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['datahora'] = this.datahora;
    data['status'] = this.status;
    data['datahorafinalizacao'] = this.datahorafinalizacao;
    data['dogwalkerId'] = this.dogwalkerId;
    data['tutorId'] = this.tutorId;
    if (this.cachorros != null) {
      data['cachorros'] = this.cachorros!.map((v) => v.toJson()).toList();
    }
    if (this.dogwalker != null) {
      data['dogwalker'] = this.dogwalker!.toJson();
    }
    if (this.tutor != null) {
      data['tutor'] = this.tutor!.toJson();
    }
    return data;
  }

  PasseioModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    String? datahora,
    String? status,
    String? datahorafinalizacao,
    int? dogwalkerId,
    int? tutorId,
    List<dynamic>? cachorrosIds,
    List<CachorroModel>? cachorros,
    UsuarioModel? dogwalker,
    UsuarioModel? tutor,
  }) {
    return PasseioModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      datahora: datahora ?? this.datahora,
      status: status ?? this.status,
      datahorafinalizacao: datahorafinalizacao ?? this.datahorafinalizacao,
      dogwalkerId: dogwalkerId ?? this.dogwalkerId,
      tutorId: tutorId ?? this.tutorId,
      cachorrosIds: cachorrosIds ?? this.cachorrosIds,
      cachorros: cachorros ?? this.cachorros,
      dogwalker: dogwalker ?? this.dogwalker,
      tutor: tutor ?? this.tutor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'datahora': datahora,
      'status': status,
      'datahorafinalizacao': datahorafinalizacao,
      'dogwalkerId': dogwalkerId,
      'tutorId': tutorId,
      'cachorrosIds': cachorrosIds,
      'cachorros': cachorros?.map((x) => x.toMap()).toList(),
      'dogwalker': dogwalker?.toMap(),
      'tutor': tutor?.toMap(),
    };
  }

  factory PasseioModel.fromMap(Map<String, dynamic> map) {
    return PasseioModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      datahora: map['datahora'],
      status: map['status'],
      datahorafinalizacao: map['datahorafinalizacao'],
      dogwalkerId: map['dogwalkerId'],
      tutorId: map['tutorId'],
      cachorrosIds: List<dynamic>.from(map['cachorrosIds']),
      cachorros: List<CachorroModel>.from(
          map['cachorros']?.map((x) => CachorroModel.fromMap(x))),
      dogwalker: UsuarioModel.fromMap(map['dogwalker']),
      tutor: UsuarioModel.fromMap(map['tutor']),
    );
  }

  @override
  String toString() {
    return 'PasseioModel(id: $id, criado: $criado, modificado: $modificado, datahora: $datahora, status: $status, datahorafinalizacao: $datahorafinalizacao, dogwalkerId: $dogwalkerId, tutorId: $tutorId, cachorrosIds: $cachorrosIds, cachorros: $cachorros, dogwalker: $dogwalker, tutor: $tutor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PasseioModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.datahora == datahora &&
        other.status == status &&
        other.datahorafinalizacao == datahorafinalizacao &&
        other.dogwalkerId == dogwalkerId &&
        other.tutorId == tutorId &&
        listEquals(other.cachorrosIds, cachorrosIds) &&
        listEquals(other.cachorros, cachorros) &&
        other.dogwalker == dogwalker &&
        other.tutor == tutor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        datahora.hashCode ^
        status.hashCode ^
        datahorafinalizacao.hashCode ^
        dogwalkerId.hashCode ^
        tutorId.hashCode ^
        cachorrosIds.hashCode ^
        cachorros.hashCode ^
        dogwalker.hashCode ^
        tutor.hashCode;
  }
}
