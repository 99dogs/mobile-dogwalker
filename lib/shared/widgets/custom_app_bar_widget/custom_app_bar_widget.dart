import 'package:flutter/material.dart';
import 'package:dogwalker/modules/login/login_page.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_images.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';

class CustomAppBarWidget extends StatefulWidget {
  const CustomAppBarWidget({Key? key}) : super(key: key);

  @override
  _CustomAppBarWidgetState createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  final authController = AuthController();
  UsuarioLogadoModel _usuario = UsuarioLogadoModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(
              future: authController.obterSessao(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _usuario = snapshot.data as UsuarioLogadoModel;
                  return Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyles.titleBoldBackground,
                        text: "Olá, ",
                        children: [
                          TextSpan(text: _usuario.nome),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Expanded(
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginPage(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.background,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: AssetImage(AppImages.logoDogwalker),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
