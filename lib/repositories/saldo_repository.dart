import 'dart:convert';

import 'package:dogwalker/shared/models/saldo_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/cidade_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';

class SaldoRepository {
  final _endpointApi = dotenv.get('ENDPOINT_API', fallback: '');
  final _authController = AuthController();
  var _client = http.Client();
  String _token = "";

  Future<Map<String, String>> headers() async {
    var headers = Map<String, String>();
    UsuarioLogadoModel usuario = await _authController.obterSessao();

    if (usuario.token != null && usuario.token!.isNotEmpty) {
      _token = usuario.token!;
    }

    if (_token.isEmpty) {
      headers = {"Content-Type": "application/json; charset=utf-8"};
    } else {
      headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Bearer " + _token,
      };
    }

    return headers;
  }

  Future<List<SaldoModel>> buscarTodos() async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/saldo",
      );
      var response = await _client.get(url, headers: await this.headers());

      List<SaldoModel> saldos = (jsonDecode(response.body) as List)
          .map((data) => SaldoModel.fromJson(data))
          .toList();

      return saldos;
    } catch (e) {
      throw Exception(e);
    }
  }
}
