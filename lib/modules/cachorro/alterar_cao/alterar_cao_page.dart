import 'package:animated_card/animated_card.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dogwalker/modules/home/home_controller.dart';
import 'package:dogwalker/modules/cachorro/alterar_cao/alterar_cao_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/cachorro_model.dart';
import 'package:dogwalker/shared/models/porte_model.dart';
import 'package:dogwalker/shared/models/raca_model.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_back_button_widget.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:intl/intl.dart';

class AlterarCaoPage extends StatefulWidget {
  final int id;
  const AlterarCaoPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AlterarCaoPageState createState() => _AlterarCaoPageState();
}

class _AlterarCaoPageState extends State<AlterarCaoPage> {
  final homeController = HomeController();
  final controller = AlterarCaoController();

  final nomeInputTextController = TextEditingController();
  final comportamentoInputTextController = TextEditingController();
  final dataNascimentoInputTextController = MaskedTextController(
    mask: "00/00/0000",
  );

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.init(widget.id);
    controller.cachorro.id = widget.id;
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
                      title: "Alterar dados do cão",
                      enableBackButton: true,
                      routePage: "/cachorro/detail",
                      args: widget.id,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: SingleChildScrollView(
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                InputTextWidget(
                                  label: "Qual é o nome?*",
                                  icon: FontAwesomeIcons.dog,
                                  validator: CachorroModel().validarNome,
                                  initialValue: controller.cachorro.nome,
                                  onChanged: (value) {
                                    controller.onChanged(nome: value);
                                  },
                                ),
                                Column(
                                  children: [
                                    AnimatedCard(
                                      direction: AnimatedCardDirection.right,
                                      child: DateTimeField(
                                        initialValue:
                                            controller.cachorro.dataNascimento,
                                        format: DateFormat("yyyy-MM-dd"),
                                        onShowPicker: (context, currentValue) {
                                          return showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ??
                                                  DateTime.now(),
                                              lastDate: DateTime(2100));
                                        },
                                        onChanged: (value) {
                                          controller.onChanged(
                                              dataNascimento: value);
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          labelText:
                                              "Qual é a data de nascimento?",
                                          labelStyle: TextStyles.buttonGray,
                                          icon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 18,
                                                  ),
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .calendarDay,
                                                    color: AppColors.primary,
                                                  )),
                                              Container(
                                                width: 1,
                                                height: 48,
                                                color: AppColors.stroke,
                                              )
                                            ],
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: AppColors.stroke,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    AnimatedCard(
                                      direction: AnimatedCardDirection.right,
                                      child: DropdownButtonFormField(
                                        value: controller.cachorro.porte,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: CachorroModel().validarPorte,
                                        isExpanded: true,
                                        iconSize: 30,
                                        style: TextStyle(color: Colors.blue),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          labelText: "Qual é o porte?*",
                                          labelStyle: TextStyles.buttonGray,
                                          icon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 18,
                                                  ),
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .weightHanging,
                                                    color: AppColors.primary,
                                                  )),
                                              Container(
                                                width: 1,
                                                height: 48,
                                                color: AppColors.stroke,
                                              )
                                            ],
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        items: controller.portes
                                            .map((PorteModel porte) {
                                          return DropdownMenuItem<PorteModel>(
                                            value: porte,
                                            child: Text(porte.nome!),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          PorteModel value = val as PorteModel;
                                          controller.onChanged(
                                            porte: value,
                                          );
                                          controller.onChanged(
                                            porteId: value.id,
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: AppColors.stroke,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    AnimatedCard(
                                      direction: AnimatedCardDirection.right,
                                      child: DropdownButtonFormField(
                                        value: controller.cachorro.raca,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: CachorroModel().validarRaca,
                                        isExpanded: true,
                                        iconSize: 30,
                                        style: TextStyle(color: Colors.blue),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          labelText: "Qual é a raça?*",
                                          labelStyle: TextStyles.buttonGray,
                                          icon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 18,
                                                  ),
                                                  child: Icon(
                                                    Icons.pets,
                                                    color: AppColors.primary,
                                                  )),
                                              Container(
                                                width: 1,
                                                height: 48,
                                                color: AppColors.stroke,
                                              )
                                            ],
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        items: controller.racas
                                            .map((RacaModel raca) {
                                          return DropdownMenuItem<RacaModel>(
                                            value: raca,
                                            child: Text(raca.nome!),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          RacaModel value = val as RacaModel;
                                          controller.onChanged(
                                            raca: value,
                                          );
                                          controller.onChanged(
                                            racaId: value.id,
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: AppColors.stroke,
                                      ),
                                    ),
                                  ],
                                ),
                                InputTextWidget(
                                  label: "Como é o comportamento?*",
                                  icon: FontAwesomeIcons.smile,
                                  initialValue:
                                      controller.cachorro.comportamento,
                                  validator:
                                      CachorroModel().validarComportamento,
                                  onChanged: (value) {
                                    controller.onChanged(comportamento: value);
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
                              onPressed: () {
                                controller.init(widget.id);
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
                    "/cachorro/detail",
                    arguments: widget.id,
                  );
                },
                secondaryLabel: "Confirmar alteração",
                secondaryOnPressed: () async {
                  String? response = await controller.alterar();
                  if (response != null) {
                    if (response.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response),
                        ),
                      );
                    } else {
                      await CoolAlert.show(
                        context: context,
                        title: "Aaee!\n",
                        text: "Informações atualizadas com sucesso.",
                        backgroundColor: AppColors.primary,
                        type: CoolAlertType.success,
                        confirmBtnText: "Fechar",
                        confirmBtnColor: AppColors.shape,
                        confirmBtnTextStyle: TextStyles.buttonGray,
                        autoCloseDuration: Duration(milliseconds: 2700),
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        "/cachorro/detail",
                        arguments: widget.id,
                      );
                    }
                  }
                },
                enableSecondaryColor: true,
              );
            } else if (state == StateEnum.error) {
              return BottomBackButtonWidget(
                label: "Voltar",
                onPressed: () {
                  homeController.mudarDePagina(3);
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
