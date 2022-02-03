
import 'dart:async';

class Validadores {

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      }else{
        sink.addError('Email no es correcto');
      }
    }
  );

  final validarContrasena = StreamTransformer<String, String>.fromHandlers(
    handleData: ( contrasena, sink){

      if (contrasena.length>= 6) {
        sink.add(contrasena);
      }else{
        sink.addError('Más de 6 caracteres');
      }
    }
  );

  final validarNombres = StreamTransformer<String, String>.fromHandlers(
    handleData: ( nombre, sink){

      if (nombre.isNotEmpty) {
        sink.add(nombre);
      }else{
        sink.addError('Ingresar nombre');
      }
    }
  );

  final validarApellidos = StreamTransformer<String, String>.fromHandlers(
    handleData: ( apellidos, sink){

      if (apellidos.isNotEmpty) {
        sink.add(apellidos);
      }else{
        sink.addError('Ingresar apellidos');
      }
    }
  );

  final validarFechaNacimiento = StreamTransformer<String, String>.fromHandlers(
    handleData: ( fechaNacimiento, sink){

      if (fechaNacimiento.isNotEmpty) {
        sink.add(fechaNacimiento);
      }else{
        sink.addError('Ingresar Fecha Nacimiento valida');
      }
    }
  );

  final validarNumeroTelefono = StreamTransformer<String, String>.fromHandlers(
    handleData: ( numeroTelefono, sink){

      if (numeroTelefono.isNotEmpty) {
        sink.add(numeroTelefono);
      }else{
        sink.addError('Ingresar número de telefono');
      }
    }
  );

  final validarConfirmacionContrasena = StreamTransformer<String, String>.fromHandlers(
    handleData: ( confirmacionContrasena, sink){

      if (confirmacionContrasena.length >=6) {
        sink.add(confirmacionContrasena);
      }else{
        sink.addError('Más de 6 caracteres');
      }
    }
  );

  
}