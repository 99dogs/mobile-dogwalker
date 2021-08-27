import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class MeusDepositosPage extends StatelessWidget {
  const MeusDepositosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus depósitos",
          ),
        ],
      ),
    );
  }
}
