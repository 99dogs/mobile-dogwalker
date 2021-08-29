import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dogwalker/modules/login/login_controller.dart';
import 'package:dogwalker/modules/signin/signin_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/social_login_button/email_and_pass_login_button.dart';
import 'package:dogwalker/shared/widgets/social_login_button/google_social_login_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final loginController = LoginController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await loginController.validarSessao(context);
  }

  @override
  Widget build(BuildContext context) {
    final signinController = SigninController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: size.height * 0.27,
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
                            "99Dogs - Dogwalker",
                            style: TextStyles.titleLogo,
                          ),
                          Text(
                            "Escolha uma das opções de acesso ao app.",
                            style: TextStyles.captionBoldBody,
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
                    ValueListenableBuilder(
                      valueListenable: loginController.state,
                      builder: (_, value, __) {
                        StateEnum state = value as StateEnum;
                        if (state == StateEnum.success) {
                          return Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 70,
                                  ),
                                  child: EmailAndPassLoginButton(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, "/login");
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 70,
                                  ),
                                  child: GoogleSocialLoginButton(
                                    onTap: () async {
                                      String? response = await signinController
                                          .googleSignIn(context);
                                      if (response != null &&
                                          response.isNotEmpty) {
                                        CoolAlert.show(
                                          context: context,
                                          title: "Ocorreu um problema\n",
                                          text: response,
                                          backgroundColor: AppColors.primary,
                                          type: CoolAlertType.error,
                                          confirmBtnText: "Fechar",
                                          confirmBtnColor: AppColors.shape,
                                          confirmBtnTextStyle:
                                              TextStyles.buttonGray,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 55),
                    ),
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
