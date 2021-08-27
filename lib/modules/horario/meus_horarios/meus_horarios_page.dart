import 'package:dogwalker/modules/horario/meus_horarios_list/meus_horarios_list.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';

class MeusHorariosPage extends StatefulWidget {
  const MeusHorariosPage({Key? key}) : super(key: key);

  @override
  _MeusHorariosPageState createState() => _MeusHorariosPageState();
}

class _MeusHorariosPageState extends State<MeusHorariosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus horários",
          ),
          MeusHorariosList(),
        ],
      ),
    );
  }
}
