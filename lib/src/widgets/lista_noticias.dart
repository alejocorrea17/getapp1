// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getapp/src/controller/controller.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/models/product_model.dart';
import 'package:getapp/src/pages/carrito_page.dart';
import 'package:getapp/src/pages/detalles_noticia.dart';
import 'package:getapp/src/theme/tema.dart';
import 'package:provider/provider.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;
  final bool favoritos;
  final bool carrito;

  const ListaNoticias(this.noticias,
      {this.favoritos = false, this.carrito = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());

    return GetBuilder<Controller>(
        id: 'inicio',
        builder: (_) {
          return FutureBuilder(
              future: controller.traerMensajes(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: this.noticias.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        _Noticia(
                          noticia: this.noticias[index],
                          index: index,
                          favoritos: favoritos,
                          carrito: carrito,
                          mensajes: snapshot.data,
                        ),
                        favoritos == true || carrito == true
                            ? Positioned(
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () async {
                                    if (favoritos == true) {
                                      await controller.eliminarDeFavoritos(
                                          context, this.noticias[index].title);
                                    }
                                    if (carrito == true) {
                                      await controller.eliminarDeCarrito(
                                          context, this.noticias[index].title);
                                    }
                                  },
                                ),
                                top: 0,
                                right: 0,
                              )
                            : SizedBox(),
                      ],
                    );
                  },
                );
              });
        });
  }
}

class _Noticia extends StatefulWidget {
  final Article noticia;
  final int index;
  final bool favoritos;
  final bool carrito;
  final List<Map<String, String>> mensajes;

  const _Noticia(
      {this.noticia, this.index, this.favoritos, this.carrito, this.mensajes});

  @override
  State<_Noticia> createState() => _NoticiaState();
}

class _NoticiaState extends State<_Noticia> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    List<String> mensajes2 = [];
    print('aca vamos');

    return Column(
      children: <Widget>[
        _TarjetaTopBar(widget.noticia, widget.index),
        _TarjetaTitulo(widget.noticia),
        _TarjetaImagen(widget.noticia, widget.index, widget.mensajes),
        _TarjetaBody(widget.noticia),
        widget.favoritos == true || widget.carrito == true
            ? SizedBox()
            : TarjetaBotones(widget.noticia, widget.index, true, ''),
        Container(
          height: 50,
          child: GetBuilder<Controller>(
            id: 'mensaje',
            builder: (_) {
              print('mensajes sin filtro: ' + widget.mensajes.toString());
              mensajes2 = [];
              if (widget.mensajes != null) {
                for (var item in widget.mensajes) {
                  mensajes2.addAllIf(
                    item.keys.toString() == '(${widget.noticia.title})',
                    item.values,
                  );
                }
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: mensajes2.length,
                itemBuilder: (context, index) {
                  return Text(mensajes2[index]);
                },
              );
            },
          ),
        ),
        GetBuilder<Controller>(
          id: 'index',
          builder: (_) {
            return Container(
              child: widget.index == controller.indexMensajeActivo
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        controller: controller.mensaje,
                        decoration: InputDecoration(
                          labelText: 'Escribe un mensaje...',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              if (controller.mensaje.text != '') {
                                controller.mensajesGlobales.add({
                                  widget.noticia.title: controller.mensaje.text
                                });
                                controller.mensaje.text = '';
                                controller.guardarMensajesEnMemoria();
                                controller.update(['mensaje']);
                                controller.update(['inicio']);
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            );
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        Divider(),
      ],
    );
  }
}

class TarjetaBotones extends StatelessWidget {
  final Article noticia;
  final int index;
  final bool agregadoCarrito;
  final String comentario;

  TarjetaBotones(
      this.noticia, this.index, this.agregadoCarrito, this.comentario);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            print('man');
            controller.guardarEnFavoritos(noticia);
          },
          fillColor: miTema.accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.star, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {
            print('controller.indexMensajeActivo: ' +
                controller.indexMensajeActivo.toString());

            print('index: ' + index.toString());
            if (controller.indexMensajeActivo == index) {
              controller.indexMensajeActivo = null;
            } else {
              controller.indexMensajeActivo = index;
            }
            controller.update(['index']);
            print('controller.indexMensajeActivo2: ' +
                controller.indexMensajeActivo.toString());

            print('index2: ' + index.toString());
          },
          fillColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.message),
        ),
        RawMaterialButton(
          onPressed: () {
            controller.guardarEnCarrito(noticia);
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
  final List<Map<String, String>> mensajes;

  const _TarjetaImagen(this.noticia, this.index, this.mensajes);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hola mundo');
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
