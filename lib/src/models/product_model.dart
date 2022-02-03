import 'package:flutter/material.dart';

class ProductoModelo with ChangeNotifier {
  bool _liked = false;
  String _comentario = '';
  bool _agregadoCarrito = false;

  bool get liked => this._liked;
  set liked(bool valor) {
    this._liked = valor;
    notifyListeners();
  }

  bool get agregadoCarrito => this._agregadoCarrito;
  set agregadoCarrito(bool valor) {
    this._agregadoCarrito = valor;
    notifyListeners();
  }

  String get comentario => this._comentario;
  set comentario(String valor) {
    this._comentario = valor;
    notifyListeners();
  }
}
