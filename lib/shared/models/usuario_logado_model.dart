import 'dart:convert';

class UsuarioLogadoModel {
  final int? id;
  final String? nome;
  final String? fotoUrl;
  final String? token;
  UsuarioLogadoModel({
    this.id,
    this.nome,
    this.fotoUrl = "",
    this.token,
  });

  UsuarioLogadoModel copyWith({
    int? id,
    String? nome,
    String? fotoUrl,
    String? token,
  }) {
    return UsuarioLogadoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'fotoUrl': fotoUrl,
      'token': token,
    };
  }

  factory UsuarioLogadoModel.fromMap(Map<String, dynamic> map) {
    return UsuarioLogadoModel(
      id: map['id'],
      nome: map['nome'],
      fotoUrl: map['fotoUrl'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioLogadoModel.fromJson(String source) =>
      UsuarioLogadoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsuarioLogadoModel(id: $id, nome: $nome, fotoUrl: $fotoUrl, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioLogadoModel &&
        other.id == id &&
        other.nome == nome &&
        other.fotoUrl == fotoUrl &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ fotoUrl.hashCode ^ token.hashCode;
  }
}
