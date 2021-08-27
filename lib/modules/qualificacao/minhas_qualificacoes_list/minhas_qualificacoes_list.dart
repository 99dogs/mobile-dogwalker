import 'package:dogwalker/modules/qualificacao/qualificacao_controller.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/shimmer_list_tile/shimmer_list_tile.dart';
import 'package:flutter/material.dart';

class MinhasQualificacoesList extends StatefulWidget {
  const MinhasQualificacoesList({Key? key}) : super(key: key);

  @override
  _MinhasQualificacoesListState createState() =>
      _MinhasQualificacoesListState();
}

class _MinhasQualificacoesListState extends State<MinhasQualificacoesList> {
  final controller = QualificacaoController();

  @override
  void initState() {
    super.initState();
    buscarQualificacoes();
  }

  buscarQualificacoes() async {
    await controller.buscarQualificacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          StateEnum state = value as StateEnum;
          if (state == StateEnum.loading) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ShimmerListTileWidget();
                  },
                ),
              ),
            );
          } else if (state == StateEnum.success) {
            if (controller.qualificacoes.isNotEmpty) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.buscarQualificacoes();
                    },
                    child: ListView.builder(
                      itemCount: controller.qualificacoes.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      controller.qualificacoes[index]
                                              .modalidade! +
                                          ' - ' +
                                          controller
                                              .qualificacoes[index].titulo!,
                                      style: TextStyles.titleListTile,
                                    ),
                                  ),
                                  subtitle: Text(
                                    controller.qualificacoes[index].descricao!,
                                  ),
                                  trailing: Icon(Icons.arrow_right_alt),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 13,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    child: Text(
                      "Você ainda não cadastrou nenhuma qualificação.",
                      style: TextStyles.input,
                    ),
                  ),
                ),
              );
            }
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
                        controller.buscarQualificacoes();
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
    );
  }
}
