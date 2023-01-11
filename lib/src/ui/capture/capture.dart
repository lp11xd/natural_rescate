import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_toggle_tab/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturalrescue/constants.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

class CaptureScreen extends StatefulWidget {
  final File image;
  const CaptureScreen({Key key, this.image}) : super(key: key);

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  var _tabTextIndexSelected = 0;
  bool _isDisplayed = false;
  var _tabTextIconIndexSelected = 0;
  var _tabIconIndexSelected = 0;
  var _tabSelectedIndexSelected = 0;

  var _listTextTabToggle = ["PAISAJE", "FAUNA"];

  final picker = ImagePicker();
  File _image;

  final List<Map<String, dynamic>> _itemsTaxon = [
    {
      'value': 'Ninguno',
      'label': 'ninguno',
    },
    {
      'value': 'Trafico',
      'label': 'trafico',
    },
    {
      'value': 'Atropellado',
      'label': 'atropellado',
    },
    {
      'value': 'Herido',
      'label': 'herido',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Align(
                          alignment: Alignment(-0.5, -0.2),
                          widthFactor: 0.9,
                          heightFactor: 0.5,
                          child: widget.image != null ? Image.file(widget.image) : Image.network('https://cdn.download.ams.birds.cornell.edu/api/v1/asset/362635561/900'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightInPercent(2, context),
                ),
                Center(
                  child: FlutterToggleTab(
                    // width in percent
                    width: 40,
                    borderRadius: 30,
                    height: 30,
                    selectedIndex: _tabTextIndexSelected,
                    selectedBackgroundColors: [kColorGreen, kColorGreen],
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                    unSelectedTextStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    labels: _listTextTabToggle,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabTextIndexSelected = index;
                      });
                    },
                    isScroll: false,
                  ),
                ),
                if (_tabTextIndexSelected == 0) _formLandscape(),
                if (_tabTextIndexSelected == 1) _formFauna(),
                ElevatedButton(
                    child: Text("Aceptar", style: TextStyle(fontSize: 14)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kColorGreen),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Colors.grey)))),
                    onPressed: () => null)
              ],
            ),
          )),
    );
  }

  Widget _formLandscape() {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            title: TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.map), hintText: 'Obteniendo'),
              readOnly: true,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(icon: Icon(Icons.timelapse)),
            initialValue: DateFormat().format(DateTime.now()),
          ),
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            icon: Icon(Icons.privacy_tip),
            items: _itemsTaxon,
            labelText: 'Taxonomia',
            onChanged: (val) {
              setState(() {});
            },
          ),
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            icon: Icon(Icons.privacy_tip),
            items: _itemsTaxon,
            labelText: 'Zona',
            onChanged: (val) {
              setState(() {});
            },
          ),
          TextFormField(
            decoration:
                InputDecoration(icon: Icon(Icons.book), hintText: 'Notas'),
            onChanged: (val) {},
          ),
          SizedBox(height: 10)
        ],
      ),
    ));
  }

  Widget _formFauna() {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            title: TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.map), hintText: 'Obteniendo'),
              readOnly: true,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(icon: Icon(Icons.timelapse)),
            initialValue: DateFormat().format(DateTime.now()),
          ),
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            icon: Icon(Icons.privacy_tip),
            items: _itemsTaxon,
            labelText: 'Taxonomia',
            onChanged: (val) {
              setState(() {});
            },
          ),
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            icon: Icon(Icons.privacy_tip),
            items: _itemsTaxon,
            labelText: 'Estado',
            onChanged: (val) {
              setState(() {});
            },
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_isDisplayed) {
                    _isDisplayed = false;
                  } else {
                    _isDisplayed = true;
                  }
                });
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(kColorGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          side: BorderSide(color: Colors.grey)))),
              child: Text("Ver más"),
            ),
          ),
          if(_isDisplayed)
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            icon: Icon(Icons.privacy_tip),
            items: _itemsTaxon,
            labelText: 'Accion',
            onChanged: (val) {
              setState(() {});
            },
          ),
          if(_isDisplayed)
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            icon: Icon(Icons.privacy_tip),
            items: _itemsTaxon,
            labelText: 'Zona',
            onChanged: (val) {
              setState(() {});
            },
          ),
          if(_isDisplayed)
          TextFormField(
            decoration:
                InputDecoration(icon: Icon(Icons.book), hintText: 'Notas'),
            onChanged: (val) {},
          )
        ],
      ),
    ));
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
