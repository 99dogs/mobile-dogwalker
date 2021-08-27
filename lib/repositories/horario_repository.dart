import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/disponibilidade_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';

class HorarioRepository {
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

  Future<bool> verificarDisponibilidade(
      DisponibilidadeModel disponibilidade) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/horario/disponibilidade",
      );

      var response = await _client.post(
        url,
        headers: await this.headers(),
        body: jsonEncode(disponibilidade),
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        return false;
      }
    } catch (e) {
      throw (e);
    }
  }
}
