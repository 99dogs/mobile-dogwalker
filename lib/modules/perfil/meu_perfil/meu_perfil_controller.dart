import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dogwalker/repositories/cidade_repository.dart';
import 'package:dogwalker/repositories/estado_repository.dart';
import 'package:dogwalker/repositories/usuario_repository.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/cidade_model.dart';
import 'package:dogwalker/shared/models/estado_model.dart';
import 'package:dogwalker/shared/models/usuario_alterar_dados_model.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/models/usuario_model.dart';

class MeuPerfilController {
  final formKey = GlobalKey<FormState>();
  final authController = AuthController();
  final usuarioRepository = UsuarioRepository();
  final estadoRepository = EstadoRepository();
  final cidadeRepository = CidadeRepository();
  UsuarioModel usuario = UsuarioModel();
  UsuarioAlterarDadosModel usuarioAlterarDados = UsuarioAlterarDadosModel();
  CidadeModel cidade = CidadeModel();
  EstadoModel estado = EstadoModel();
  List<EstadoModel> estados = [];
  List<CidadeModel> cidades = [];

  final state = ValueNotifier<MeuPerfilFormState>(MeuPerfilFormState.start);
  final estadoIdAlterado = ValueNotifier<bool>(false);
  final errorException = ValueNotifier<String>("");

  Future obterDados() async {
    state.value = MeuPerfilFormState.loading;
    try {
      usuario = await usuarioRepository.buscarMinhasInformacoes();
      await buscarEstados();

      cidades = [];
      cidades.add(usuario.cidade!);

      state.value = MeuPerfilFormState.success;
    } catch (e) {
      state.value = MeuPerfilFormState.error;
      print(e);
    }
  }

  Future buscarEstados() async {
    estadoIdAlterado.value = false;
    estados = await estadoRepository.buscarTodos();
    estadoIdAlterado.value = true;
  }

  Future buscarCidades(int estadoId) async {
    cidades = [];
    try {
      estadoIdAlterado.value = false;
      cidades = await cidadeRepository.buscarCidadesPorEstado(
        estadoId,
      );
      estadoIdAlterado.value = true;
    } catch (e) {
      print(e);
    }
  }

  void onChange({
    String? nome,
    String? email,
    String? telefone,
    String? rua,
    String? numero,
    String? bairro,
    String? cep,
    EstadoModel? estado,
    CidadeModel? cidade,
  }) {
    usuario = usuario.copyWith(
      nome: nome,
      email: email,
      telefone: telefone,
      rua: rua,
      numero: numero,
      bairro: bairro,
      cep: cep,
      estado: estado,
      cidade: cidade,
    );
  }

  Future alterarMinhasInformacoes() async {
    errorException.value = "";

    try {
      usuarioAlterarDados = usuarioAlterarDados.copyWith(
        nome: usuario.nome,
        telefone: usuario.telefone,
        rua: usuario.rua,
        bairro: usuario.bairro,
        estadoId: usuario.estado!.id,
        cidadeId: usuario.cidade!.id,
        numero: usuario.numero,
        cep: usuario.cep,
      );

      state.value = MeuPerfilFormState.loading;
      await usuarioRepository.alterarMinhasInformacoes(usuarioAlterarDados);
      await atualizarSessao(usuarioAlterarDados);
      state.value = MeuPerfilFormState.success;
    } catch (e) {
      state.value = MeuPerfilFormState.error;
      errorException.value = e.toString();
    }
  }

  Future atualizarSessao(UsuarioAlterarDadosModel usuario) async {
    UsuarioLogadoModel usuarioSalvo = await authController.obterSessao();
    UsuarioLogadoModel usuarioAtualizado = UsuarioLogadoModel(
      id: usuarioSalvo.id,
      nome: usuario.nome,
      token: usuarioSalvo.token,
    );
    await authController.salvarSessao(usuarioAtualizado);
  }
}

enum MeuPerfilFormState { start, loading, success, error }
