import 'dart:convert';

class UsuarioRegistroModel {
  String? nome;
  String? email;
  String? senha;
  String? tipo;

  UsuarioRegistroModel({
    this.nome,
    this.email,
    this.senha,
    this.tipo,
  });

  UsuarioRegistroModel copyWith({
    String? nome,
    String? email,
    String? senha,
    String? tipo,
  }) {
    return UsuarioRegistroModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
    };
  }

  factory UsuarioRegistroModel.fromMap(Map<String, dynamic> map) {
    return UsuarioRegistroModel(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      tipo: map['tipo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioRegistroModel.fromJson(String source) =>
      UsuarioRegistroModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsuarioRegistroModel(nome: $nome, email: $email, senha: $senha, tipo: $tipo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioRegistroModel &&
        other.nome == nome &&
        other.email == email &&
        other.senha == senha &&
        other.tipo == tipo;
  }

  @override
  int get hashCode {
    return nome.hashCode ^ email.hashCode ^ senha.hashCode ^ tipo.hashCode;
  }
}
