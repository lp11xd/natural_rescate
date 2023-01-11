import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturalrescue/constants.dart';
import 'package:naturalrescue/src/ui/capture/capture.dart';
import 'package:naturalrescue/src/ui/observations/observations.dart';
import 'package:naturalrescue/src/ui/protocols/protocols.dart';
import 'package:naturalrescue/src/ui/rescue_centers/rescue_centers.dart';
import 'package:naturalrescue/src/ui/widgets/custom_drawer.dart';
import 'package:naturalrescue/src/ui/widgets/custom_scroll.dart';
import 'package:scroll_navigation/navigation/scroll_navigation.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int initialPage = 1;
  final picker = ImagePicker();
  File _image;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initialPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialPage == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ProtocolScreen()));
      }

      if (initialPage == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ObservationScreen()));
      }
    });

    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
        ),
        drawer: CustomDrawer(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.4295,
                child: CustomScrollNavigation(
                  initialPage: initialPage,
                  onChanged: (int value) {
                    setState(() {
                      initialPage = value;
                    });
                  },
                  bodyStyle: NavigationBodyStyle(
                    background: Colors.black,
                  ),
                  barStyle: NavigationBarStyle(
                      background: Colors.black,
                      elevation: 0.0,
                      activeColor: kColorGreen),
                  pages: [
                    Container(color: Colors.black),
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {}, icon: const Icon(Icons.close)),
                              ),
                              const Text(
                                '¿Te encuentras frente a un \n           avistamiento?',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              const Text('Tomale una foto y registralo',
                                  style: TextStyle(fontSize: 18)),
                              const SizedBox(height: 20),
                              OutlinedButton(
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
                                              leading: const Icon(
                                                  Icons.image_search),
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
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                ),
                                child: const Text("Aceptar"),
                              ),
                              Image.asset('assets/icons/gray_logo.png',width: 140, height: 92),
                              SizedBox(height: 40),
                              Row(
                                children: [
                                  Image.network(
                                      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/362635561/900',
                                      height: 100,
                                      width: 110),
                                  Image.network(
                                      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/362635561/900',
                                      height: 100,
                                      width: 112),
                                  Image.network(
                                      'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/362635561/900',
                                      height: 100,
                                      width: 110)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(color: Colors.black),
                  ],
                  items: const [
                    ScrollNavigationItem(
                        icon: Icon(Icons
                            .signal_wifi_statusbar_connected_no_internet_4_sharp),
                        title: 'PROTOCOLO',
                        titleStyle: TextStyle(color: Colors.white)),
                    ScrollNavigationItem(
                        icon: Icon(Icons
                            .signal_wifi_statusbar_connected_no_internet_4_sharp),
                        title: 'RESCATE',
                        titleStyle: TextStyle(color: Colors.white)),
                    ScrollNavigationItem(
                        icon: Icon(Icons
                            .signal_wifi_statusbar_connected_no_internet_4_sharp),
                        title: 'REGISTRO',
                        titleStyle: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height / 5.915,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () {
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
                        child: Container(
                          width: 100,
                          height: MediaQuery.of(context).size.height * 0.080,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1), // border color
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2), // border width
                            child: Container(
                              // or ClipRRect if you need to clip the content
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorGreen, // inner circle color
                              ),
                              child: Container(), // inner content
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text('______', style: TextStyle(color: Colors.white)),
                    InkWell(
                      child: const Text('  CENTROS \nDE RESCATE',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RescueCenterScreen()));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
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
