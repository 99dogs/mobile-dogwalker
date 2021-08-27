import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/response_data_model.dart';
import 'package:dogwalker/shared/models/usuario_alterar_dados_model.dart';
import 'package:dogwalker/shared/models/usuario_autenticado_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/models/usuario_login_model.dart';
import 'package:dogwalker/shared/models/usuario_model.dart';
import 'package:dogwalker/shared/models/usuario_registro_model.dart';
import 'package:dogwalker/shared/models/usuario_social_login_model.dart';

class UsuarioRepository {
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

  Future<UsuarioLogadoModel> registrar(
      UsuarioRegistroModel usuarioRegistro) async {
    try {
      var url = Uri.parse(_endpointApi + "/api/v1/usuario/registrar");
      var response = await _client.post(
        url,
        body: usuarioRegistro.toJson(),
        headers: await this.headers(),
      );

      if (response.statusCode == 200) {
        UsuarioAutenticadoModel usuarioAutenticado =
            UsuarioAutenticadoModel.fromJson(response.body);

        _token = usuarioAutenticado.token;

        UsuarioLogadoModel usuarioLogado = UsuarioLogadoModel(
          id: usuarioAutenticado.id,
          nome: usuarioRegistro.nome,
          token: _token,
        );

        return usuarioLogado;
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

  Future<UsuarioLogadoModel> login(UsuarioLogin usuarioLogin) async {
    try {
      Map<String, String> headers = await this.headers();

      var url = Uri.parse(_endpointApi + "/api/v1/usuario/login");
      var response = await _client.post(
        url,
        body: usuarioLogin.toJson(),
        headers: headers,
      );

      if (response.statusCode == 200) {
        UsuarioAutenticadoModel usuarioAutenticado =
            UsuarioAutenticadoModel.fromJson(response.body);

        _token = usuarioAutenticado.token;

        UsuarioModel usuario = await buscarMinhasInformacoes();

        if (usuario.tipo == "TUTOR") {
          throw ("Percebemos que você é um tutor, este é um aplicativo dedicado para o dogwalker.");
        }

        UsuarioLogadoModel usuarioLogado = UsuarioLogadoModel(
          id: usuario.id,
          nome: usuario.nome,
          token: _token,
        );

        return usuarioLogado;
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

  Future<UsuarioModel> buscarMinhasInformacoes() async {
    try {
      var url = Uri.parse(_endpointApi + "/api/v1/usuario/me");
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        UsuarioModel usuario = UsuarioModel.fromJson(jsonDecode(response.body));
        return usuario;
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

  Future<void> alterarMinhasInformacoes(
      UsuarioAlterarDadosModel usuario) async {
    try {
      var url = Uri.parse(_endpointApi + "/api/v1/usuario/dados");
      var response = await _client.put(url,
          headers: await this.headers(), body: usuario.toJson());

      if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else if (response.statusCode != 200) {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<UsuarioModel>> buscarDogwalkers() async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/usuario/dogwalker",
      );
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        List<UsuarioModel> dogwalkers = (jsonDecode(response.body) as List)
            .map((data) => UsuarioModel.fromJson(data))
            .toList();

        return dogwalkers;
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

  Future<UsuarioModel> buscarPorId(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/usuario/dogwalker/" + id.toString(),
      );
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        UsuarioModel dogwalker = UsuarioModel.fromJson(
          jsonDecode(response.body),
        );

        return dogwalker;
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

  Future<UsuarioLogadoModel> socialLogin(
      UsuarioSocialLogin usuarioLogin) async {
    try {
      Map<String, String> headers = await this.headers();

      var url = Uri.parse(_endpointApi + "/api/v1/usuario/social-login");
      var response = await _client.post(
        url,
        body: usuarioLogin.toJson(),
        headers: headers,
      );

      if (response.statusCode == 200) {
        UsuarioAutenticadoModel usuarioAutenticado =
            UsuarioAutenticadoModel.fromJson(response.body);

        _token = usuarioAutenticado.token;

        UsuarioModel usuario = await buscarMinhasInformacoes();

        if (usuario.tipo == "TUTOR") {
          throw ("Percebemos que você é um tutor, este é um aplicativo dedicado para o dogwalker.");
        }

        UsuarioLogadoModel usuarioLogado = UsuarioLogadoModel(
          id: usuario.id,
          nome: usuario.nome,
          token: _token,
        );

        return usuarioLogado;
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
