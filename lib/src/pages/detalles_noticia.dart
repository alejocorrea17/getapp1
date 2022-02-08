import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getapp/src/controller/controller.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/pages/carrito_page.dart';
import 'package:getapp/src/theme/tema.dart';
import 'package:getapp/src/widgets/lista_noticias.dart';

class DetalleNoticia extends StatelessWidget {
  final Article noticia;
  final int index;

  DetalleNoticia(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> mensajes = [];

    List<String> mensajes2 = [];
    final controller = Get.put(Controller());
    return GetBuilder<Controller>(
        id: 'inicio',
        builder: (_) {
          return FutureBuilder(
              future: controller.traerMensajes(),
              builder: (context, snapshot) {
                mensajes = snapshot.data;

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
                          TarjetaBotones(noticia, index, true, ''),
                          Container(
                            height: 50,
                            child: GetBuilder<Controller>(
                              id: 'mensaje',
                              builder: (_) {
                                mensajes2 = [];
                                if (mensajes != null) {
                                  for (var item in mensajes) {
                                    mensajes2.addAllIf(
                                      item.keys.toString() ==
                                          '(${noticia.title})',
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
                                child: index == controller.indexMensajeActivo
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: TextField(
                                          controller: controller.mensaje,
                                          decoration: InputDecoration(
                                            labelText: 'Escribe un mensaje...',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.send),
                                              onPressed: () {
                                                if (controller.mensaje.text !=
                                                    '') {
                                                  controller.mensajesGlobales
                                                      .add({
                                                    noticia.title:
                                                        controller.mensaje.text
                                                  });
                                                  controller.mensaje.text = '';
                                                  controller
                                                      .guardarMensajesEnMemoria();
                                                  controller
                                                      .update(['mensaje']);
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
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
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
