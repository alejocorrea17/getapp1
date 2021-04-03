import 'package:flutter/material.dart';
import 'package:getapp/src/pages/home_page.dart';
import 'package:getapp/src/pages/landing_page.dart';
import 'package:getapp/src/pages/login_page.dart';
import 'package:getapp/src/pages/producto_detalle.dart';
import 'package:getapp/src/pages/registro_page.dart';
import 'package:getapp/src/pages/tab1_page.dart';
import 'package:getapp/src/pages/tab2_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LandingPage(),
    'login': (BuildContext context) => InicioSesion(),
    'registro': (BuildContext context) => Registrarse(),
    'detalle': (BuildContext context) => ProductoDetalle(),
    'homePage': (BuildContext context) => HomePage(),
    'tab1Page': (BuildContext context) => Tab1Page(),
    'tab2Page': (BuildContext context) => Tab2Page(),
  };
}
