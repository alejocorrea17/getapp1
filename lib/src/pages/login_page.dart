import 'package:flutter/material.dart';
import 'package:getapp/src/blocs/login_bloc.dart';
import 'package:getapp/src/blocs/provider.dart';
import 'package:getapp/src/pages/tabs_page.dart';

class InicioSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _formularioInicioSesion(context)
      ],
    ));
  }
}

Widget _formularioInicioSesion(BuildContext context) {
  final bloc = Provider.of(context);
  final size = MediaQuery.of(context).size;

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 190.0,
          ),
        ),
        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0),
              ]),
          child: Column(
            children: <Widget>[
              Text('Iniciar Sesion', style: TextStyle(fontSize: 20.0)),
              SizedBox(
                height: 40.0,
              ),
              _crearEmail(bloc),
              SizedBox(
                height: 20.0,
              ),
              _crearContrasena(bloc),
              SizedBox(
                height: 20.0,
              ),
              _crearBoton(bloc),
            ],
          ),
        ),
        _olvidoContrasena(),
        SizedBox(
          height: 100.0,
        ),
      ],
    ),
  );
}

Widget _crearEmail(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.blueAccent),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electronico',
              counterText: snapshot.data,
              errorText: snapshot.error),
          onChanged: bloc.changeEmail,
        ),
      );
    },
  );
}

Widget _crearContrasena(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.contrasenaStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.blueAccent),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error),
          onChanged: bloc.changeContrasena,
        ),
      );
    },
  );
}

Widget _crearBoton(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.formValidadoStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 1.0,
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(context, bloc) : null);
    },
  );
}

_login(BuildContext context, LoginBloc bloc) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => TabsPage()));
}

Widget _olvidoContrasena() {
  return Text('¿Olvidó su contraseña?');
}

Widget _crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;

  final fondoSuperior = Container(
    height: size.height * 0.4,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
      Color.fromRGBO(3, 63, 156, 1.0),
      Color.fromRGBO(0, 70, 178, 1.0)
    ])),
  );

  return Stack(
    children: <Widget>[
      fondoSuperior,
      Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 5.0,
                width: double.infinity,
              ),
              Text(
                'Smart Shopping',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ))
    ],
  );
}
