import 'package:dogwalker/modules/qualificacao/minhas_qualificacoes_list/minhas_qualificacoes_list.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class MinhasQualificacoesPage extends StatelessWidget {
  const MinhasQualificacoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Minhas qualificações",
          ),
          MinhasQualificacoesList(),
        ],
      ),
    );
  }
}
