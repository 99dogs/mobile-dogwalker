import 'package:flutter/material.dart';
import 'package:dogwalker/modules/login/login_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/usuario_login_model.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';
import 'package:dogwalker/shared/widgets/social_login_button/register_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  UsuarioLogin usuarioLogin = UsuarioLogin();

  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: size.height * 0.15,
              child: Container(
                width: size.width - 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.background,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/app-logo.png',
                            width: 100,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Informe suas credenciais para acessar sua conta",
                            style: TextStyles.captionBoldBody,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            InputTextWidget(
                              label: "Digite seu e-mail.",
                              icon: Icons.email_outlined,
                              controller: _controllerEmail,
                              validator: controller.validarEmail,
                              onChanged: (value) {
                                controller.onChange(email: value);
                              },
                            ),
                            InputTextWidget(
                              label: "Digite sua senha.",
                              icon: Icons.lock_outline,
                              obscureText: true,
                              controller: _controllerSenha,
                              validator: controller.validarSenha,
                              onChanged: (value) {
                                controller.onChange(senha: value);
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: controller.errorException,
                              builder: (_, value, __) {
                                String error = value as String;
                                if (error.isNotEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      child: Text(
                                        error,
                                        style: TextStyles.textError,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: controller.state,
                              builder: (
                                context,
                                value,
                                child,
                              ) {
                                StateEnum state = value as StateEnum;
                                if (state == StateEnum.loading) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return ElevatedButton(
                                    onPressed: () {
                                      controller.autenticar(context);
                                    },
                                    child: Text("Entrar"),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 50,
                        horizontal: 70,
                      ),
                      child: RegisterButton(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/register");
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Divider(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/signin",
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                "Voltar",
                                style: TextStyles.titleListTile,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
