import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:naturalrescue/constants.dart';

class MapsController extends ChangeNotifier {
  List<Marker> _initialMarker = [];
  Set<Marker> get markers => _initialMarker.toSet();

  final _markersController = StreamController<int>.broadcast();
  Stream<int> get onMarkerTap => _markersController.stream;

  String _mapStyle;

  final initialCameraPosition =
      const CameraPosition(target: LatLng(37.422131, -122.084801), zoom: 5);


  void onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(mapStyle);
    notifyListeners();
  }

  void getBounds(GoogleMapController controller) async {
    var demo = await controller.getVisibleRegion();
    //_initialMarker.forEach((element) {
    //  demo.contains(element.position);
    //});
  }


  @override
  void dispose() {
    _markersController.close();
    super.dispose();
  }
}