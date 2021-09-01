import 'package:animated_card/animated_card.dart';
import 'package:dogwalker/modules/qualificacao/qualificacao_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_list_tile/shimmer_list_tile.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class AlterarQualificacaoPage extends StatefulWidget {
  final int id;
  const AlterarQualificacaoPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AlterarQualificacaoPageState createState() =>
      _AlterarQualificacaoPageState();
}

class _AlterarQualificacaoPageState extends State<AlterarQualificacaoPage> {
  final controller = QualificacaoController();

  final tituloInputController = TextEditingController();
  final modalidadeInputController = TextEditingController();
  final descricaoInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.buscarQualificacao(widget.id);
    tituloInputController.text = controller.qualificacao.titulo!;
    descricaoInputController.text = controller.qualificacao.descricao!;
    modalidadeInputController.text = controller.qualificacao.modalidade!;
  }

  @override
  void dispose() {
    super.dispose();
    tituloInputController.dispose();
    descricaoInputController.dispose();
    modalidadeInputController.dispose();
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
                      title: "Alterar qualificação",
                      enableBackButton: true,
                      routePage: "/qualificacao/detail",
                      args: widget.id,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (_, value, __) {
                  StateEnum state = value as StateEnum;
                  if (state == StateEnum.loading) {
                    return Container();
                  } else {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                InputTextWidget(
                                  label: "Título",
                                  icon: Icons.badge_outlined,
                                  textInputType: TextInputType.text,
                                  controller: tituloInputController,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "O campo Título não pode ser vazio.";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.onChange(titulo: value);
                                  },
                                ),
                                AnimatedCard(
                                  direction: AnimatedCardDirection.right,
                                  child: DropdownButtonFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isExpanded: true,
                                    iconSize: 30,
                                    style: TextStyle(color: Colors.blue),
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "O campo Nível não pode ser vazio.";
                                      }
                                      return null;
                                    },
                                    value: controller.qualificacao.modalidade!,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      labelText: "Qual é o nível?",
                                      labelStyle: TextStyles.buttonGray,
                                      icon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                            ),
                                            child: Icon(
                                              Icons.school_outlined,
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
                                    items: controller.modalidades
                                        .map((String modalidade) {
                                      return DropdownMenuItem<String>(
                                        value: modalidade,
                                        child: Text(modalidade),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      controller.onChange(
                                          modalidade: val.toString());
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
                                InputTextWidget(
                                  label: "Descrição",
                                  icon: Icons.view_headline_outlined,
                                  textInputType: TextInputType.text,
                                  controller: descricaoInputController,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "O campo Descrição não pode ser vazio.";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.onChange(descricao: value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
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
            if (state == StateEnum.loading) {
              return Container(
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              return BottomButtonsWidget(
                primaryLabel: "Voltar",
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    "/qualificacao/detail",
                    arguments: widget.id,
                  );
                },
                secondaryLabel: "Confirmar alteração",
                secondaryOnPressed: () async {
                  try {
                    String? response = await controller.alterarQualificacao(
                      widget.id,
                    );

                    if (response != "invalid") {
                      if (response != null && response.isNotEmpty) {
                        throw (response);
                      }

                      Navigator.pushReplacementNamed(
                        context,
                        "/home",
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
            }
          },
        ),
      ),
    );
  }
}
