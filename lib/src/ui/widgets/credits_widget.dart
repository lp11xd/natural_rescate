import 'package:flutter/material.dart';

Widget creditsWidget() {
  return Expanded(
    child: Column(
      children: [
        Image.asset('assets/icons/gray_logo.png', width: 120, height: 50),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('desarrollado por\n     Natural DEX'.toUpperCase())
          ],
        ),
        SizedBox(height: 10),
        const Text(
            'El equipo de biólogos y programadores de Naturaldex, claves para el desarrollo del aplicativo.'),
        SizedBox(height: 10),
        const Text('Equipo Biológico',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Harryson Gonzalez'),
        const Text('Peter Condori'),
        const Text('Araseli Elme'),
        SizedBox(height: 10),
        const Text('Equipo de programación',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Yishar Yanqui'),
        const Text('Diego Huarcaya'),
        SizedBox(height: 10),
        const Text('Equipo de diseño',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Hans Sandoval'),
        const Text('Equipo ADDO'),
        SizedBox(height: 15),
        const Text('contacto', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('naturaldex@gmail.com'),
        const Text('Teléf: 925292359 / 936772850 / 979389130'),
        SizedBox(height: 25),
        Align(
            alignment: Alignment.centerLeft,
            child: const Text('En colaboración',
                style: TextStyle(fontWeight: FontWeight.bold))),
        SizedBox(height: 15),
        Align(
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/icons/eddo.png', width: 80, height: 80)),
      ],
    ),
  );
}
