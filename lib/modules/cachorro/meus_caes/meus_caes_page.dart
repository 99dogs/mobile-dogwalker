import 'package:flutter/material.dart';
import 'package:dogwalker/modules/cachorro/meus_caes/meus_caes_controller.dart';
import 'package:dogwalker/modules/cachorro/meus_caes_list/meus_caes_list_widget.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';

class MeusCaesPage extends StatefulWidget {
  const MeusCaesPage({Key? key}) : super(key: key);

  @override
  _MeusCaesPageState createState() => _MeusCaesPageState();
}

class _MeusCaesPageState extends State<MeusCaesPage> {
  final controller = MeusCaesController();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus cães",
          ),
          MeusCaesListWidget(),
        ],
      ),
    );
  }
}
