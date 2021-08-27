import 'dart:convert';

import 'package:flutter/foundation.dart';

class ResponseDataModel {
  final bool temErro;
  final String mensagem;

  ResponseDataModel({
    required this.temErro,
    required this.mensagem,
  });

  ResponseDataModel copyWith({
    bool? temErro,
    String? mensagem,
    Map? conteudo,
  }) {
    return ResponseDataModel(
      temErro: temErro ?? this.temErro,
      mensagem: mensagem ?? this.mensagem,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temErro': temErro,
      'mensagem': mensagem,
    };
  }

  factory ResponseDataModel.fromMap(Map<String, dynamic> map) {
    return ResponseDataModel(
      temErro: map['temErro'],
      mensagem: map['mensagem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseDataModel.fromJson(String source) =>
      ResponseDataModel.fromMap(json.decode(source));

  @override
  String toString() => 'ResponseData(temErro: $temErro, mensagem: $mensagem)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseDataModel &&
        other.temErro == temErro &&
        other.mensagem == mensagem;
  }

  @override
  int get hashCode => temErro.hashCode ^ mensagem.hashCode;
}
