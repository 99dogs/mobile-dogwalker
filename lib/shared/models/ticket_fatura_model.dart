class TicketFaturaModel {
  int? ticketId;
  String? cpfPagador;

  TicketFaturaModel({
    this.ticketId,
    this.cpfPagador,
  });

  TicketFaturaModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticketId'];
    cpfPagador = json['cpfPagador'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketId'] = this.ticketId;
    data['cpfPagador'] = this.cpfPagador;
    return data;
  }
}
