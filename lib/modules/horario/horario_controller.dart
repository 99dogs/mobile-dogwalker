import 'package:dogwalker/repositories/configuracao_horario_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/configuracao_horario_model.dart';
import 'package:dogwalker/shared/models/horario_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:flutter/cupertino.dart';

class HorarioController {
  final formKey = GlobalKey<FormState>();
  final authController = AuthController();
  final configuracaoHorarioRepository = ConfiguracaoHorarioRepository();

  List<ConfiguracaoHorarioModel> horarios = [];
  UsuarioLogadoModel usuario = UsuarioLogadoModel();
  ConfiguracaoHorarioModel configHorario = ConfiguracaoHorarioModel();
  List<HorarioModel> listDiaSemanaDisponivel = [];

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  final diasSemana = {
    1: "Segunda-feira",
    2: "Terça-feira",
    3: "Quarta-feira",
    4: "Quinta-feira",
    5: "Sexta-feira",
    6: "Sábado",
    0: "Domingo",
  };

  void onChange({
    int? diaSemana,
    String? horaInicio,
    String? horaFinal,
  }) {
    if (horaInicio != null && horaInicio.length == 6) {
      horaInicio = horaInicio.substring(0, horaInicio.length - 1) + ":00";
    } else if (horaInicio != null) {
      horaInicio = horaInicio + ":00";
    }

    if (horaFinal != null && horaFinal.length == 6) {
      horaFinal = horaFinal.substring(0, horaFinal.length - 1) + ":00";
    } else if (horaFinal != null) {
      horaFinal = horaFinal + ":00";
    }

    configHorario = configHorario.copyWith(
      diaSemana: diaSemana,
      horaInicio: horaInicio,
      horaFinal: horaFinal,
    );
  }

  void listaHorarioDisponivel() {
    diasSemana.forEach((key, value) {
      HorarioModel horario = HorarioModel(
        diaSemana: key,
        nome: value,
      );
      listDiaSemanaDisponivel.add(horario);
    });

    horarios.forEach((horario) {
      int index = listDiaSemanaDisponivel.indexWhere(
        (e) => e.diaSemana == horario.diaSemana,
      );
      listDiaSemanaDisponivel.removeAt(index);
    });
  }

  Future buscarHorarios() async {
    try {
      state.value = StateEnum.loading;
      usuario = await authController.obterSessao();
      horarios = await configuracaoHorarioRepository.buscarPorDogwalker(
        usuario.id!,
      );
      listaHorarioDisponivel();
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  Future<String?> adicionarNovoHorario() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        state.value = StateEnum.loading;
        String? response = await configuracaoHorarioRepository.cadastrar(
          configHorario,
        );
        state.value = StateEnum.success;
        return response;
      } catch (e) {
        state.value = StateEnum.start;
        return e.toString();
      }
    }
    return "invalid";
  }

  Future buscarHorario(int id) async {
    try {
      state.value = StateEnum.loading;
      configHorario = await configuracaoHorarioRepository.buscarPorId(id);
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  Future<bool> deletarHorario(int id) async {
    try {
      state.value = StateEnum.loading;
      bool response = await configuracaoHorarioRepository.deletar(id);
      state.value = StateEnum.success;
      return response;
    } catch (e) {
      state.value = StateEnum.error;
      return false;
    }
  }

  Future<String?> alterarHorario() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        state.value = StateEnum.loading;
        String? response = await configuracaoHorarioRepository.alterar(
          configHorario,
        );
        state.value = StateEnum.success;
        return response;
      } catch (e) {
        state.value = StateEnum.start;
        return e.toString();
      }
    }
    return "invalid";
  }
}
