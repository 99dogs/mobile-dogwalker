import 'dart:convert';

class UsuarioSocialLogin {
  String nome;
  String email;
  String socialId;
  String fotoUrl;
  String tipo;
  UsuarioSocialLogin({
    required this.nome,
    required this.email,
    required this.socialId,
    required this.fotoUrl,
    required this.tipo,
  });

  UsuarioSocialLogin copyWith({
    String? nome,
    String? email,
    String? socialId,
    String? fotoUrl,
    String? tipo,
  }) {
    return UsuarioSocialLogin(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      socialId: socialId ?? this.socialId,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'socialId': socialId,
      'fotoUrl': fotoUrl,
      'tipo': tipo,
    };
  }

  factory UsuarioSocialLogin.fromMap(Map<String, dynamic> map) {
    return UsuarioSocialLogin(
      nome: map['nome'],
      email: map['email'],
      socialId: map['socialId'],
      fotoUrl: map['fotoUrl'],
      tipo: map['tipo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioSocialLogin.fromJson(String source) =>
      UsuarioSocialLogin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UsuarioSocialLogin(nome: $nome, email: $email, socialId: $socialId, fotoUrl: $fotoUrl, tipo: $tipo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioSocialLogin &&
        other.nome == nome &&
        other.email == email &&
        other.socialId == socialId &&
        other.fotoUrl == fotoUrl &&
        other.tipo == tipo;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        email.hashCode ^
        socialId.hashCode ^
        fotoUrl.hashCode ^
        tipo.hashCode;
  }
}
