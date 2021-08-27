import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dogwalker/modules/home/home_controller.dart';
import 'package:dogwalker/modules/cachorro/meus_caes_list/detalhes_page_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';

class DetalhesPage extends StatefulWidget {
  final int id;
  const DetalhesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  final homeController = HomeController();
  final controller = DetalhesPageController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.buscarPorId(widget.id);
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
                      title: "Detalhes do cão",
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
                                  child: Icon(FontAwesomeIcons.dog),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Nome \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.cachorro.nome!,
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
                                  child: Icon(FontAwesomeIcons.calendarDay),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Data de nascimento \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller
                                                  .cachorro.dataNascimento !=
                                              null
                                          ? controller.cachorro.dataNascimento!
                                              .toString()
                                          : 'Não informado',
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
                                  child: Icon(FontAwesomeIcons.weightHanging),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Porte \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.cachorro.porte!.nome!,
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
                                  child: Icon(Icons.pets),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Raça \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.cachorro.raca!.nome!,
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
                                  child: Icon(FontAwesomeIcons.smile),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Comportamento \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.cachorro.comportamento,
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
                              onPressed: () {
                                controller.buscarPorId(widget.id);
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
        bottomNavigationBar: BottomButtonsWidget(
          primaryLabel: "Excluir",
          primaryOnPressed: () {
            Widget removeButton = ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.delete),
              ),
              child: Text("Excluir"),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                String? response = await controller.excluir(widget.id);
                if (response != null) {
                  if (response.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response),
                      ),
                    );
                  } else {
                    homeController.mudarDePagina(3);
                    Navigator.pushReplacementNamed(context, "/home");
                  }
                }
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Atenção."),
              content: Text("Deseja realmente excluir o cachorro?"),
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
              "/cachorro/edit",
              arguments: controller.cachorro.id,
            );
          },
          enableSecondaryColor: true,
        ),
      ),
    );
  }
}
