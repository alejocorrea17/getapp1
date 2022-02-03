import 'package:flutter/material.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/pages/carrito_page.dart';
import 'package:getapp/src/theme/tema.dart';

class DetalleNoticia extends StatelessWidget {
  final Article noticia;
  final int index;

  DetalleNoticia(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Social Market',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10),
              _TarjetaTopBar(noticia, index),
              SizedBox(height: 10),
              _TarjetaTitulo(noticia),
              SizedBox(height: 10),
              _ImagenNoticia(noticia),
              SizedBox(height: 10),
              _TarjetaBody(noticia),
              SizedBox(height: 10),
              _TarjetaBotones(noticia, index)
            ],
          ),
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description != null) ? noticia.description : '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
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

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

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

class _TarjetaBotones extends StatelessWidget {
  final Article noticia;
  final int index;

  _TarjetaBotones(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {},
          fillColor: miTema.accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.star, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {
            _Mensajes('Hola');
          },
          fillColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.add_comment),
        ),
        RawMaterialButton(
          onPressed: () {
            // Carrito(null, 0);
          },
          fillColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.add_shopping_cart),
        )
      ],
    ));
  }
}

class _Mensajes extends StatelessWidget {
  final String texto;

  const _Mensajes(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hola' + texto),
    );
  }
}
