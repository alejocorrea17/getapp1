import 'package:flutter/material.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/theme/tema.dart';

class Carrito extends StatelessWidget {
  final Article noticia;
  final int index;

  Carrito(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    final List<Article> noticias = [];
    var cantidad = 0;
    noticias.add(noticia);
    cantidad = noticias.length;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            'Carrito',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  SizedBox(height: 10),
                  _TarjetaTopBar(noticia, index),
                  SizedBox(height: 10),
                  _ImagenNoticia(noticia),
                ]))));
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: miTema.accentColor),
          ),
          Text('${noticia.source.name}'),
        ],
      ),
    );
  }
}

class _ImagenNoticia extends StatelessWidget {
  final Article noticia;

  const _ImagenNoticia(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: (noticia.urlToImage != null)
                ? FadeInImage(
                    placeholder: AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(noticia.urlToImage))
                : Image(
                    image: AssetImage('assets/img/no-image.png'),
                  )),
      ),
    );
  }
}
