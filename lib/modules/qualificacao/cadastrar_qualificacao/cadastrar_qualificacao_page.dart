import 'package:animated_card/animated_card.dart';
import 'package:dogwalker/modules/qualificacao/qualificacao_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class CadastrarQualificacaoPage extends StatefulWidget {
  const CadastrarQualificacaoPage({Key? key}) : super(key: key);

  @override
  _CadastrarQualificacaoPageState createState() =>
      _CadastrarQualificacaoPageState();
}

class _CadastrarQualificacaoPageState extends State<CadastrarQualificacaoPage> {
  final controller = QualificacaoController();

  @override
  void initState() {
    super.initState();
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
                      title: "Adicionar nova qualificação",
                      enableBackButton: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
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
                                controller.onChange(modalidade: val.toString());
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
                  Navigator.pushReplacementNamed(context, "/home");
                },
                secondaryLabel: "Adicionar",
                secondaryOnPressed: () async {
                  try {
                    String? response = await controller.adicionarQualificacao();

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
