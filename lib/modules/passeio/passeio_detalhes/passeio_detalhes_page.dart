import 'package:cool_alert/cool_alert.dart';
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
                                  height: size.height * 0.6,
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
                                        icon: Icons.nordic_walking_outlined,
                                        label: "Dog walker",
                                        info:
                                            controller.passeio.dogwalker!.nome!,
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
                                        icon: FontAwesomeIcons.dog,
                                        label: "Cachorro #1",
                                        info: controller.cachorros,
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
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 7,
                                                      ),
                                                      child: SizedBox(
                                                        width: 120,
                                                        height: 35,
                                                        child:
                                                            ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.green,
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
                                                          label:
                                                              Text("Aceitar"),
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
                                                                context:
                                                                    context,
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
                                                                  .init(widget
                                                                      .id);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 7,
                                                      ),
                                                      child: SizedBox(
                                                        width: 120,
                                                        height: 35,
                                                        child:
                                                            ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: AppColors
                                                                .delete,
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
                                                          label:
                                                              Text("Recusar"),
                                                          onPressed:
                                                              () async {},
                                                        ),
                                                      ),
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
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () async {
                                                  await scanQR();
                                                  String? response = "";
                                                  if (_scanBarcode != "-1" &&
                                                      _scanBarcode ==
                                                          widget.id
                                                              .toString()) {
                                                    response = await controller
                                                        .alterarStatus(
                                                      widget.id,
                                                      "iniciar",
                                                    );
                                                  } else if (_scanBarcode !=
                                                      widget.id.toString()) {
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
                                                      type: CoolAlertType.error,
                                                      confirmBtnText: "Fechar",
                                                      confirmBtnColor:
                                                          AppColors.shape,
                                                      confirmBtnTextStyle:
                                                          TextStyles.buttonGray,
                                                    );
                                                  } else {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      "/maps/detail",
                                                      arguments: widget.id,
                                                    );
                                                  }
                                                },
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.qr_code_2_outlined,
                                                    size: 15,
                                                  ),
                                                ),
                                                label: Text("Ler QrCode"),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 150,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton.icon(
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                          ],
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
      ),
    );
  }
}
