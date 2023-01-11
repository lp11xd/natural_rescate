import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturalrescue/src/ui/capture/capture.dart';
import 'package:naturalrescue/src/ui/map/map_controller.dart';
import 'package:provider/provider.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final picker = ImagePicker();
  File _image;
  GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt_outlined, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text('CAMARA'),
                          onTap: () {
                            _imgFromCamera();
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.image_search),
                          title: const Text('GALERIA'),
                          onTap: () {
                            _imgFromGallery();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          )
        ],
      ),
      body: ChangeNotifierProvider<MapsController>(
        create: (_) {
          final controller = MapsController();
          controller.onMarkerTap.listen((int id) async {
            
          });
          return controller;
        },
        child: Consumer<MapsController>(
          builder: (_, controller, __) => Scaffold(
            body: GoogleMap(
              markers: controller.markers,
              onMapCreated: (GoogleMapController gcontroller) {
                controller.onMapCreated(gcontroller);
                controller.getBounds(gcontroller);
                _controller = gcontroller;
              },
              initialCameraPosition: controller.initialCameraPosition,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () async {
                  var points = await _controller.getVisibleRegion();
                 
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startDocked,
          ),
        )),
    );
  }

  Future _imgFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => CaptureScreen(image: _image)));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => CaptureScreen(image: _image)));
      } else {
        print('No image selected.');
      }
    });
  }
}
