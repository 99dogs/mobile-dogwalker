import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:dogwalker/modules/home/home_controller.dart';
import 'package:dogwalker/modules/perfil/meu_perfil/meu_perfil_controller.dart';
import 'package:dogwalker/modules/perfil/foto_perfil/foto_perfil.dart';
import 'package:dogwalker/shared/models/cidade_model.dart';
import 'package:dogwalker/shared/models/estado_model.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:dogwalker/shared/widgets/input_text/input_text_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_foto/shimmer_photo_widget.dart';
import 'package:dogwalker/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';

class MeuPerfilPage extends StatefulWidget {
  const MeuPerfilPage({Key? key}) : super(key: key);

  @override
  _MeuPerfilPageState createState() => _MeuPerfilPageState();
}

class _MeuPerfilPageState extends State<MeuPerfilPage> {
  final controller = MeuPerfilController();
  final homeController = HomeController();

  final cepInputTextController = MaskedTextController(
    mask: "00000-000",
  );
  final nomeInputTextController = TextEditingController();
  final emailInputTextController = TextEditingController();
  final telefoneInputTextController = MaskedTextController(
    mask: "(00) 0 0000-0000",
  );
  final ruaInputTextController = TextEditingController();
  final numeroInputTextController = TextEditingController();
  final bairroInputTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.obterDados();
    if (controller.usuario.id != 0) {
      cepInputTextController.text = controller.usuario.cep ?? '';
      nomeInputTextController.text = controller.usuario.nome ?? '';
      emailInputTextController.text = controller.usuario.email ?? '';
      telefoneInputTextController.text = controller.usuario.telefone ?? '';
      ruaInputTextController.text = controller.usuario.rua ?? '';
      numeroInputTextController.text = controller.usuario.numero ?? '';
      bairroInputTextController.text = controller.usuario.bairro ?? '';
      controller.buscarCidades(controller.usuario.estado!.id ?? 0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    cepInputTextController.dispose();
    nomeInputTextController.dispose();
    emailInputTextController.dispose();
    telefoneInputTextController.dispose();
    ruaInputTextController.dispose();
    numeroInputTextController.dispose();
    bairroInputTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  title: "Meu perfil",
                ),
                SizedBox(height: 15),
                ValueListenableBuilder(
                  valueListenable: controller.state,
                  builder: (context, value, child) {
                    MeuPerfilFormState state = value as MeuPerfilFormState;

                    if (state == MeuPerfilFormState.loading) {
                      return ShimmerPhotoWidget();
                    } else {
                      return FotoPerfil();
                    }
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.state,
            builder: (context, value, child) {
              MeuPerfilFormState state = value as MeuPerfilFormState;

              if (state == MeuPerfilFormState.loading) {
                return Expanded(
                  child: Container(
                    color: AppColors.background,
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return ShimmerInputWidget();
                      },
                    ),
                  ),
                );
              } else {
                return Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.background,
                    child: SingleChildScrollView(
                      child: Container(
                        color: AppColors.background,
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InputTextWidget(
                                label: "Nome",
                                icon: Icons.face_outlined,
                                controller: nomeInputTextController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "O campo nome não pode ser vazio.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.onChange(nome: value);
                                },
                              ),
                              InputTextWidget(
                                label: "E-mail",
                                icon: Icons.email_outlined,
                                enable: false,
                                controller: emailInputTextController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "O campo e-mail não pode ser vazio.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.onChange(email: value);
                                },
                              ),
                              InputTextWidget(
                                label: "Telefone",
                                icon: Icons.phone,
                                controller: telefoneInputTextController,
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "O campo telefone não pode ser vazio.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.onChange(telefone: value);
                                },
                              ),
                              InputTextWidget(
                                label: "Rua",
                                icon: Icons.streetview_outlined,
                                controller: ruaInputTextController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "O campo rua não pode ser vazio.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.onChange(rua: value);
                                },
                              ),
                              InputTextWidget(
                                label: "Número",
                                icon: Icons.label_important_outline,
                                controller: numeroInputTextController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "O campo número não pode ser vazio.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.onChange(numero: value);
                                },
                              ),
                              InputTextWidget(
                                label: "Bairro",
                                icon: Icons.holiday_village_outlined,
                                controller: bairroInputTextController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "O campo bairro não pode ser vazio.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.onChange(bairro: value);
                                },
                              ),
                              InputTextWidget(
                                label: "CEP",
                                icon: Icons.location_city_outlined,
                                controller: cepInputTextController,
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "O campo CEP não pode ser vazio.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.onChange(cep: value);
                                },
                              ),
                              ValueListenableBuilder(
                                  valueListenable: controller.estadoIdAlterado,
                                  builder: (context, value, child) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: DropdownButtonFormField(
                                                  validator: (value) {
                                                    EstadoModel estado =
                                                        value as EstadoModel;
                                                    if (estado.id == null) {
                                                      return "O campo estado não pode ser vazio.";
                                                    }
                                                    return null;
                                                  },
                                                  value:
                                                      controller.usuario.estado,
                                                  isExpanded: true,
                                                  iconSize: 30,
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    labelText: "Estado",
                                                    labelStyle:
                                                        TextStyles.buttonGray,
                                                    icon: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 18,
                                                            ),
                                                            child: Icon(
                                                              Icons.bookmark,
                                                              color: AppColors
                                                                  .primary,
                                                            )),
                                                        Container(
                                                          width: 1,
                                                          height: 48,
                                                          color:
                                                              AppColors.stroke,
                                                        )
                                                      ],
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  items: controller.estados.map(
                                                      (EstadoModel estado) {
                                                    return DropdownMenuItem<
                                                        EstadoModel>(
                                                      value: estado,
                                                      child: Text(estado.nome!),
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    EstadoModel estado =
                                                        val as EstadoModel;
                                                    controller.onChange(
                                                        estado: estado);
                                                    controller.buscarCidades(
                                                        estado.id!);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: AppColors.stroke,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              ValueListenableBuilder(
                                valueListenable: controller.estadoIdAlterado,
                                builder: (context, value, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: DropdownButtonFormField(
                                                validator: (value) {
                                                  CidadeModel cidade =
                                                      value as CidadeModel;
                                                  if (cidade.id == null) {
                                                    return "O campo cidade não pode ser vazio.";
                                                  }
                                                  return null;
                                                },
                                                value:
                                                    controller.usuario.cidade,
                                                isExpanded: true,
                                                iconSize: 30,
                                                style: TextStyle(
                                                    color: Colors.blue),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  labelText: "Cidade",
                                                  labelStyle:
                                                      TextStyles.buttonGray,
                                                  icon: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 18,
                                                          ),
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            color: AppColors
                                                                .primary,
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
                                                items: controller.cidades
                                                    .map((CidadeModel cidade) {
                                                  return DropdownMenuItem<
                                                      CidadeModel>(
                                                    value: cidade,
                                                    child: Text(cidade.nome!),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  CidadeModel cidade =
                                                      val as CidadeModel;
                                                  controller.onChange(
                                                      cidade: cidade);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: AppColors.stroke,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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
      bottomNavigationBar: BottomButtonsWidget(
        primaryLabel: "Voltar",
        primaryOnPressed: () {
          homeController.mudarDePagina(homeController.paginaAtual.value);
          Navigator.pushReplacementNamed(context, "/home");
        },
        secondaryLabel: "Alterar",
        secondaryOnPressed: () async {
          if (controller.formKey.currentState!.validate()) {
            await controller.alterarMinhasInformacoes();

            if (controller.errorException.value.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(controller.errorException.value),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Informações alteradas com sucesso."),
                ),
              );
            }
          }
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
