import 'package:dogwalker/modules/deposito/meus_depositos/meus_depositos_page.dart';
import 'package:dogwalker/modules/horario/alterar_horario/alterar_horario_page.dart';
import 'package:dogwalker/modules/horario/cadastrar_horario/cadastrar_horario_page.dart';
import 'package:dogwalker/modules/horario/horario_detalhes/horario_detalhes_page.dart';
import 'package:dogwalker/modules/horario/meus_horarios/meus_horarios_page.dart';
import 'package:dogwalker/modules/passeio/maps_widget/maps_widget.dart';
import 'package:dogwalker/modules/qualificacao/alterar_qualificacao/alterar_qualificacao_page.dart';
import 'package:dogwalker/modules/qualificacao/cadastrar_qualificacao/cadastrar_qualificacao_page.dart';
import 'package:dogwalker/modules/qualificacao/qualificacao_detalhes/qualificacao_detalhes_page.dart';
import 'package:dogwalker/modules/saldo/meu_saldo/meu_saldo_page.dart';
import 'package:dogwalker/modules/saldo/solicitar_deposito/solicitar_deposito_page.dart';
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
        "/horario/add": (context) => CadastrarHorarioPage(),
        "/horario/detail": (context) => HorarioDetalhesPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/horario/edit": (context) => AlterarHorarioPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/saldo/list": (context) => MeuSaldoPage(),
        "/saldo/solicitar-deposito": (context) => SolicitarDepositoPage(),
        "/deposito/list": (context) => MeusDepositosPage(),
        "/maps/detail": (context) => MapsWidget(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/qualificacao/add": (context) => CadastrarQualificacaoPage(),
        "/qualificacao/detail": (context) => QualificacaoDetalhesPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/qualificacao/edit": (context) => AlterarQualificacaoPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
      },
    );
  }
}
