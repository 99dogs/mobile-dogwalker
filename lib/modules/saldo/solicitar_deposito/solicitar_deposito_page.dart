import 'package:dogwalker/modules/saldo/SaldoController.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class SolicitarDepositoPage extends StatefulWidget {
  const SolicitarDepositoPage({Key? key}) : super(key: key);

  @override
  _SolicitarDepositoPageState createState() => _SolicitarDepositoPageState();
}

class _SolicitarDepositoPageState extends State<SolicitarDepositoPage> {
  final controller = SaldoController();
  String totalSaldo = "0,00";

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.buscarTodos();
    if (mounted) {
      setState(() {
        totalSaldo = controller.formatter.format(
          controller.totalSaldo,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: AppColors.background,
          height: size.height,
          child: Column(
            children: [
              Container(
                height: 80,
                color: AppColors.primary,
              ),
              Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    TitlePageWidget(
                      title: "Solicitar depósito",
                      enableBackButton: true,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Saldo total',
                              style: TextStyles.titleBoldHeading,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                totalSaldo,
                                style: TextStyles.titleListTile,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.state,
                      builder: (_, value, __) {
                        StateEnum state = value as StateEnum;
                        if (state == StateEnum.loading) {
                          return FloatingActionButton.extended(
                            onPressed: () {},
                            label: CircularProgressIndicator(
                              color: AppColors.background,
                            ),
                          );
                        } else {
                          return FloatingActionButton.extended(
                            onPressed: () async {
                              String? response =
                                  await controller.solicitarDeposito();

                              if (response != "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Ocorreu um problema, tente novamente",
                                    ),
                                  ),
                                );
                              }

                              Navigator.pushReplacementNamed(
                                context,
                                "/home",
                              );
                            },
                            icon: Icon(Icons.account_balance_wallet_outlined),
                            label: Text("Confirmar solicitação"),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
