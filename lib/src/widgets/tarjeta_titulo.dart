import 'package:flutter/material.dart';
import 'package:getapp/src/models/news_models.dart';

class TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          noticia.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ));
  }
}
