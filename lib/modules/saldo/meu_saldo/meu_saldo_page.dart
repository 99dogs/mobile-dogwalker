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
            title: "Meu saldo",
          ),
        ],
      ),
    );
  }
}
