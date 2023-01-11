import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturalrescue/constants.dart';
import 'package:naturalrescue/src/ui/capture/capture.dart';
import 'package:naturalrescue/src/ui/utils/image_cons.dart';
import 'package:naturalrescue/src/ui/widgets/credits_widget.dart';
import 'package:naturalrescue/src/ui/widgets/custom_expandable_card.dart';

class ProtocolScreen extends StatefulWidget {
  const ProtocolScreen({Key key}) : super(key: key);

  @override
  State<ProtocolScreen> createState() => _ProtocolScreenState();
}

class _ProtocolScreenState extends State<ProtocolScreen> {
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
        page: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 30,
                  decoration: BoxDecoration(
                      color: kColorGreen,
                      border: Border.all(
                        color: kColorGreen,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text('PROTOCOLOS DE DIFERENCIA DE FAUNA'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 160,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text('FAUNA AFECTADA'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(alignment: Alignment.centerLeft, child: Text('AVES')),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CaptureScreen()));
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
                                ? ColorFilter.mode(Colors.grey.withOpacity(0.5),
                                    BlendMode.srcATop)
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
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 160,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text('FAUNA NO AFECTADA'),
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                    child: const Text(
                        'Observa bien el comportamiento y posicion del animal, acercate con cuidado, toma una fotografia con Naturaldex y procura no alterar al animal'),
                  ))
            ],
          ),
        ),
        expandableCard: ExpandableCard(
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(top: 5, left: 20, right: 20),
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
