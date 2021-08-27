import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/cachorro_repository.dart';
import 'package:dogwalker/repositories/porte_repository.dart';
import 'package:dogwalker/repositories/raca_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/cachorro_model.dart';
import 'package:dogwalker/shared/models/porte_model.dart';
import 'package:dogwalker/shared/models/raca_model.dart';

class AlterarCaoController {
  final formKey = GlobalKey<FormState>();
  final porteRepository = PorteRepository();
  final racaRepository = RacaRepository();
  final cachorroRepository = CachorroRepository();
  CachorroModel cachorro = CachorroModel();

  List<RacaModel> racas = [];
  List<PorteModel> portes = [];

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  void onChanged({
    int? id,
    String? nome,
    DateTime? dataNascimento,
    PorteModel? porte,
    int? porteId,
    RacaModel? raca,
    int? racaId,
    String? comportamento,
  }) {
    cachorro = cachorro.copyWith(
      id: id,
      nome: nome,
      dataNascimento: dataNascimento,
      porte: porte,
      porteId: porteId,
      raca: raca,
      racaId: racaId,
      comportamento: comportamento,
    );
  }

  Future init(int id) async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      portes = await porteRepository.buscarTodos();
      racas = await racaRepository.buscarTodos();
      cachorro = await cachorroRepository.buscarPorId(id);
      state.value = StateEnum.success;
    } catch (e) {
      errorException.value = e.toString();
      state.value = StateEnum.error;
    }
  }

  Future<String?> alterar() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        return await cachorroRepository.alterar(cachorro);
      } catch (e) {
        return e.toString();
      }
    }
  }
}
