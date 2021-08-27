import 'package:dogwalker/repositories/configuracao_horario_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/configuracao_horario_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:flutter/cupertino.dart';

class HorarioController {
  final authController = AuthController();
  final configuracaoHorarioRepository = ConfiguracaoHorarioRepository();
  List<ConfiguracaoHorarioModel> horarios = [];
  UsuarioLogadoModel usuario = UsuarioLogadoModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  Future buscarHorarios() async {
    try {
      state.value = StateEnum.loading;
      usuario = await authController.obterSessao();
      horarios = await configuracaoHorarioRepository.buscarPorDogwalker(
        usuario.id!,
      );
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }
}
