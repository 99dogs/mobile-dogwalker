import 'package:cool_alert/cool_alert.dart';
import 'package:dogwalker/shared/widgets/label_button/label_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  String _scanBarcode = "";

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.init(widget.id);
  }

  Future<void> scanQR() async {
    String barcodeScanRes = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#FF280059', 'Cancelar', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
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
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.init(widget.id);
                        },
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: Container(
                                  height: size.height * 0.70,
                                  width: size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: AppColors.shape,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      ItemDetailWidget(
                                        icon: Icons.tag_outlined,
                                        label: "Identificador único",
                                        info: controller.passeio.id!.toString(),
                                      ),
                                      ItemDetailWidget(
                                        icon: FontAwesomeIcons.calendarCheck,
                                        label: "Agendado para o dia",
                                        info: controller.formatarData(
                                          controller.passeio.datahora,
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.passeio
                                                    .datahorafinalizacao !=
                                                null
                                            ? true
                                            : false,
                                        child: ItemDetailWidget(
                                          icon: FontAwesomeIcons.calendarTimes,
                                          label: "Finalizado dia",
                                          info: controller.formatarData(
                                            controller
                                                .passeio.datahorafinalizacao,
                                          ),
                                        ),
                                      ),
                                      ItemDetailWidget(
                                        icon: Icons.person_outline_outlined,
                                        label: "Tutor",
                                        info: controller.passeio.tutor!.nome!,
                                      ),
                                      ItemDetailWidget(
                                        icon: FontAwesomeIcons.dog,
                                        label: "Cachorro",
                                        info: controller.cachorros,
                                        enableToggleDetail: true,
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: AppColors.background,
                                                child: ListView.builder(
                                                  itemCount: controller.passeio
                                                      .cachorros!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      title: Text(
                                                        controller
                                                                .passeio
                                                                .cachorros![
                                                                    index]
                                                                .nome! +
                                                            " - " +
                                                            controller
                                                                .passeio
                                                                .cachorros![
                                                                    index]
                                                                .porte!
                                                                .nome!,
                                                      ),
                                                      subtitle: Text(
                                                        controller
                                                            .passeio
                                                            .cachorros![index]
                                                            .comportamento!,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      ItemDetailWidget(
                                        icon: FontAwesomeIcons.infoCircle,
                                        label: "Último status",
                                        info: controller.passeio.status!,
                                      ),
                                      ValueListenableBuilder(
                                        valueListenable:
                                            controller.stateAlterarStatus,
                                        builder: (_, value, __) {
                                          StateEnum state = value as StateEnum;
                                          if (state == StateEnum.loading) {
                                            return Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Visibility(
                                              visible:
                                                  controller.passeio.status ==
                                                          "Espera"
                                                      ? true
                                                      : false,
                                              child: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child:
                                                          ElevatedButton.icon(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.green,
                                                        ),
                                                        icon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons
                                                                .done_outline_outlined,
                                                            size: 15,
                                                          ),
                                                        ),
                                                        label: Text("Aceitar"),
                                                        onPressed: () async {
                                                          String? response =
                                                              await controller
                                                                  .alterarStatus(
                                                            widget.id,
                                                            "aceitar",
                                                          );

                                                          if (response !=
                                                                  null &&
                                                              response
                                                                  .isNotEmpty) {
                                                            CoolAlert.show(
                                                              context: context,
                                                              title:
                                                                  "Ocorreu um problema\n",
                                                              text: response,
                                                              backgroundColor:
                                                                  AppColors
                                                                      .primary,
                                                              type:
                                                                  CoolAlertType
                                                                      .error,
                                                              confirmBtnText:
                                                                  "Fechar",
                                                              confirmBtnColor:
                                                                  AppColors
                                                                      .shape,
                                                              confirmBtnTextStyle:
                                                                  TextStyles
                                                                      .buttonGray,
                                                            );
                                                          } else {
                                                            await controller
                                                                .init(
                                                                    widget.id);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child:
                                                          ElevatedButton.icon(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              AppColors.delete,
                                                        ),
                                                        icon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 15,
                                                          ),
                                                        ),
                                                        label: Text("Recusar"),
                                                        onPressed: () async {},
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      Visibility(
                                        visible: controller.passeio.status ==
                                                "Aceito"
                                            ? true
                                            : false,
                                        child: Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  onPressed: () async {
                                                    await scanQR();
                                                    if (_scanBarcode != "-1") {
                                                      String? response = "";
                                                      if (_scanBarcode ==
                                                          widget.id
                                                              .toString()) {
                                                        response =
                                                            await controller
                                                                .alterarStatus(
                                                          widget.id,
                                                          "iniciar",
                                                        );
                                                      } else if (_scanBarcode !=
                                                          widget.id
                                                              .toString()) {
                                                        response =
                                                            "Passeio diferente do atual";
                                                      }

                                                      if (response != null &&
                                                          response.isNotEmpty) {
                                                        CoolAlert.show(
                                                          context: context,
                                                          title:
                                                              "Ocorreu um problema\n",
                                                          text: response,
                                                          backgroundColor:
                                                              AppColors.primary,
                                                          type: CoolAlertType
                                                              .error,
                                                          confirmBtnText:
                                                              "Fechar",
                                                          confirmBtnColor:
                                                              AppColors.shape,
                                                          confirmBtnTextStyle:
                                                              TextStyles
                                                                  .buttonGray,
                                                        );
                                                      } else {
                                                        Navigator
                                                            .pushReplacementNamed(
                                                          context,
                                                          "/maps/detail",
                                                          arguments: widget.id,
                                                        );
                                                      }
                                                    }
                                                  },
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.qr_code_2_outlined,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  label: Text("Ler QrCode"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.passeio.status ==
                                                "Andamento"
                                            ? true
                                            : false,
                                        child: Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.map_outlined,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  label: Text("Ver andamento"),
                                                  onPressed: () async {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      "/maps/detail",
                                                      arguments: widget.id,
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
        bottomNavigationBar: Container(
          height: 56,
          child: Row(
            children: [
              Expanded(
                child: LabelButton(
                  label: "Voltar",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      "/home",
                    );
                  },
                  style: TextStyles.buttonPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
