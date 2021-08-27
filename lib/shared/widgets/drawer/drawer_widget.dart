import 'package:flutter/material.dart';
import 'package:dogwalker/modules/login/login_controller.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Center(
              child: Text(
                '99Dogs',
                style: TextStyles.titleLogoWhite,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book_outlined),
            title: Text("Termos de uso e privacidade"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text("Política de dados"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help_center_outlined),
            title: Text("Sobre"),
            onTap: () async {
              String _url = "https://github.com/99dogs";
              await canLaunch(_url)
                  ? await launch(_url)
                  : throw 'Não foi possível abrir o link $_url';
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Encerrar sessão"),
            onTap: () {
              loginController.encerrarSessao(context);
            },
          ),
        ],
      ),
    );
  }
}
