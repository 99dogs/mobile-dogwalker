import 'package:dogwalker/modules/deposito/meus_depositos/meus_depositos_page.dart';
import 'package:dogwalker/modules/horario/meus_horarios/meus_horarios_page.dart';
import 'package:dogwalker/modules/saldo/meu_saldo/meu_saldo_page.dart';
import 'package:flutter/material.dart';
import 'package:dogwalker/modules/agenda/agenda_page.dart';
import 'package:dogwalker/modules/home/home_page.dart';
import 'package:dogwalker/modules/login/login_page.dart';
import 'package:dogwalker/modules/passeio/meus_passeios/meus_passeios_page.dart';
import 'package:dogwalker/modules/passeio/passeio_detalhes/passeio_detalhes_page.dart';
import 'package:dogwalker/modules/perfil/meu_perfil/meu_perfil_page.dart';
import 'package:dogwalker/modules/register/register_page.dart';
import 'package:dogwalker/modules/signin/signin_page.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';

class AppWdiget extends StatelessWidget {
  const AppWdiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "99Dogs - Dog walker",
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: "/signin",
      home: AgendaPage(),
      routes: {
        "/signin": (context) => SignInPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/perfil": (context) => MeuPerfilPage(),
        "/agenda": (context) => AgendaPage(),
        "/passeio/list": (context) => MeusPasseiosPage(),
        "/passeio/detail": (context) => PasseioDetalhesPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/horario/list": (context) => MeusHorariosPage(),
        "/saldo/list": (context) => MeuSaldoPage(),
        "/deposito/list": (context) => MeusDepositosPage(),
      },
    );
  }
}
