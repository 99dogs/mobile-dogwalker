import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dogwalker/modules/passeio/maps_widget/maps_controller.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({Key? key}) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final controller = MapsController();

  final CameraPosition _inicialCameraPosition = CameraPosition(
    target: LatLng(-22.2338215, -45.7029303),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    controller.serviceEnabled();
    controller.permissionGranted();
    controller.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.markers,
      builder: (_, value, __) {
        return Scaffold(
          body: GoogleMap(
            zoomControlsEnabled: true,
            markers: Set<Marker>.of(controller.markers.value),
            initialCameraPosition: _inicialCameraPosition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controllerMap) {},
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: Text('To the lake!'),
            icon: Icon(Icons.directions_boat),
          ),
        );
      },
    );
  }
}
