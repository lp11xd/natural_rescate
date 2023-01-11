import 'package:flutter/material.dart';
import 'package:naturalrescue/constants.dart';
import 'package:naturalrescue/src/ui/login/login.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(18.0)),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.35,
            decoration: BoxDecoration(border: Border.all(color: kColorGreen)),
            child: Drawer(
              elevation: 0,
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: UserAccountsDrawerHeader(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(color: Colors.transparent),
                      accountName: Text(""),
                      accountEmail: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Pedro Castillo",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          Text("+5167676767",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                        ],
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://cdn1.iconfinder.com/data/icons/avatars-1-5/136/60-512.png"),
                        radius: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'PROTOCOLO'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'OBSERVACION'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'REGISTROS'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'CENTRO DE alerta'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'CREDITOS'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                          child: Text(
                            'Cerrar sesión'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width / 4),
                        Center(
                          child: Image.asset(
                            "assets/icons/rescue_logo.png",
                            width: 150,
                            height: 100,
                          ),
                        ),
                        Center(
                          child: const Text(
                              'Naturaldex es un equipo de investigación dedicado al uso de la tecnologia para la conservación e investigación de flora y fauna en Perú.'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
