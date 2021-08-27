import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsController {
  Completer<GoogleMapController> googleMapController = Completer();

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  final localizacaoHabilitada = ValueNotifier<bool>(false);
  final permissaoHabilitada = ValueNotifier<bool>(false);
  final markers = ValueNotifier<List<Marker>>([]);
  final cPosition = ValueNotifier<CameraPosition>(
    CameraPosition(
      target: LatLng(0, 0),
    ),
  );

  serviceEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  permissionGranted() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  getCurrentLocation() async {
    _locationData = await location.getLocation();
    List<Marker> newList = [
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(_locationData.latitude!, _locationData.longitude!),
      ),
    ];

    markers.value = newList;
  }
}
