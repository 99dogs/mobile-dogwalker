import 'package:flutter/material.dart';

class HomeController {
  static final HomeController _controller = HomeController._internal();

  factory HomeController() {
    return _controller;
  }

  HomeController._internal();

  final paginaAtual = ValueNotifier<int>(2);

  mudarDePagina(index) {
    paginaAtual.value = index;
  }
}
