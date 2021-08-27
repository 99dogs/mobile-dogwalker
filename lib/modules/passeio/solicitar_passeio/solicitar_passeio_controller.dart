import 'package:flutter/cupertino.dart';
import 'package:dogwalker/repositories/cachorro_repository.dart';
import 'package:dogwalker/repositories/horario_repository.dart';
import 'package:dogwalker/repositories/passeio_repository.dart';
import 'package:dogwalker/repositories/usuario_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/cachorro_model.dart';
import 'package:dogwalker/shared/models/disponibilidade_model.dart';
import 'package:dogwalker/shared/models/passeio_model.dart';
import 'package:dogwalker/shared/models/solicitar_passeio_model.dart';
import 'package:dogwalker/shared/models/usuario_model.dart';
import 'package:intl/intl.dart';

class SolicitarPasseioController {
  final formKey = GlobalKey<FormState>();

  final usuarioRepository = UsuarioRepository();
  final cachorroRepository = CachorroRepository();
  final horarioRepository = HorarioRepository();
  final passeioRepository = PasseioRepository();

  UsuarioModel dogwalker = UsuarioModel();
  List<CachorroModel> _cachorros = [];
  List<dynamic> listCachorros = [];
  PasseioModel passeio = PasseioModel();
  SolicitarPasseioModel solicitarPasseio = SolicitarPasseioModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  formataDataHora(
    _date,
  ) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return outputFormat.format(inputDate).toString();
  }

  void onChange({
    DateTime? datahora,
    int? dogwalkerId,
    List<dynamic>? cachorrosIds,
  }) {
    passeio = passeio.copyWith(
      datahora: datahora.toString(),
      dogwalkerId: dogwalkerId,
      cachorrosIds: cachorrosIds,
    );
  }

  Future init(int dogwalkerId) async {
    try {
      state.value = StateEnum.loading;
      dogwalker = await usuarioRepository.buscarPorId(dogwalkerId);
      _cachorros = await cachorroRepository.buscarTodos();

      for (var cachorro in _cachorros) {
        listCachorros.add({
          "id": cachorro.id,
          "nome": cachorro.nome,
        });
      }

      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  Future<bool> verificarDisponibilidade(DateTime? datahoraSolicitada) async {
    try {
      String datahora = formataDataHora(datahoraSolicitada.toString());
      DisponibilidadeModel disponibilidade = DisponibilidadeModel(
        datahora: datahora,
        usuarioId: passeio.dogwalkerId!,
      );

      bool disponivel =
          await horarioRepository.verificarDisponibilidade(disponibilidade);
      return disponivel;
    } catch (e) {
      return false;
    }
  }

  Future<PasseioModel?> solicitar() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        solicitarPasseio = solicitarPasseio.copyWith(
          datahora: formataDataHora(passeio.datahora),
          dogwalkerId: passeio.dogwalkerId,
          cachorrosIds: passeio.cachorrosIds,
        );

        PasseioModel novoPasseio = PasseioModel();
        novoPasseio = await passeioRepository.solicitar(solicitarPasseio);

        if (novoPasseio.id == null) {
          throw ("Ocorreu um problema ao solicitar o passeio");
        }

        return novoPasseio;
      } catch (e) {
        throw (e.toString());
      }
    }
  }
}
