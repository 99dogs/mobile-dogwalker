import 'package:dogwalker/modules/passeio/maps_widget/maps_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/passeio_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/passeio_model.dart';
import 'package:intl/intl.dart';

class PasseioDetalhesController {
  final mapsController = MapsController();
  PasseioRepository passeioRepository = PasseioRepository();
  PasseioModel passeio = PasseioModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final stateAlterarStatus = ValueNotifier<StateEnum>(StateEnum.start);

  String cachorros = "";

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

      if (cachorros == "") {
        if (passeio.cachorros != null && passeio.cachorros!.length > 0) {
          passeio.cachorros!.forEach((element) {
            cachorros = cachorros + element.nome! + ",";
          });
          cachorros = cachorros.substring(0, cachorros.length - 1);
        }
      }

      state.value = StateEnum.success;
    } catch (e) {
      print(e);
      state.value = StateEnum.error;
    }
  }

  Future<String?> alterarStatus(int id, String novoStatus) async {
    try {
      if (novoStatus == "iniciar") {
        bool localizacaoHabilitado = await mapsController.serviceEnabled();
        bool localizacaoPermitida = await mapsController.permissionGranted();

        if (localizacaoHabilitado == false) {
          throw ("Para iniciar, é necesssário ligar o GPS.");
        }

        if (localizacaoPermitida == false) {
          throw ("Para iniciar, é necesssário permitir o acesso ao GPS.");
        }
      }

      stateAlterarStatus.value = StateEnum.loading;

      String? response = await passeioRepository.alterarStatus(
        id,
        novoStatus,
      );
      stateAlterarStatus.value = StateEnum.success;
      return response;
    } catch (e) {
      stateAlterarStatus.value = StateEnum.error;
      return e.toString();
    }
  }
}
