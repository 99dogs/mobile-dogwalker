import 'dart:convert';

class UsuarioLogin {
  final String? email;
  final String? senha;

  UsuarioLogin({
    this.email,
    this.senha,
  });

  UsuarioLogin copyWith({
    String? email,
    String? senha,
  }) {
    return UsuarioLogin(
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha': senha,
    };
  }

  factory UsuarioLogin.fromMap(Map<String, dynamic> map) {
    return UsuarioLogin(
      email: map['email'],
      senha: map['senha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioLogin.fromJson(String source) =>
      UsuarioLogin.fromMap(json.decode(source));

  @override
  String toString() => 'UsuarioLogin(email: $email, senha: $senha)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioLogin &&
        other.email == email &&
        other.senha == senha;
  }

  @override
  int get hashCode => email.hashCode ^ senha.hashCode;
}
