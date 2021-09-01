import 'package:dogwalker/repositories/qualificacao_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/qualificacao_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:flutter/material.dart';

class QualificacaoController {
  final formKey = GlobalKey<FormState>();
  final authController = AuthController();
  final qualificacaoRepository = QualificacaoRepository();

  List<QualificacaoModel> qualificacoes = [];
  UsuarioLogadoModel usuario = UsuarioLogadoModel();
  QualificacaoModel qualificacao = QualificacaoModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  List<String> modalidades = [
    "Graduação",
    "Técnico",
    "Pós-Graduação",
    "Mestrado",
    "Curso",
    "Workshop",
  ];

  void onChange({
    String? titulo,
    String? modalidade,
    String? descricao,
  }) {
    qualificacao = qualificacao.copyWith(
      titulo: titulo,
      modalidade: modalidade,
      descricao: descricao,
    );
  }

  Future buscarQualificacoes() async {
    try {
      state.value = StateEnum.loading;
      usuario = await authController.obterSessao();
      qualificacoes = await qualificacaoRepository.buscarPorDogwalker(
        usuario.id!,
      );
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  Future<String?> adicionarQualificacao() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        state.value = StateEnum.loading;
        String? response = await qualificacaoRepository.cadastrar(qualificacao);
        state.value = StateEnum.success;
        return response;
      } catch (e) {
        state.value = StateEnum.error;
      }
    }
    return "invalid";
  }

  Future buscarQualificacao(int id) async {
    try {
      state.value = StateEnum.loading;
      qualificacao = await qualificacaoRepository.buscarPorId(id);
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  Future<bool> deletarQualificacao(int id) async {
    try {
      state.value = StateEnum.loading;
      bool response = await qualificacaoRepository.deletar(id);
      state.value = StateEnum.success;
      return response;
    } catch (e) {
      state.value = StateEnum.error;
      return false;
    }
  }

  Future<String?> alterarQualificacao(int id) async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        qualificacao.id = id;
        state.value = StateEnum.loading;
        String? response = await qualificacaoRepository.alterar(qualificacao);
        state.value = StateEnum.success;
        return response;
      } catch (e) {
        state.value = StateEnum.error;
      }
    }
    return "invalid";
  }
}
