import 'package:dogwalker/repositories/saldo_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/saldo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class SaldoController {
  final saldoRepository = SaldoRepository();
  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  List<SaldoModel> saldos = [];
  double totalSaldo = 0;

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

      saldos.forEach((element) {
        totalSaldo += element.unitario;
      });

      state.value = StateEnum.success;
    } catch (e) {
      print(e);
      state.value = StateEnum.error;
    }
  }

  Future<String?> solicitarDeposito() async {
    try {
      state.value = StateEnum.loading;
      String? response = await saldoRepository.solicitarDeposito();
      state.value = StateEnum.success;
      return response;
    } catch (e) {
      print(e);
      state.value = StateEnum.error;
    }
  }
}
