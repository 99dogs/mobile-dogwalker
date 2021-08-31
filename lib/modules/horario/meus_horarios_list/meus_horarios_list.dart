import 'package:dogwalker/modules/horario/horario_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/shimmer_list_tile/shimmer_list_tile.dart';
import 'package:flutter/material.dart';

class MeusHorariosList extends StatefulWidget {
  const MeusHorariosList({Key? key}) : super(key: key);

  @override
  _MeusHorariosListState createState() => _MeusHorariosListState();
}

class _MeusHorariosListState extends State<MeusHorariosList> {
  final controller = HorarioController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.buscarHorarios();
  }

  final diasSemana = {
    1: "Segunda-feira",
    2: "Terça-feira",
    3: "Quarta-feira",
    4: "Quinta-feira",
    5: "Sexta-feira",
    6: "Sábado",
    0: "Domingo",
  };

  @override
  Widget build(BuildContext context) {
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
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ShimmerListTileWidget();
                  },
                ),
              ),
            );
          } else if (state == StateEnum.success) {
            if (controller.horarios.isNotEmpty) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.buscarHorarios();
                    },
                    child: ListView.builder(
                      itemCount: controller.horarios.length,
                      itemBuilder: (context, index) {
                        String diaDaSemana =
                            diasSemana[controller.horarios[index].diaSemana]
                                as String;

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
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
                                  diaDaSemana,
                                  style: TextStyles.titleListTile,
                                ),
                                subtitle: Text(
                                  controller.horarios[index].horaInicio
                                          .toString() +
                                      ' - ' +
                                      controller.horarios[index].horaFinal
                                          .toString(),
                                ),
                                trailing: Icon(Icons.arrow_right_alt),
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    "/horario/detail",
                                    arguments: controller.horarios[index].id,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 13,
                              ),
                            ),
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
                      "Você ainda não configurou nenhum horário.",
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
                        controller.buscarHorarios();
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
