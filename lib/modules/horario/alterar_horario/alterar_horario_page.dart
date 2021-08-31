import 'package:dogwalker/modules/horario/horario_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_back_button_widget.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class AlterarHorarioPage extends StatefulWidget {
  final int id;
  const AlterarHorarioPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AlterarHorarioPageState createState() => _AlterarHorarioPageState();
}

class _AlterarHorarioPageState extends State<AlterarHorarioPage> {
  final controller = HorarioController();
  final horarioInicioInputController = MaskedTextController(
    mask: "00:00",
  );
  final horarioFinalInputController = MaskedTextController(
    mask: "00:00",
  );

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.buscarHorario(widget.id);
    horarioInicioInputController.text =
        controller.configHorario.horaInicio ?? '';
    horarioFinalInputController.text = controller.configHorario.horaFinal ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
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
                      title: "Alterar horário",
                      enableBackButton: true,
                      routePage: "/horario/detail",
                      args: widget.id,
                    ),
                    SizedBox(
                      height: 16,
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
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                InputTextWidget(
                                  label: "Dia da semana",
                                  icon: Icons.calendar_today_outlined,
                                  enable: false,
                                  initialValue: controller.diasSemana[
                                      controller.configHorario.diaSemana],
                                  onChanged: (value) {},
                                ),
                                InputTextWidget(
                                  label: "Horário de início",
                                  icon: Icons.watch_later_outlined,
                                  controller: horarioInicioInputController,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "O campo horário de início não pode ser vazio.";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.onChange(horaInicio: value);
                                  },
                                ),
                                InputTextWidget(
                                  label: "Horário do término",
                                  icon: Icons.watch_later_outlined,
                                  controller: horarioFinalInputController,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "O campo horário do término não pode ser vazio.";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.onChange(horaFinal: value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
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
                              onPressed: () async {
                                await start();
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
            ],
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (_, value, __) {
            StateEnum state = value as StateEnum;
            if (state == StateEnum.success) {
              return BottomButtonsWidget(
                primaryLabel: "Voltar",
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    "/horario/detail",
                    arguments: widget.id,
                  );
                },
                secondaryLabel: "Alterar",
                secondaryOnPressed: () async {
                  try {
                    String? response = await controller.alterarHorario();

                    if (response != "invalid") {
                      if (response != null && response.isNotEmpty) {
                        throw (response);
                      }

                      Navigator.pushReplacementNamed(
                        context,
                        "/horario/detail",
                        arguments: widget.id,
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Ocorreu um problema, tente novamente",
                        ),
                      ),
                    );
                  }
                },
                enableSecondaryColor: true,
              );
            } else if (state == StateEnum.error) {
              return BottomBackButtonWidget(
                label: "Voltar",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
              );
            } else {
              return BottomBackButtonWidget(
                label: "Carregando...",
                onPressed: () {},
              );
            }
          },
        ),
      ),
    );
  }
}
