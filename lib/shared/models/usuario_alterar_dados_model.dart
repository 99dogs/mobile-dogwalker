import 'dart:convert';

import 'package:dogwalker/shared/models/cidade_model.dart';
import 'package:dogwalker/shared/models/estado_model.dart';

class UsuarioAlterarDadosModel {
  String? nome;
  String? telefone;
  String? rua;
  String? bairro;
  String? numero;
  String? cep;
  int? estadoId;
  int? cidadeId;
  EstadoModel? estado;
  CidadeModel? cidade;
  UsuarioAlterarDadosModel({
    this.nome,
    this.telefone,
    this.rua,
    this.bairro,
    this.numero,
    this.cep,
    this.estadoId,
    this.cidadeId,
    this.estado,
    this.cidade,
  });

  UsuarioAlterarDadosModel copyWith({
    String? nome,
    String? telefone,
    String? rua,
    String? bairro,
    String? numero,
    String? cep,
    int? estadoId,
    int? cidadeId,
    EstadoModel? estado,
    CidadeModel? cidade,
  }) {
    return UsuarioAlterarDadosModel(
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      rua: rua ?? this.rua,
      bairro: bairro ?? this.bairro,
      numero: numero ?? this.numero,
      cep: cep ?? this.cep,
      estadoId: estadoId ?? this.estadoId,
      cidadeId: cidadeId ?? this.cidadeId,
      estado: estado ?? this.estado,
      cidade: cidade ?? this.cidade,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'telefone': telefone,
      'rua': rua,
      'bairro': bairro,
      'numero': numero,
      'cep': cep,
      'estadoId': estadoId,
      'cidadeId': cidadeId,
      'estado': estado?.toMap(),
      'cidade': cidade?.toMap(),
    };
  }

  factory UsuarioAlterarDadosModel.fromMap(Map<String, dynamic> map) {
    return UsuarioAlterarDadosModel(
      nome: map['nome'],
      telefone: map['telefone'],
      rua: map['rua'],
      bairro: map['bairro'],
      numero: map['numero'],
      cep: map['cep'],
      estadoId: map['estadoId'],
      cidadeId: map['cidadeId'],
      estado: EstadoModel.fromMap(map['estado']),
      cidade: CidadeModel.fromMap(map['cidade']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioAlterarDadosModel.fromJson(String source) =>
      UsuarioAlterarDadosModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsuarioAlterarDadosModel(nome: $nome, telefone: $telefone, rua: $rua, bairro: $bairro, numero: $numero, cep: $cep, estadoId: $estadoId, cidadeId: $cidadeId, estado: $estado, cidade: $cidade)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioAlterarDadosModel &&
        other.nome == nome &&
        other.telefone == telefone &&
        other.rua == rua &&
        other.bairro == bairro &&
        other.numero == numero &&
        other.cep == cep &&
        other.estadoId == estadoId &&
        other.cidadeId == cidadeId &&
        other.estado == estado &&
        other.cidade == cidade;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        telefone.hashCode ^
        rua.hashCode ^
        bairro.hashCode ^
        numero.hashCode ^
        cep.hashCode ^
        estadoId.hashCode ^
        cidadeId.hashCode ^
        estado.hashCode ^
        cidade.hashCode;
  }
}
