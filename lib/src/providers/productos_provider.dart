import 'dart:async';
import 'dart:convert';
import 'package:getapp/src/models/actores_model.dart';
import 'package:getapp/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  String _apiKey = '6267692dd120b73870f7d80e62ef3e45';
  String _url = 'api.themoviedb.org';
  String _language = 'es-Es';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Producto> _populares = [];

  final _popularesStreamController =
      StreamController<List<Producto>>.broadcast();

  Function(List<Producto>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Producto>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Producto>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final productos = Productos.fromJsonList(decodedData['results']);

    return productos.items;
  }

  Future<List<Producto>> getNuevos() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Producto>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits',
        {'api_key': _apiKey, 'language': _language});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Producto>> buscarProductos(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return await _procesarRespuesta(url);
  }
}
