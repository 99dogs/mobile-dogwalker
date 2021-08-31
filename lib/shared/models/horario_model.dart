class HorarioModel {
  int? diaSemana;
  String? nome;

  HorarioModel({this.diaSemana, this.nome});

  HorarioModel.fromJson(Map<String, dynamic> json) {
    diaSemana = json['diaSemana'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diaSemana'] = this.diaSemana;
    data['nome'] = this.nome;
    return data;
  }
}
