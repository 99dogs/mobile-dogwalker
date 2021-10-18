import 'package:flutter/material.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';

class PoliticaDeDadosEPrivacidadePage extends StatefulWidget {
  const PoliticaDeDadosEPrivacidadePage({Key? key}) : super(key: key);

  @override
  _PoliticaDeDadosEPrivacidadePageState createState() =>
      _PoliticaDeDadosEPrivacidadePageState();
}

class _PoliticaDeDadosEPrivacidadePageState
    extends State<PoliticaDeDadosEPrivacidadePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                    title: "Política de dados e privacidade",
                    enableBackButton: true,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
