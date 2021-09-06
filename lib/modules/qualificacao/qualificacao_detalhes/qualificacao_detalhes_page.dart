import 'package:dogwalker/modules/qualificacao/qualificacao_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class QualificacaoDetalhesPage extends StatefulWidget {
  final int id;
  const QualificacaoDetalhesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _QualificacaoDetalhesPageState createState() =>
      _QualificacaoDetalhesPageState();
}

class _QualificacaoDetalhesPageState extends State<QualificacaoDetalhesPage> {
  final controller = QualificacaoController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    controller.buscarQualificacao(widget.id);
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
                      title: "Detalhes da qualificação",
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
                                  child: Icon(Icons.badge_outlined),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Título \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.qualificacao.titulo,
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
                                  child: Icon(Icons.school_outlined),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Nível \n",
                                  style: TextStyles.input,
                                  children: [
                                    TextSpan(
                                      text: controller.qualificacao.modalidade,
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
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                      right: 13,
                                    ),
                                    child: Container(
                                      child: Icon(Icons.view_headline_outlined),
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: "Descrição \n",
                                      style: TextStyles.input,
                                      children: [
                                        TextSpan(
                                          text:
                                              controller.qualificacao.descricao,
                                          style: TextStyles.buttonGray,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                bool response = await controller.deletarQualificacao(widget.id);
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
              content: Text("Deseja realmente excluir a qualificação?"),
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
              "/qualificacao/edit",
              arguments: widget.id,
            );
          },
          enableSecondaryColor: true,
        ),
      ),
    );
  }
}
