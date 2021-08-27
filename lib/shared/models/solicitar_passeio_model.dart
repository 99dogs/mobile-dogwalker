import 'package:flutter/foundation.dart';

class SolicitarPasseioModel {
  String? datahora;
  int? dogwalkerId;
  List<dynamic>? cachorrosIds = [];

  SolicitarPasseioModel({
    this.datahora,
    this.dogwalkerId,
    this.cachorrosIds,
  });

  SolicitarPasseioModel.fromJson(Map<String, dynamic> json) {
    datahora = json['datahora'];
    dogwalkerId = json['dogwalkerId'];
    cachorrosIds = json['cachorrosIds'].cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datahora'] = this.datahora;
    data['dogwalkerId'] = this.dogwalkerId;
    data['cachorrosIds'] = this.cachorrosIds;
    return data;
  }

  SolicitarPasseioModel copyWith({
    String? datahora,
    int? dogwalkerId,
    List<dynamic>? cachorrosIds,
  }) {
    return SolicitarPasseioModel(
      datahora: datahora ?? this.datahora,
      dogwalkerId: dogwalkerId ?? this.dogwalkerId,
      cachorrosIds: cachorrosIds ?? this.cachorrosIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'datahora': datahora,
      'dogwalkerId': dogwalkerId,
      'cachorrosIds': cachorrosIds,
    };
  }

  factory SolicitarPasseioModel.fromMap(Map<String, dynamic> map) {
    return SolicitarPasseioModel(
      datahora: map['datahora'],
      dogwalkerId: map['dogwalkerId'],
      cachorrosIds: List<dynamic>.from(map['cachorrosIds']),
    );
  }

  @override
  String toString() =>
      'SolicitarPasseioModel(datahora: $datahora, dogwalkerId: $dogwalkerId, cachorrosIds: $cachorrosIds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SolicitarPasseioModel &&
        other.datahora == datahora &&
        other.dogwalkerId == dogwalkerId &&
        listEquals(other.cachorrosIds, cachorrosIds);
  }

  @override
  int get hashCode =>
      datahora.hashCode ^ dogwalkerId.hashCode ^ cachorrosIds.hashCode;
}
