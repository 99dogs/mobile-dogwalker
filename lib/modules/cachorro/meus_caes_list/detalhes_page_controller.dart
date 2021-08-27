import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/cachorro_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/cachorro_model.dart';

class DetalhesPageController {
  final cachorroRepository = CachorroRepository();
  CachorroModel cachorro = CachorroModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  Future buscarPorId(int id) async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      cachorro = await cachorroRepository.buscarPorId(id);
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
      errorException.value = e.toString();
    }
  }

  Future<String?> excluir(int id) async {
    try {
      return await cachorroRepository.excluir(id);
    } catch (e) {
      return e.toString();
    }
  }
}
