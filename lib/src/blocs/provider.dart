import 'package:flutter/material.dart';
import 'package:getapp/src/blocs/login_bloc.dart';
import 'package:getapp/src/blocs/registro_bloc.dart';

//Esta clase se va a llamar cada vez que se vaya a redibujar un Widget
class Provider extends InheritedWidget {
  static Provider _instancia;

  //Constructor del provider
  factory Provider({Key key, Widget child}) {
    //Si la instancia, no tiene informacion llama al constructor interno
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    //Si la instancia tiene informacion los retorna.
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();
  final registroBloc = RegistroBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  // static RegistroBloc of(BuildContext context){
  //   return context.dependOnInheritedWidgetOfExactType<Provider>().registroBloc;
  // }
}
