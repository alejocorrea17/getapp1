import 'package:flutter/material.dart';
import 'package:getapp/src/models/news_models.dart';

class Carrito extends StatelessWidget {
  final Article noticia;

  const Carrito({Key key, this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
    );
  }
}
