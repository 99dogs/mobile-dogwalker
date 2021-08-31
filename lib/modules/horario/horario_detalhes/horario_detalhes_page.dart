import 'package:dogwalker/modules/horario/horario_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class HorarioDetalhesPage extends StatefulWidget {
  final int id;
  const HorarioDetalhesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _HorarioDetalhesPageState createState() => _HorarioDetalhesPageState();
}

class _HorarioDetalhesPageState extends State<HorarioDetalhesPage> {
  final controller = HorarioController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    controller.buscarHorario(widget.id);
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
                      title: "Detalhes do horário",
                      enableBackButton: true,
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (_, value, __) {
                  StateEnum state = value as StateEnum;
                  if (state == StateEnum.loading) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ShimmerInputWidget();
                          },
                        ),
                      ),
                    );
                  } else if (state == StateEnum.success) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  right: 13,
                                ),
                                child: Container(
                                  child: Icon(Icons.calendar_today_outlined),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Dia da semana \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.diasSemana[
                                          controller.configHorario.diaSemana],
                                      style: TextStyles.buttonGray,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.stroke,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  right: 13,
                                ),
                                child: Container(
                                  child: Icon(Icons.watch_later_outlined),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Horário de início \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.configHorario.horaInicio,
                                      style: TextStyles.buttonGray,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.stroke,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  right: 13,
                                ),
                                child: Container(
                                  child: Icon(Icons.watch_later_outlined),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Horário do término \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.configHorario.horaFinal,
                                      style: TextStyles.buttonGray,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.stroke,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
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
                              onPressed: () {},
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
            ],
          ),
        ),
        bottomNavigationBar: BottomButtonsWidget(
          primaryLabel: "Excluir",
          primaryOnPressed: () {
            Widget removeButton = ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.delete),
              ),
              child: Text("Excluir"),
              onPressed: () async {
                bool response = await controller.deletarHorario(widget.id);
                if (response == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("Ocorreu um problema ao deletar o horário."),
                    ),
                  );
                }
                Navigator.pushReplacementNamed(context, "/home");
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Atenção."),
              content: Text("Deseja realmente excluir o horário?"),
              actions: [removeButton],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          },
          secondaryLabel: "Alterar",
          secondaryOnPressed: () async {
            Navigator.pushReplacementNamed(
              context,
              "/horario/edit",
              arguments: widget.id,
            );
          },
          enableSecondaryColor: true,
        ),
      ),
    );
  }
}
