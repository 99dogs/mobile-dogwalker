import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/configuracao_horario_model.dart';
import 'package:dogwalker/shared/models/response_data_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';

class ConfiguracaoHorarioRepository {
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

  Future<List<ConfiguracaoHorarioModel>> buscarPorDogwalker(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi +
            "/api/v1/configuracao-horario/dogwalker/" +
            id.toString(),
      );
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        List<ConfiguracaoHorarioModel> horarios =
            (jsonDecode(response.body) as List)
                .map((data) => ConfiguracaoHorarioModel.fromJson(data))
                .toList();

        return horarios;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<String?> cadastrar(ConfiguracaoHorarioModel horario) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/configuracao-horario",
      );

      var response = await _client.post(
        url,
        headers: await this.headers(),
        body: jsonEncode(horario),
      );

      if (response.statusCode == 200) {
        return "";
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<ConfiguracaoHorarioModel> buscarPorId(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/configuracao-horario/$id",
      );

      var response = await _client.get(
        url,
        headers: await this.headers(),
      );

      ConfiguracaoHorarioModel horario = ConfiguracaoHorarioModel.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        return horario;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> deletar(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/configuracao-horario/$id",
      );

      var response = await _client.delete(
        url,
        headers: await this.headers(),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<String?> alterar(ConfiguracaoHorarioModel horario) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/configuracao-horario/" + horario.id.toString(),
      );

      var response = await _client.put(
        url,
        headers: await this.headers(),
        body: jsonEncode(horario),
      );

      if (response.statusCode == 200) {
        return "";
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }
}
