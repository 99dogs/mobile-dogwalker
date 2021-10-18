import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dogwalker/repositories/usuario_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/models/usuario_login_model.dart';

class LoginController {
  final _usuarioRepository = UsuarioRepository();
  final formKey = GlobalKey<FormState>();
  final authController = AuthController();

  UsuarioLogin model = UsuarioLogin();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  void onChange({
    String? email,
    String? senha,
  }) {
    model = model.copyWith(
      email: email,
      senha: senha,
    );
  }

  String? validarEmail(String? value) =>
      value?.isEmpty ?? true ? "O campo e-mail não poder vazio." : null;

  String? validarSenha(String? value) =>
      value?.isEmpty ?? true ? "O campo senha não pode ser vazio." : null;

  void autenticar(BuildContext context) async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        errorException.value = "";
        state.value = StateEnum.loading;
        UsuarioLogadoModel usuario = await _usuarioRepository.login(model);
        await authController.salvarSessao(usuario);
        await _usuarioRepository.atualizarTokenPushNotification();
        state.value = StateEnum.success;
        Navigator.pushReplacementNamed(context, "/home");
      } catch (e) {
        state.value = StateEnum.error;
        errorException.value = e.toString();
        throw (e);
      }
    }
  }

  Future<void> validarSessao(BuildContext context) async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      UsuarioLogadoModel usuario = UsuarioLogadoModel();
      usuario = await authController.obterSessao();

      if (usuario.token != null && usuario.token!.isNotEmpty) {
        // state.value = StateEnum.success;
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        state.value = StateEnum.success;
      }
    } catch (e) {
      state.value = StateEnum.success;
      errorException.value = e.toString();
      throw (e);
    }
  }

  void encerrarSessao(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("usuario")) {
      await instance.setString("usuario", "");
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      _googleSignIn.signOut();
      Navigator.pushReplacementNamed(context, "/signin");
    }
  }
}
