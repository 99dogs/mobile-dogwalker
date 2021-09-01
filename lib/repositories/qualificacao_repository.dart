import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/qualificacao_model.dart';
import 'package:dogwalker/shared/models/response_data_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';

class QualificacaoRepository {
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

  Future<List<QualificacaoModel>> buscarPorDogwalker(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/qualificacao/dogwalker/" + id.toString(),
      );
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        List<QualificacaoModel> qualificacoes =
            (jsonDecode(response.body) as List)
                .map((data) => QualificacaoModel.fromJson(data))
                .toList();

        return qualificacoes;
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

  Future<String?> cadastrar(QualificacaoModel qualificacao) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/qualificacao",
      );

      var response = await _client.post(
        url,
        headers: await this.headers(),
        body: jsonEncode(qualificacao),
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

  Future<QualificacaoModel> buscarPorId(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/qualificacao/$id",
      );

      var response = await _client.get(
        url,
        headers: await this.headers(),
      );

      QualificacaoModel qualificacao = QualificacaoModel.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        return qualificacao;
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
        _endpointApi + "/api/v1/qualificacao/$id",
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

  Future<String?> alterar(QualificacaoModel qualificacao) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/qualificacao/" + qualificacao.id.toString(),
      );

      var response = await _client.put(
        url,
        headers: await this.headers(),
        body: jsonEncode(qualificacao),
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
