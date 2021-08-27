import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/passeio_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/passeio_model.dart';
import 'package:intl/intl.dart';

class MeusPasseiosController {
  final _passeioRepository = PasseioRepository();
  List<PasseioModel> passeios = [];

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  getFormatedDate(_date) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy\nHH:mm');
    return outputFormat.format(inputDate).toString();
  }

  Future buscarTodos() async {
    try {
      state.value = StateEnum.loading;
      passeios = await _passeioRepository.buscarTodos();
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
      errorException.value = e.toString();
    }
  }
}
