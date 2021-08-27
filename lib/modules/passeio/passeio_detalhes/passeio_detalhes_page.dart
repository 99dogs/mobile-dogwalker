import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:dogwalker/modules/passeio/maps_widget/maps_widget.dart';
import 'package:dogwalker/modules/passeio/passeio_detalhes/passeio_detalhes_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/item_detail_list/item_detail_list_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';

class PasseioDetalhesPage extends StatefulWidget {
  final int id;
  const PasseioDetalhesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PasseioDetalhesPageState createState() => _PasseioDetalhesPageState();
}

class _PasseioDetalhesPageState extends State<PasseioDetalhesPage> {
  final controller = PasseioDetalhesController();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.init(widget.id);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                color: AppColors.primary,
              ),
              Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    TitlePageWidget(
                      title: "Informações do passeio",
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
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state == StateEnum.success) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.7,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: AppColors.shape,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                ItemDetailWidget(
                                  icon: Icons.nordic_walking_outlined,
                                  label: "Dog walker",
                                  info: controller.passeio.dogwalker!.nome!,
                                ),
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.calendarCheck,
                                  label: "Agendado para o dia",
                                  info: controller.formatarData(
                                    controller.passeio.datahora,
                                  ),
                                ),
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.infoCircle,
                                  label: "Último status",
                                  info: controller.passeio.status!,
                                ),
                                Visibility(
                                  visible:
                                      controller.passeio.datahorafinalizacao !=
                                              null
                                          ? true
                                          : false,
                                  child: ItemDetailWidget(
                                    icon: FontAwesomeIcons.calendarTimes,
                                    label: "Finalizado dia",
                                    info: controller.formatarData(
                                      controller.passeio.datahorafinalizacao,
                                    ),
                                  ),
                                ),
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.dog,
                                  label: "Cachorro #1",
                                  info: "Joe",
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: AppColors.background,
                                                child: Container(
                                                  child: MapsWidget(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            FontAwesomeIcons.locationArrow,
                                            size: 15,
                                          ),
                                        ),
                                        label: Text("Acompanhar passeio"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
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
      ),
    );
  }
}
