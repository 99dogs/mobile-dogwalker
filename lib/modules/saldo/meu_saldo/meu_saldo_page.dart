import 'package:dogwalker/modules/saldo/meu_saldo_list/meu_saldo_list.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class MeuSaldoPage extends StatelessWidget {
  const MeuSaldoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus Saldos",
          ),
          MeuSaldoList(),
        ],
      ),
    );
  }
}
