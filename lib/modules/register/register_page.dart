import 'package:flutter/material.dart';
import 'package:dogwalker/modules/register/register_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/usuario_login_model.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = RegisterController();

  UsuarioLogin usuarioLogin = UsuarioLogin();

  final _controllerNome = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  @override
  void dispose() {
    _controllerNome.dispose();
    _controllerEmail.dispose();
    _controllerSenha.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
              top: size.height * 0.2,
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
                          Text(
                            "Cadastre-se",
                            style: TextStyles.titleLogo,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40,
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
                              label: "Qual é o seu nome?",
                              icon: Icons.person,
                              controller: _controllerNome,
                              validator: controller.validarNome,
                              onChanged: (value) {
                                controller.onChange(nome: value);
                              },
                            ),
                            InputTextWidget(
                              label: "Informe seu melhor e-mail.",
                              icon: Icons.email_outlined,
                              controller: _controllerEmail,
                              validator: controller.validarEmail,
                              onChanged: (value) {
                                controller.onChange(email: value);
                              },
                            ),
                            InputTextWidget(
                              label: "Escolha uma senha forte.",
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
                                  Navigator.of(context).pop();
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      child: Text(
                                        error,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.titleListTile,
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // retorna um objeto do tipo Dialog
                                          return AlertDialog(
                                            title: Text(
                                                "Termos e condições de uso."),
                                            content: Container(
                                              child: Container(),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: AppColors.delete,
                                                ),
                                                child: Text("Não concordo"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await controller
                                                      .autenticar(context);
                                                },
                                                child: Text("Concordo"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Cadastrar"),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/login",
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  "Voltar",
                                  style: TextStyles.titleListTile,
                                ),
                              ),
                            ),
                          ],
                        ),
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
