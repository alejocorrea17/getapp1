import 'dart:async';
import 'package:getapp/src/blocs/validadores.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validadores {
  //BehaviorSubjet viene con el Broadcast incluido y se puede escuchar de cualquier parte de la aplicacion
  final _emailController = BehaviorSubject<String>();
  final _contrasenaController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get contrasenaStream =>
      _contrasenaController.stream.transform(validarContrasena);

  //Si los 2 Stream estan correcto devuelve true
  Stream<bool> get formValidadoStream =>
      Rx.combineLatest2(emailStream, contrasenaStream, (e, p) => true);

  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeContrasena => _contrasenaController.sink.add;

  //Obtener el ultimo valor ingresado
  String get email => _emailController.value;
  String get contrasena => _contrasenaController.value;

  //Cerrar el stream
  dispose() {
    _emailController?.close();
    _contrasenaController?.close();
  }
}
