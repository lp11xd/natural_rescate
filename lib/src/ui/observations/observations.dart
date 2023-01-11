import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturalrescue/src/ui/capture/capture.dart';
import 'package:naturalrescue/src/ui/map/map.dart';
import 'package:naturalrescue/src/ui/utils/image_cons.dart';

class ObservationScreen extends StatefulWidget {
  const ObservationScreen({Key key}) : super(key: key);

  @override
  State<ObservationScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends State<ObservationScreen> {
  final picker = ImagePicker();
  File _image;

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
            icon: Icon(Icons.map, color: Colors.black),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
            },
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AVES'),
            SizedBox(height: 10),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RawMaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CaptureScreen(
                    
                    )));
                  },
                  child: Hero(
                    tag: 'logo$index',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.airtransportanimal.com/wp-content/uploads/1970/01/panama-animal-transport-plane.jpg'),
                          colorFilter: index != 0
                              ? ColorFilter.mode(
                                  Colors.grey.withOpacity(0.5), BlendMode.srcATop)
                              : ColorFilter.mode(
                                  Colors.transparent, BlendMode.srcATop),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: images.length,
            ),
          ],
        ),
      ),
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
