import 'package:shared_preferences/shared_preferences.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';

class AuthController {
  Future<void> salvarSessao(UsuarioLogadoModel usuario) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("usuario", usuario.toJson());
    return;
  }

  Future<UsuarioLogadoModel> obterSessao() async {
    UsuarioLogadoModel usuario = UsuarioLogadoModel();
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("usuario")) {
      final json = instance.get("usuario") as String;
      if (json.isNotEmpty) {
        usuario = UsuarioLogadoModel.fromJson(json);
      }
    }
    return usuario;
  }
}
