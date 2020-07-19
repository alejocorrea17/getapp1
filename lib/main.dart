import 'package:flutter/material.dart';
import 'package:getapp/src/blocs/provider.dart';
//Importaciones propias
import 'package:getapp/src/pages/home_page.dart';
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
      title: 'Get it App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => InicioSesion(),
        'registro': (BuildContext context) => Registrarse(),
        'detalle': (BuildContext context) => ProductoDetalle(),
      },
      theme: ThemeData(
        primaryColor: Colors.blueAccent
      ),
    )
  );
  }
}
