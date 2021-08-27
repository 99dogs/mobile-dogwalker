import 'package:dogwalker/repositories/qualificacao_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/qualificacao_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:flutter/material.dart';

class QualificacaoController {
  final authController = AuthController();
  final qualificacaoRepository = QualificacaoRepository();
  List<QualificacaoModel> qualificacoes = [];
  UsuarioLogadoModel usuario = UsuarioLogadoModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  Future buscarQualificacoes() async {
    try {
      state.value = StateEnum.loading;
      usuario = await authController.obterSessao();
      qualificacoes = await qualificacaoRepository.buscarPorDogwalker(
        usuario.id!,
      );
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }
}
