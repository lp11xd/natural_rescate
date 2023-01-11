import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturalrescue/constants.dart';
import 'package:naturalrescue/src/ui/capture/capture.dart';
import 'package:naturalrescue/src/ui/widgets/credits_widget.dart';
import 'package:naturalrescue/src/ui/widgets/custom_expandable_card.dart';

class RescueCenterScreen extends StatefulWidget {
  const RescueCenterScreen({Key key}) : super(key: key);

  @override
  State<RescueCenterScreen> createState() => _RescueCenterScreenState();
}

class _RescueCenterScreenState extends State<RescueCenterScreen> {
  final picker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    Widget _page() => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 320,
                  height: 30,
                  decoration: BoxDecoration(
                      color: kColorGreen,
                      border: Border.all(
                        color: kColorGreen,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text('Centros de alerta'.toUpperCase()),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: 220,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text('alerta serfor'.toUpperCase()),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/whatsapp.png',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 10),
                  Text('947-588269', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) )
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/images/resource_alert.png',
                    width: MediaQuery.of(context).size.width - 40,
                    height: 250,
                  ),
                ),
              ),
            ],
          ),
        );

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
      body: ExpandableCardPage(
        page: _page(),
        expandableCard: ExpandableCard(
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          maxHeight: MediaQuery.of(context).size.height - 50,
          minHeight: 200,
          hasRoundedCorners: true,
          hasShadow: false,
          hasHandle: false,
          children: <Widget>[creditsWidget()],
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
