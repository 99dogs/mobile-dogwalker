import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:dogwalker/modules/passeio/passeio_detalhes/passeio_detalhes_controller.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dogwalker/modules/passeio/maps_widget/maps_controller.dart';
import 'package:location/location.dart';

const double CAMERA_ZOOM = 19;
const double CAMERA_TILT = 40;
const double CAMERA_BEARING = 5;

class MapsWidget extends StatefulWidget {
  final int id;
  const MapsWidget({
    Key? key,
    int,
    required this.id,
  }) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final controller = MapsController();
  final passeioDetalhesController = PasseioDetalhesController();

  late StreamSubscription<LocationData> locationSubscription;

  late LocationData currentLocation;
  Set<Marker> _markers = Set<Marker>();
  final CameraPosition _inicialCameraPosition = CameraPosition(
    target: LatLng(-22.2338215, -45.7029303),
    zoom: CAMERA_ZOOM,
    tilt: CAMERA_TILT,
    bearing: CAMERA_BEARING,
  );

  String _scanBarcode = "";

  @override
  void initState() {
    super.initState();
    permissoes();
    iniciar();
  }

  permissoes() async {
    await controller.serviceEnabled();
    await controller.permissionGranted();
    await controller.getCurrentLocation();
    await controller.backgroundMode(true);
  }

  iniciar() async {
    await controller.alterarConfigs();
    locationSubscription = controller.location.onLocationChanged.listen(
      (LocationData cLoc) {
        print(cLoc);
        currentLocation = cLoc;
        updatePinOnMap();
      },
    );
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
    );

    if (!mounted) return;

    final GoogleMapController controllerMap =
        await controller.googleMapController.future;
    controllerMap.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(
      () {
        var pinPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);

        _markers.removeWhere((m) => m.markerId.value == 'dogwalker');
        _markers.add(
          Marker(markerId: MarkerId('dogwalker'), position: pinPosition),
        );
      },
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#FF280059', 'Cancelar', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              color: AppColors.primary,
            ),
            Container(
              color: AppColors.background,
              child: Column(
                children: [
                  TitlePageWidget(
                    title: "Andamento do passeio",
                    enableBackButton: true,
                    routePage: "/passeio/detail",
                    args: widget.id,
                  ),
                ],
              ),
            ),
            Container(
              height: size.height - 175,
              child: GoogleMap(
                myLocationEnabled: false,
                zoomControlsEnabled: true,
                markers: _markers,
                initialCameraPosition: _inicialCameraPosition,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController mapsController) {
                  controller.googleMapController.complete(mapsController);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: AppColors.delete,
          ),
          icon: Icon(
            Icons.done_all_outlined,
            size: 15,
          ),
          label: Text("Finalizar"),
          onPressed: () async {
            await scanQR();
            String? response = "";
            if (_scanBarcode != "-1" && _scanBarcode == widget.id.toString()) {
              response = await passeioDetalhesController.alterarStatus(
                widget.id,
                "finalizar",
              );
            } else if (_scanBarcode != widget.id.toString()) {
              response = "Passeio diferente do atual.";
            } else {
              response = "Não foi possível ler o código.";
            }

            if (response != null && response.isNotEmpty) {
              CoolAlert.show(
                context: context,
                title: "Ocorreu um problema\n",
                text: response,
                backgroundColor: AppColors.primary,
                type: CoolAlertType.error,
                confirmBtnText: "Fechar",
                confirmBtnColor: AppColors.shape,
                confirmBtnTextStyle: TextStyles.buttonGray,
              );
            } else {
              await controller.backgroundMode(false);
              await locationSubscription.cancel();

              Navigator.pushReplacementNamed(
                context,
                "/passeio/detail",
                arguments: widget.id,
              );
            }
          },
        ),
      ),
    );
  }
}
