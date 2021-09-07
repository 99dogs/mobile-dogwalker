import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dogwalker/repositories/usuario_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/models/usuario_model.dart';

class FotoPerfilController {
  final usuarioRepository = UsuarioRepository();
  final authController = AuthController();
  UsuarioModel usuario = UsuarioModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  Future buscarInformacoes() async {
    try {
      state.value = StateEnum.loading;
      usuario = await usuarioRepository.buscarMinhasInformacoes();
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  Future<String?> atualizarFoto(XFile image) async {
    String? newFotoUrl = await usuarioRepository.atualizarFoto(
      usuario.id!,
      image,
    );

    if (newFotoUrl != null) {
      usuario = await usuarioRepository.buscarMinhasInformacoes();
      UsuarioLogadoModel usuarioLogado = await authController.obterSessao();
      UsuarioLogadoModel usuarioAtualizado = UsuarioLogadoModel(
        id: usuario.id,
        nome: usuario.nome,
        fotoUrl: usuario.fotoUrl,
        token: usuarioLogado.token,
      );
      await authController.salvarSessao(usuarioAtualizado);
    }

    return newFotoUrl;
  }
}
