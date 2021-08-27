import 'dart:convert';

import 'package:dogwalker/shared/models/cidade_model.dart';
import 'package:dogwalker/shared/models/estado_model.dart';

class UsuarioModel {
  int? id;
  String? criado;
  String? modificado;
  String? nome;
  String? email;
  String? telefone;
  String? rua;
  String? bairro;
  String? numero;
  String? cep;
  double? avaliacao;
  int? qtdeTicketDisponivel;
  CidadeModel? cidade;
  EstadoModel? estado;
  bool? enabled;
  bool? credentialsNonExpired;
  bool? accountNonExpired;
  bool? accountNonLocked;
  String? fotoUrl;

  UsuarioModel({
    this.id,
    this.criado,
    this.modificado,
    this.nome,
    this.email,
    this.telefone,
    this.rua,
    this.bairro,
    this.numero,
    this.cep,
    this.avaliacao,
    this.qtdeTicketDisponivel,
    this.cidade,
    this.estado,
    this.enabled,
    this.credentialsNonExpired,
    this.accountNonExpired,
    this.accountNonLocked,
    this.fotoUrl,
  });

  UsuarioModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    String? nome,
    String? email,
    String? telefone,
    String? rua,
    String? bairro,
    String? numero,
    String? cep,
    double? avaliacao,
    int? qtdeTicketDisponivel,
    CidadeModel? cidade,
    EstadoModel? estado,
    bool? enabled,
    bool? credentialsNonExpired,
    bool? accountNonExpired,
    bool? accountNonLocked,
    String? fotoUrl,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      rua: rua ?? this.rua,
      bairro: bairro ?? this.bairro,
      numero: numero ?? this.numero,
      cep: cep ?? this.cep,
      avaliacao: avaliacao ?? this.avaliacao,
      qtdeTicketDisponivel: qtdeTicketDisponivel ?? this.qtdeTicketDisponivel,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      enabled: enabled ?? this.enabled,
      credentialsNonExpired:
          credentialsNonExpired ?? this.credentialsNonExpired,
      accountNonExpired: accountNonExpired ?? this.accountNonExpired,
      accountNonLocked: accountNonLocked ?? this.accountNonLocked,
      fotoUrl: fotoUrl ?? this.fotoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'rua': rua,
      'bairro': bairro,
      'numero': numero,
      'cep': cep,
      'avaliacao': avaliacao,
      'qtdeTicketDisponivel': qtdeTicketDisponivel,
      'cidade': cidade?.toMap(),
      'estado': estado?.toMap(),
      'enabled': enabled,
      'credentialsNonExpired': credentialsNonExpired,
      'accountNonExpired': accountNonExpired,
      'accountNonLocked': accountNonLocked,
      'fotoUrl': fotoUrl,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      rua: map['rua'],
      bairro: map['bairro'],
      numero: map['numero'],
      cep: map['cep'],
      avaliacao: map['avaliacao'],
      qtdeTicketDisponivel: map['qtdeTicketDisponivel'],
      cidade: CidadeModel.fromMap(map['cidade']),
      estado: EstadoModel.fromMap(map['estado']),
      enabled: map['enabled'],
      credentialsNonExpired: map['credentialsNonExpired'],
      accountNonExpired: map['accountNonExpired'],
      accountNonLocked: map['accountNonLocked'],
      fotoUrl: map['fotoUrl'],
    );
  }

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    rua = json['rua'];
    bairro = json['bairro'];
    numero = json['numero'];
    cep = json['cep'];
    avaliacao = json['avaliacao'];
    qtdeTicketDisponivel = json['qtdeTicketDisponivel'];
    cidade = json['cidade'] != null
        ? new CidadeModel.fromJson(json['cidade'])
        : null;
    estado = json['estado'] != null
        ? new EstadoModel.fromJson(json['estado'])
        : null;
    enabled = json['enabled'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    fotoUrl = json['fotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['rua'] = this.rua;
    data['bairro'] = this.bairro;
    data['numero'] = this.numero;
    data['cep'] = this.cep;
    data['avaliacao'] = this.avaliacao;
    data['qtdeTicketDisponivel'] = this.qtdeTicketDisponivel;
    if (this.cidade != null) {
      data['cidade'] = this.cidade!.toJson();
    }
    if (this.estado != null) {
      data['estado'] = this.estado!.toJson();
    }
    data['enabled'] = this.enabled;
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['fotoUrl'] = this.fotoUrl;
    return data;
  }

  @override
  String toString() {
    return 'UsuarioModel(id: $id, criado: $criado, modificado: $modificado, nome: $nome, email: $email, telefone: $telefone, rua: $rua, bairro: $bairro, numero: $numero, cep: $cep, avaliacao: $avaliacao, qtdeTicketDisponivel: $qtdeTicketDisponivel, cidade: $cidade, estado: $estado, enabled: $enabled, credentialsNonExpired: $credentialsNonExpired, accountNonExpired: $accountNonExpired, accountNonLocked: $accountNonLocked, fotoUrl: $fotoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.rua == rua &&
        other.bairro == bairro &&
        other.numero == numero &&
        other.cep == cep &&
        other.avaliacao == avaliacao &&
        other.qtdeTicketDisponivel == qtdeTicketDisponivel &&
        other.cidade == cidade &&
        other.estado == estado &&
        other.enabled == enabled &&
        other.credentialsNonExpired == credentialsNonExpired &&
        other.accountNonExpired == accountNonExpired &&
        other.accountNonLocked == accountNonLocked &&
        other.fotoUrl == fotoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        nome.hashCode ^
        email.hashCode ^
        telefone.hashCode ^
        rua.hashCode ^
        bairro.hashCode ^
        numero.hashCode ^
        cep.hashCode ^
        avaliacao.hashCode ^
        qtdeTicketDisponivel.hashCode ^
        cidade.hashCode ^
        estado.hashCode ^
        enabled.hashCode ^
        credentialsNonExpired.hashCode ^
        accountNonExpired.hashCode ^
        accountNonLocked.hashCode ^
        fotoUrl.hashCode;
  }
}
