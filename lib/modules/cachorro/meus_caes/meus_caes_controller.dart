import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/cachorro_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/cachorro_model.dart';

class MeusCaesController {
  static final MeusCaesController _controller = MeusCaesController._internal();

  factory MeusCaesController() {
    return _controller;
  }

  MeusCaesController._internal();

  final cachorroRepository = CachorroRepository();
  List<CachorroModel> cachorros = [];

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  Future buscarTodos() async {
    try {
      state.value = StateEnum.loading;
      cachorros = await cachorroRepository.buscarTodos();
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
      errorException.value = e.toString();
    }
  }
}
