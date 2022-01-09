import 'package:flutter/material.dart';
import 'package:getapp/src/blocs/provider.dart';
import 'package:getapp/src/pages/home_page.dart';
import 'package:getapp/src/pages/landing_page.dart';
//Importaciones propias

import 'package:getapp/src/pages/login_page.dart';
import 'package:getapp/src/pages/producto_detalle.dart';
import 'package:getapp/src/pages/registro_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Market',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => LandingPage(),
        'login': (BuildContext context) => InicioSesion(),
        'registro': (BuildContext context) => Registrarse(),
        'detalle': (BuildContext context) => ProductoDetalle(),
      },
      theme: ThemeData(primaryColor: Colors.blueAccent),
    ));
  }
}
