import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
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
  bool _isLoading = true;
  PDFDocument document = PDFDocument();

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(
        "https://cdn.statically.io/gh/99dogs/documents/master/politica-de-dados-e-privacidade.pdf");
    setState(() => _isLoading = false);
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
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : PDFViewer(
                        document: document,
                        zoomSteps: 1,
                        showPicker: false,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
