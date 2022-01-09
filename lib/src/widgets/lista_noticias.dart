import 'package:flutter/material.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/models/product_model.dart';
import 'package:getapp/src/pages/detalles_noticia.dart';
import 'package:getapp/src/theme/tema.dart';
import 'package:provider/provider.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(
          noticia: this.noticias[index],
          index: index,
        );
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({this.noticia, this.index});

  @override
  Widget build(BuildContext context) {
    final productoModel = Provider.of<ProductoModelo>(context);

    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia, index),
        _TarjetaBody(noticia),
        _TarjetaBotones(noticia, productoModel.liked, true, ''),
        SizedBox(
          height: 10.0,
        ),
        Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  final Article noticia;

  final bool liked;
  final bool agregadoCarrito;
  final String comentario;

  _TarjetaBotones(
      this.noticia, this.liked, this.agregadoCarrito, this.comentario);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            // liked = true;
            final productoModel =
                Provider.of<ProductoModelo>(context, listen: false);
            productoModel.liked = this.liked;
          },
          fillColor: miTema.accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.star,
              color: (this.liked) ? Colors.yellow : Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.message),
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.add_shopping_cart),
        )
      ],
    ));
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description != null) ? noticia.description : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaImagen(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetalleNoticia(noticia, index)));
      },
      child: Container(
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
