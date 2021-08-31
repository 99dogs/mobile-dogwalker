import 'package:dogwalker/shared/models/forma_de_pagamento_model.dart';

class TicketModel {
  int? id;
  String? criado;
  String? modificado;
  int? quantidade;
  double? unitario;
  double? total;
  bool? pendente;
  bool? cancelado;
  bool? pago;
  String? faturaId;
  String? faturaUrl;
  int? formaDePagamentoId;
  int? usuarioId;
  FormaDePagamentoModel? formaDePagamento;
  String? cpfPagador;

  TicketModel({
    this.id,
    this.criado,
    this.modificado,
    this.quantidade,
    this.unitario,
    this.total,
    this.pendente,
    this.cancelado,
    this.pago,
    this.faturaId,
    this.faturaUrl,
    this.formaDePagamentoId,
    this.usuarioId,
    this.formaDePagamento,
    this.cpfPagador,
  });

  TicketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criado = json['criado'];
    modificado = json['modificado'];
    quantidade = json['quantidade'];
    unitario = json['unitario'];
    total = json['total'];
    pendente = json['pendente'];
    cancelado = json['cancelado'];
    pago = json['pago'];
    faturaId = json['faturaId'];
    faturaUrl = json['faturaUrl'];
    formaDePagamentoId = json['formaDePagamentoId'];
    usuarioId = json['usuarioId'];
    formaDePagamento = json['formaDePagamento'] != null
        ? new FormaDePagamentoModel.fromJson(json['formaDePagamento'])
        : null;
    cpfPagador = json['cpfPagador'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['criado'] = this.criado;
    data['modificado'] = this.modificado;
    data['quantidade'] = this.quantidade;
    data['unitario'] = this.unitario;
    data['total'] = this.total;
    data['pendente'] = this.pendente;
    data['cancelado'] = this.cancelado;
    data['pago'] = this.pago;
    data['faturaId'] = this.faturaId;
    data['faturaUrl'] = this.faturaUrl;
    data['formaDePagamentoId'] = this.formaDePagamentoId;
    data['usuarioId'] = this.usuarioId;
    if (this.formaDePagamento != null) {
      data['formaDePagamento'] = this.formaDePagamento!.toJson();
    }
    data['cpfPagador'] = this.cpfPagador;
    return data;
  }

  TicketModel copyWith({
    int? id,
    String? criado,
    String? modificado,
    int? quantidade,
    double? unitario,
    double? total,
    bool? pendente,
    bool? cancelado,
    bool? pago,
    String? faturaId,
    String? faturaUrl,
    int? formaDePagamentoId,
    int? usuarioId,
    FormaDePagamentoModel? formaDePagamento,
    String? cpfPagador,
  }) {
    return TicketModel(
      id: id ?? this.id,
      criado: criado ?? this.criado,
      modificado: modificado ?? this.modificado,
      quantidade: quantidade ?? this.quantidade,
      unitario: unitario ?? this.unitario,
      total: total ?? this.total,
      pendente: pendente ?? this.pendente,
      cancelado: cancelado ?? this.cancelado,
      pago: pago ?? this.pago,
      faturaId: faturaId ?? this.faturaId,
      faturaUrl: faturaUrl ?? this.faturaUrl,
      formaDePagamentoId: formaDePagamentoId ?? this.formaDePagamentoId,
      usuarioId: usuarioId ?? this.usuarioId,
      formaDePagamento: formaDePagamento ?? this.formaDePagamento,
      cpfPagador: cpfPagador ?? this.cpfPagador,
    );
  }

  String? validarQuantidade(String? value) {
    if (value!.isEmpty) {
      return "A quantidade não pode ser vazio";
    }
    var qtde = int.parse(value);
    if (qtde.isNaN || qtde == 0) {
      return "A quantidade não pode ser vazio";
    } else if (qtde.isNegative || qtde == 0) {
      return "A quantidade não pode ser menor ou igual a zero";
    } else {
      return null;
    }
  }

  String? validarCpf(String? value) =>
      value?.isEmpty ?? true ? "O CPF não pode ser vazio" : null;

  String? validarFormaPagamento(FormaDePagamentoModel? value) =>
      value?.nome!.isEmpty ?? true ? "O CPF não pode ser vazio" : null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado': criado,
      'modificado': modificado,
      'quantidade': quantidade,
      'unitario': unitario,
      'total': total,
      'pendente': pendente,
      'cancelado': cancelado,
      'pago': pago,
      'faturaId': faturaId,
      'faturaUrl': faturaUrl,
      'formaDePagamentoId': formaDePagamentoId,
      'usuarioId': usuarioId,
      'formaDePagamento': formaDePagamento?.toMap(),
      'cpfPagador': cpfPagador,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'],
      criado: map['criado'],
      modificado: map['modificado'],
      quantidade: map['quantidade'],
      unitario: map['unitario'],
      total: map['total'],
      pendente: map['pendente'],
      cancelado: map['cancelado'],
      pago: map['pago'],
      faturaId: map['faturaId'],
      faturaUrl: map['faturaUrl'],
      formaDePagamentoId: map['formaDePagamentoId'],
      usuarioId: map['usuarioId'],
      formaDePagamento: FormaDePagamentoModel.fromMap(map['formaDePagamento']),
      cpfPagador: map['cpfPagador'],
    );
  }

  @override
  String toString() {
    return 'TicketModel(id: $id, criado: $criado, modificado: $modificado, quantidade: $quantidade, unitario: $unitario, total: $total, pendente: $pendente, cancelado: $cancelado, pago: $pago, faturaId: $faturaId, faturaUrl: $faturaUrl, formaDePagamentoId: $formaDePagamentoId, usuarioId: $usuarioId, formaDePagamento: $formaDePagamento, cpfPagador: $cpfPagador)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TicketModel &&
        other.id == id &&
        other.criado == criado &&
        other.modificado == modificado &&
        other.quantidade == quantidade &&
        other.unitario == unitario &&
        other.total == total &&
        other.pendente == pendente &&
        other.cancelado == cancelado &&
        other.pago == pago &&
        other.faturaId == faturaId &&
        other.faturaUrl == faturaUrl &&
        other.formaDePagamentoId == formaDePagamentoId &&
        other.usuarioId == usuarioId &&
        other.formaDePagamento == formaDePagamento &&
        other.cpfPagador == cpfPagador;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        criado.hashCode ^
        modificado.hashCode ^
        quantidade.hashCode ^
        unitario.hashCode ^
        total.hashCode ^
        pendente.hashCode ^
        cancelado.hashCode ^
        pago.hashCode ^
        faturaId.hashCode ^
        faturaUrl.hashCode ^
        formaDePagamentoId.hashCode ^
        usuarioId.hashCode ^
        formaDePagamento.hashCode ^
        cpfPagador.hashCode;
  }
}
