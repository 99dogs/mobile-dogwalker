import 'package:dogwalker/modules/deposito/meus_depositos/meus_depositos_page.dart';
import 'package:dogwalker/modules/horario/meus_horarios/meus_horarios_page.dart';
import 'package:dogwalker/modules/qualificacao/minhas_qualificacoes/minhas_qualificacoes_page.dart';
import 'package:dogwalker/modules/saldo/meu_saldo/meu_saldo_page.dart';
import 'package:flutter/material.dart';
import 'package:dogwalker/modules/agenda/agenda_page.dart';
import 'package:dogwalker/modules/home/home_controller.dart';
import 'package:dogwalker/modules/passeio/meus_passeios/meus_passeios_page.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:dogwalker/shared/widgets/drawer/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final authController = AuthController();
  UsuarioLogadoModel _usuario = UsuarioLogadoModel();

  final pages = [
    MeusPasseiosPage(),
    MeusHorariosPage(),
    AgendaPage(),
    MeuSaldoPage(),
    MeusDepositosPage(),
    MinhasQualificacoesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: FutureBuilder(
            future: authController.obterSessao(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _usuario = snapshot.data as UsuarioLogadoModel;
                String fotoUrl = "";
                if (_usuario.fotoUrl!.isNotEmpty) {
                  fotoUrl = _usuario.fotoUrl!;
                } else {
                  fotoUrl =
                      "https://cdn4.iconfinder.com/data/icons/user-people-2/48/5-512.png";
                }
                return AppBar(
                  elevation: 0,
                  brightness: Brightness.dark,
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: new Icon(Icons.list_sharp),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/perfil",
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.background,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: NetworkImage(fotoUrl),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: AppColors.primary),
          ),
          child: ValueListenableBuilder(
            valueListenable: homeController.paginaAtual,
            builder: (context, value, child) {
              int index = value as int;
              return pages[index];
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          paginaAtual: homeController.paginaAtual.value,
        ),
      ),
    );
  }
}
