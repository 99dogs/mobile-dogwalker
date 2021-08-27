class DisponibilidadeModel {
  String datahora = "";
  int usuarioId = 0;

  DisponibilidadeModel({
    required this.datahora,
    required this.usuarioId,
  });

  DisponibilidadeModel.fromJson(Map<String, dynamic> json) {
    datahora = json['datahora'];
    usuarioId = json['usuarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datahora'] = this.datahora;
    data['usuarioId'] = this.usuarioId;
    return data;
  }

  DisponibilidadeModel copyWith({
    String? datahora,
    int? usuarioId,
  }) {
    return DisponibilidadeModel(
      datahora: datahora ?? this.datahora,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'datahora': datahora,
      'usuarioId': usuarioId,
    };
  }

  factory DisponibilidadeModel.fromMap(Map<String, dynamic> map) {
    return DisponibilidadeModel(
      datahora: map['datahora'],
      usuarioId: map['usuarioId'],
    );
  }

  @override
  String toString() =>
      'DisponibilidadeModel(datahora: $datahora, usuarioId: $usuarioId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisponibilidadeModel &&
        other.datahora == datahora &&
        other.usuarioId == usuarioId;
  }

  @override
  int get hashCode => datahora.hashCode ^ usuarioId.hashCode;
}
