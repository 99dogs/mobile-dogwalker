import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dogwalker/repositories/usuario_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/models/usuario_registro_model.dart';

class RegisterController {
  final _usuarioRepository = UsuarioRepository();
  final formKey = GlobalKey<FormState>();
  final authController = AuthController();

  UsuarioRegistroModel model = UsuarioRegistroModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  void onChange({
    String? nome,
    String? email,
    String? senha,
  }) {
    model = model.copyWith(
      nome: nome,
      email: email,
      senha: senha,
      tipo: "dogwalker",
    );
  }

  String? validarNome(String? value) =>
      value?.isEmpty ?? true ? "O campo nome não poder vazio." : null;

  String? validarEmail(String? value) =>
      value?.isEmpty ?? true ? "O campo e-mail não poder vazio." : null;

  String? validarSenha(String? value) =>
      value?.isEmpty ?? true ? "O campo senha não pode ser vazio." : null;

  Future<void> autenticar(BuildContext context) async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        errorException.value = "";
        state.value = StateEnum.loading;
        UsuarioLogadoModel usuario = await _usuarioRepository.registrar(model);
        await authController.salvarSessao(usuario);
        state.value = StateEnum.success;
        Navigator.pushReplacementNamed(context, "/home");
      } catch (e) {
        state.value = StateEnum.error;
        errorException.value = e.toString();
        throw (e);
      }
    }
  }

  void validarSessao(BuildContext context) async {
    UsuarioLogadoModel usuario = UsuarioLogadoModel();
    usuario = await authController.obterSessao();
    await _delay();

    try {
      if (usuario.token!.isNotEmpty) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/signin");
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, "/signin");
    }
  }

  void encerrarSessao(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("usuario")) {
      await instance.setString("usuario", "");
      Navigator.pushReplacementNamed(context, "/signin");
    }
  }

  Future<void> _delay() async {
    await Future.delayed(Duration(seconds: 3));
  }

  String termos =
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
}
