import 'package:dogwalker/modules/deposito/deposito_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/shimmer_list_tile/shimmer_list_tile.dart';
import 'package:flutter/material.dart';

class MeusDepositosList extends StatefulWidget {
  const MeusDepositosList({Key? key}) : super(key: key);

  @override
  _MeusDepositosListState createState() => _MeusDepositosListState();
}

class _MeusDepositosListState extends State<MeusDepositosList> {
  final controller = DepositoController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          StateEnum state = value as StateEnum;
          if (state == StateEnum.loading) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ShimmerListTileWidget();
                  },
                ),
              ),
            );
          } else if (state == StateEnum.success) {
            if (controller.depositos.isNotEmpty) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.buscarTodos();
                    },
                    child: ListView.builder(
                      itemCount: controller.depositos.length,
                      itemBuilder: (context, index) {
                        String status = "";
                        Color colorStatus;
                        bool pendente = controller.depositos[index].pendente!;
                        bool concluido = controller.depositos[index].concluido!;

                        if (concluido == true) {
                          colorStatus = Colors.green;
                          status = "Concluído";
                        } else if (pendente == true) {
                          colorStatus = Colors.amber;
                          status = "Pendente";
                        } else {
                          colorStatus = Colors.black;
                        }

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  "Depósito " +
                                      controller.depositos[index].id.toString(),
                                  style: TextStyles.buttonBoldGray,
                                ),
                                subtitle: Text(status),
                                trailing: Text(
                                  controller.getFormatedDate(
                                          controller.depositos[index].criado!) +
                                      "\n" +
                                      controller.formatter.format(
                                        controller.depositos[index].valor,
                                      ),
                                  textAlign: TextAlign.right,
                                ),
                                onTap: () {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 13,
                              ),
                              child: Container(
                                width: size.width,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: colorStatus,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    child: Text(
                      "Você ainda não solicitou nenhum passeio.",
                      style: TextStyles.input,
                    ),
                  ),
                ),
              );
            }
          } else {
            return Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Ocorreu um problema inesperado.",
                      style: TextStyles.input,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.buscarTodos();
                      },
                      icon: Icon(Icons.refresh_outlined),
                      label: Text("Tentar novamente"),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
