import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/passeio_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/passeio_model.dart';
import 'package:intl/intl.dart';

class PasseioDetalhesController {
  PasseioRepository passeioRepository = PasseioRepository();
  PasseioModel passeio = PasseioModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  formatarData(_date) {
    if (_date == null) return "";
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return outputFormat.format(inputDate).toString();
  }

  Future init(int passeioId) async {
    try {
      state.value = StateEnum.loading;
      passeio = await passeioRepository.buscarPorId(passeioId);
      state.value = StateEnum.success;
    } catch (e) {
      print(e);
      state.value = StateEnum.error;
    }
  }
}
