class SaldoModel {
  late int id;
  late String criado;
  late String modificado;
  late double unitario;
  late bool depositado;
  late int depositoId;
  late int passeioId;
  late int usuarioId;
  SaldoModel({
    required this.id,
    required this.criado,
    required this.modificado,
    required this.unitario,
    required this.depositado,
    required this.depositoId,
    required this.passeioId,
    required this.usuarioId,
  });

  SaldoModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    double? unitario,
    bool? depositado,
    int? depositoId,
    int? passeioId,
    int? usuarioId,
  }) {
    return SaldoModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      unitario: unitario ?? this.unitario,
      depositado: depositado ?? this.depositado,
      depositoId: depositoId ?? this.depositoId,
      passeioId: passeioId ?? this.passeioId,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'unitario': unitario,
      'depositado': depositado,
      'depositoId': depositoId,
      'passeioId': passeioId,
      'usuarioId': usuarioId,
    };
  }

  factory SaldoModel.fromMap(Map<String, dynamic> map) {
    return SaldoModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      unitario: map['unitario'],
      depositado: map['depositado'],
      depositoId: map['depositoId'],
      passeioId: map['passeioId'],
      usuarioId: map['usuarioId'],
    );
  }

  SaldoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    unitario = json['unitario'];
    depositado = json['depositado'];
    depositoId = json['depositoId'];
    passeioId = json['passeioId'];
    usuarioId = json['usuarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['unitario'] = this.unitario;
    data['depositado'] = this.depositado;
    data['depositoId'] = this.depositoId;
    data['passeioId'] = this.passeioId;
    data['usuarioId'] = this.usuarioId;
    return data;
  }

  @override
  String toString() {
    return 'SaldoModel(id: $id, criado: $criado, modificado: $modificado, unitario: $unitario, depositado: $depositado, depositoId: $depositoId, passeioId: $passeioId, usuarioId: $usuarioId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaldoModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.unitario == unitario &&
        other.depositado == depositado &&
        other.depositoId == depositoId &&
        other.passeioId == passeioId &&
        other.usuarioId == usuarioId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        unitario.hashCode ^
        depositado.hashCode ^
        depositoId.hashCode ^
        passeioId.hashCode ^
        usuarioId.hashCode;
  }
}
