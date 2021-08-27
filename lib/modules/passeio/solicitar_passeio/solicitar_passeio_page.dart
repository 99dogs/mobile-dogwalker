import 'package:animated_card/animated_card.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dogwalker/modules/home/home_controller.dart';
import 'package:dogwalker/modules/passeio/solicitar_passeio/solicitar_passeio_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/passeio_model.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_back_button_widget.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';
import 'package:dogwalker/shared/widgets/multiselect_formfield_widget/multi_select_form_field_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:intl/intl.dart';

class SolicitarPasseioPage extends StatefulWidget {
  final int dogwalkerId;
  const SolicitarPasseioPage({
    Key? key,
    required this.dogwalkerId,
  }) : super(key: key);

  @override
  _SolicitarPasseioPageState createState() => _SolicitarPasseioPageState();
}

class _SolicitarPasseioPageState extends State<SolicitarPasseioPage> {
  final homeController = HomeController();
  final controller = SolicitarPasseioController();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.init(widget.dogwalkerId);
    controller.onChange(dogwalkerId: widget.dogwalkerId);
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
                      title: "Solicitar novo passeio",
                      enableBackButton: true,
                      routePage: "/dogwalker/detail",
                      args: widget.dogwalkerId,
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
                                  label: "Dog walker",
                                  icon: Icons.nordic_walking_outlined,
                                  initialValue: controller.dogwalker.nome,
                                  enable: false,
                                  onChanged: (value) {},
                                ),
                                AnimatedCard(
                                  direction: AnimatedCardDirection.right,
                                  child: DateTimeField(
                                    format: DateFormat("dd/MM/yyyy HH:mm"),
                                    onShowPicker:
                                        (context, currentValue) async {
                                      final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now(),
                                          ),
                                        );
                                        return DateTimeField.combine(
                                            date, time);
                                      } else {
                                        return currentValue;
                                      }
                                    },
                                    onChanged: (value) async {
                                      if (value == null) return;

                                      bool disponivel = await controller
                                          .verificarDisponibilidade(value);
                                      if (disponivel == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'O horário escolhido não está disponível.',
                                            ),
                                          ),
                                        );
                                        return;
                                      } else {
                                        controller.onChange(datahora: value);
                                      }
                                    },
                                    validator: (datetime) {
                                      if (datetime == null) {
                                        return "Escolha um horário";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      labelText: "Qual horário você gostaria?",
                                      labelStyle: TextStyles.buttonGray,
                                      icon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.calendarDay,
                                              color: AppColors.primary,
                                            ),
                                          ),
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
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.stroke,
                                  ),
                                ),
                                AnimatedCard(
                                  direction: AnimatedCardDirection.right,
                                  child: MultiSelectFormFieldWidget(
                                    autovalidate: false,
                                    chipBackGroundColor: AppColors.secondary,
                                    chipLabelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    dialogTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    checkBoxActiveColor: AppColors.primary,
                                    checkBoxCheckColor: Colors.white,
                                    dialogShapeBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    dataSource: controller.listCachorros,
                                    title: "Quais dos seus cães irão passear?",
                                    textField: 'nome',
                                    valueField: 'id',
                                    okButtonLabel: 'Adicionar',
                                    cancelButtonLabel: 'Cancelar',
                                    required: true,
                                    onSaved: (value) {
                                      if (value == null) return;
                                      controller.onChange(cachorrosIds: value);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.stroke,
                                  ),
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
                                controller.init(widget.dogwalkerId);
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
                  Navigator.pushReplacementNamed(context, "/dogwalker/detail",
                      arguments: widget.dogwalkerId);
                },
                secondaryLabel: "Solicitar",
                secondaryOnPressed: () async {
                  try {
                    PasseioModel? novoPasseio = await controller.solicitar();

                    homeController.mudarDePagina(0);
                    Navigator.pushReplacementNamed(
                      context,
                      "/passeio/detail",
                      arguments: novoPasseio!.id,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Ocorreu um problema, tente novamente.",
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
