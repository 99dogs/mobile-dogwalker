import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/cachorro_repository.dart';
import 'package:dogwalker/repositories/porte_repository.dart';
import 'package:dogwalker/repositories/raca_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/cachorro_model.dart';
import 'package:dogwalker/shared/models/porte_model.dart';
import 'package:dogwalker/shared/models/raca_model.dart';

class CadastrarCaoController {
  final formKey = GlobalKey<FormState>();
  final porteRepository = PorteRepository();
  final racaRepository = RacaRepository();
  final cachorroRepository = CachorroRepository();
  CachorroModel model = CachorroModel();

  List<RacaModel> racas = [];
  List<PorteModel> portes = [];

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  void onChanged({
    String? nome,
    DateTime? dataNascimento,
    PorteModel? porte,
    int? porteId,
    RacaModel? raca,
    int? racaId,
    String? comportamento,
  }) {
    model = model.copyWith(
      nome: nome,
      dataNascimento: dataNascimento,
      porte: porte,
      porteId: porteId,
      raca: raca,
      racaId: racaId,
      comportamento: comportamento,
    );
  }

  Future init() async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      portes = await porteRepository.buscarTodos();
      racas = await racaRepository.buscarTodos();
      state.value = StateEnum.success;
    } catch (e) {
      errorException.value = e.toString();
      state.value = StateEnum.error;
    }
  }

  Future<String?> cadastrar() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        return await cachorroRepository.cadastrar(model);
      } catch (e) {
        return e.toString();
      }
    }
  }
}
