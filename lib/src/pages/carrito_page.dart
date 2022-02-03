import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getapp/src/controller/controller.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/theme/tema.dart';
import 'package:getapp/src/widgets/lista_noticias.dart';

class Carrito extends StatelessWidget {
  final Controller controller;
  Carrito({@required this.controller});

  @override
  Widget build(BuildContext context) {
    List<Article> listaDeCarrito = [];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<Controller>(
          id: 'carrito',
          builder: (_) {
            return FutureBuilder(
                future: controller.traerCarrito(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData || snapshot.data != null) {
                    listaDeCarrito = [];
                    for (var item in snapshot.data) {
                      listaDeCarrito.add(Article.fromJson(item));
                    }
                    controller.articulosCarrito = listaDeCarrito;
                    Map<String, Article> mp = {};
                    for (var item in listaDeCarrito) {
                      mp[item.title] = item;
                    }
                    List<Article> listaDeCarritoFiltrada = mp.values.toList();
                    return ListaNoticias(
                      listaDeCarritoFiltrada,
                      carrito: true,
                    );
                  } else {
                    return Container();
                  }
                });
          },
        ),
      ),
    );
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
