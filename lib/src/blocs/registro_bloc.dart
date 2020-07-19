import 'dart:async';

import 'package:getapp/src/blocs/validadores.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc with Validadores{

  //BehaviorSubjet viene con el Broadcast incluido y se puede escuchar de cualquier parte de la aplicacion
  final _emailController = BehaviorSubject<String>();
  final _contrasenaController = BehaviorSubject<String>();  
  final _nombresController = BehaviorSubject<String>();
  final _apellidosController = BehaviorSubject<String>();
  final _fechaNacimientoController = BehaviorSubject<String>();
  final _numeroTelefonoController = BehaviorSubject<String>();
  final _confirmacionContrasenaController = BehaviorSubject<String>();  
  

  //Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get contrasenaStream => _contrasenaController.stream.transform(validarContrasena);
  Stream<String> get nombreStream => _nombresController.stream.transform(validarNombres);
  Stream<String> get apellidosStream => _apellidosController.stream.transform(validarApellidos);
  Stream<String> get fechaNacimientoStream => _fechaNacimientoController.stream.transform(validarFechaNacimiento);
  Stream<String> get numeroTelefonoStream => _numeroTelefonoController.stream.transform(validarNumeroTelefono);
  Stream<String> get confirmacionContrasenaStream => _confirmacionContrasenaController.stream.transform(validarConfirmacionContrasena);

  //Si los 2 Stream estan correcto devuelve true
  // Stream<bool> get formValidadoStream => Rx.combineLatest7(nombreStream, apellidosStream, fechaNacimientoStream, numeroTelefonoStream, emailStream, contrasenaStream, confirmacionContrasenaStream, (a, b, c, d, e, f, g) => true);
  Stream<bool> get formValidadoStream => Rx.combineLatest3(emailStream, contrasenaStream, confirmacionContrasenaStream, (a,b,c) => true);

  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeContrasena => _contrasenaController.sink.add;
  Function(String) get changeNombre => _nombresController.sink.add;
  Function(String) get changeApellidos => _apellidosController.sink.add;
  Function(String) get changeFechaNacimiento => _fechaNacimientoController.sink.add;
  Function(String) get changeNumeroTelefono => _numeroTelefonoController.sink.add;
  Function(String) get changeConfirmacionContrasena => _confirmacionContrasenaController.sink.add;

  //Obtener el ultimo valor ingresado
  String get email => _emailController.value;
  String get contrasena => _contrasenaController.value;
  String get confirmacioncontrasena => _confirmacionContrasenaController.value;
  String get nombre => _nombresController.value;
  String get apellidos => _apellidosController.value;
  String get fechaNacimiento => _fechaNacimientoController.value;
  String get numeroTelefono => _numeroTelefonoController.value;

  //Cerrar el stream
  dispose(){
    _emailController?.close();
    _contrasenaController?.close();
    _nombresController?.close();
    _apellidosController?.close();
    _fechaNacimientoController?.close();
    _numeroTelefonoController?.close();
    _confirmacionContrasenaController?.close();
  }

}