import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dogwalker/repositories/usuario_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/models/usuario_social_login_model.dart';

class SigninController {
  final usuarioRepository = UsuarioRepository();
  final authController = AuthController();

  Future<String?> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      final response = await _googleSignIn.signIn();

      if (response == null) {
        _googleSignIn.signOut();
        return "";
      }

      UsuarioSocialLogin usuario = UsuarioSocialLogin(
        nome: response.displayName!,
        email: response.email,
        socialId: response.id,
        fotoUrl: response.photoUrl!,
        tipo: "dogwalker",
      );

      UsuarioLogadoModel usuarioLogado =
          await usuarioRepository.socialLogin(usuario);

      UsuarioLogadoModel usuarioAtualizado = UsuarioLogadoModel(
        id: usuarioLogado.id,
        nome: usuarioLogado.nome,
        token: usuarioLogado.token,
        fotoUrl: response.photoUrl,
      );

      await authController.salvarSessao(usuarioAtualizado);
      await usuarioRepository.atualizarTokenPushNotification();

      Navigator.pushReplacementNamed(context, "/home");
    } catch (error) {
      _googleSignIn.signOut();
      return error.toString();
    }
  }
}
