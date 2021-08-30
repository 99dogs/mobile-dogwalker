import 'package:dogwalker/repositories/saldo_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/saldo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class SaldoController {
  final saldoRepository = SaldoRepository();
  final state = ValueNotifier<StateEnum>(StateEnum.start);

  List<SaldoModel> saldos = [];

  getFormatedDate(_date) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return outputFormat.format(inputDate).toString();
  }

  Future buscarTodos() async {
    try {
      state.value = StateEnum.loading;
      saldos = await saldoRepository.buscarTodos();
      state.value = StateEnum.success;
    } catch (e) {
      print(e);
      state.value = StateEnum.error;
    }
  }
}
