import 'dart:convert';

class UsuarioAutenticadoModel {
  int id;
  String token;
  UsuarioAutenticadoModel({
    required this.id,
    required this.token,
  });

  UsuarioAutenticadoModel copyWith({
    int? id,
    String? token,
  }) {
    return UsuarioAutenticadoModel(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
    };
  }

  factory UsuarioAutenticadoModel.fromMap(Map<String, dynamic> map) {
    return UsuarioAutenticadoModel(
      id: map['id'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioAutenticadoModel.fromJson(String source) =>
      UsuarioAutenticadoModel.fromMap(json.decode(source));

  @override
  String toString() => 'UsuarioAutenticadoModel(id: $id, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsuarioAutenticadoModel &&
        other.id == id &&
        other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ token.hashCode;
}
