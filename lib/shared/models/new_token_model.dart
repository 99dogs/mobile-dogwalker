class NewTokenModel {
  int? usuarioId;
  String? token;

  NewTokenModel({this.usuarioId, this.token});

  NewTokenModel.fromJson(Map<String, dynamic> json) {
    usuarioId = json['usuarioId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuarioId'] = this.usuarioId;
    data['token'] = this.token;
    return data;
  }
}
