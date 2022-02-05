import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/utils/shared_pref.dart';

class Controller extends GetxController {
  final SharedPref _sharedPref = SharedPref();

  //FAVORITOS
  List<Article> articulosFavoritos = [];
  Map<String, dynamic> mapFilter = {};
  List<Map<String, dynamic>> subjects = [];
  void guardarEnFavoritos(Article noticia) {
    articulosFavoritos.add(noticia);
    _sharedPref.save('noticias', articulosFavoritos);
  }

  @override
  void onInit() async {
    List<dynamic> lista = await _sharedPref.read('mensajes');
    if (lista != null) {
      lista.forEach((element) {
        Map<String, String> mapa = Map<String, String>.from(element);
        mensajesGlobales.add(mapa);
      });
    }

    super.onInit();
  }

  Future<void> eliminarDeFavoritos(
      BuildContext context, String tituloDeLaNoticia) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    articulosFavoritos
        .removeWhere((element) => element.title == tituloDeLaNoticia);
    mapFilter = {};
    subjects = [];
    await _sharedPref.remove('noticias');
    _sharedPref.save('noticias', articulosFavoritos);
    Navigator.of(context).pop();
    update(['favoritos']);
  }

  Future<List<dynamic>> traerFavoritos() async {
    List<dynamic> noticiasFavoritas = await _sharedPref.read('noticias');
    return noticiasFavoritas;
  }

  //CARRITO
  List<Article> articulosCarrito = [];
  Map<String, dynamic> mapFilter2 = {};
  List<Map<String, dynamic>> subjects2 = [];
  void guardarEnCarrito(Article noticia) {
    articulosCarrito.add(noticia);
    _sharedPref.save('carrito', articulosCarrito);
  }

  Future<void> eliminarDeCarrito(
      BuildContext context, String tituloDeLaNoticia) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    articulosCarrito
        .removeWhere((element) => element.title == tituloDeLaNoticia);
    mapFilter2 = {};
    subjects2 = [];
    await _sharedPref.remove('carrito');
    _sharedPref.save('carrito', articulosCarrito);
    Navigator.of(context).pop();
    update(['carrito']);
  }

  Future<List<dynamic>> traerCarrito() async {
    List<dynamic> noticiasFavoritas = await _sharedPref.read('carrito');
    return noticiasFavoritas;
  }

  //MENSAJE
  TextEditingController mensaje = TextEditingController();
  List<Map<String, String>> mensajesGlobales = [];
  bool mensajeActivo = false;
  int indexMensajeActivo;

  void guardarMensajesEnMemoria() {
    _sharedPref.save('mensajes', mensajesGlobales);
    update();
  }

  Future<List<Map<String, String>>> traerMensajes() async {
    List<Map<String, String>> mensajeria = [];
    List<dynamic> lista = await _sharedPref.read('mensajes');
    if (lista != null) {
      lista.forEach((element) {
        Map<String, String> mapa = Map<String, String>.from(element);
        mensajeria.add(mapa);
      });
    }

    return mensajeria;
  }
}
