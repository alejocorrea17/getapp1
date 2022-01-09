import 'package:flutter/material.dart';
import 'package:getapp/src/blocs/registro_bloc.dart';

class Registrarse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _formularioRegistro(context),
      ],
    ));
  }
}

Widget _formularioRegistro(BuildContext context) {
  final bloc = RegistroBloc();
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
              Text('Registrarse', style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 40.0),
              _crearNombre(bloc),
              SizedBox(height: 20.0),
              _crearApellidos(bloc),
              SizedBox(height: 20.0),
              _crearFechaNacimiento(bloc),
              SizedBox(height: 20.0),
              _crearNumeroTelefono(bloc),
              SizedBox(height: 20.0),
              _crearEmail(bloc),
              SizedBox(height: 20.0),
              _crearContrasena(bloc),
              SizedBox(height: 20.0),
              _crearConfirmacionContrasena(bloc),
              SizedBox(height: 20.0),
              _crearBoton(bloc),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _crearNombre(RegistroBloc bloc) {
  return StreamBuilder(
    stream: bloc.nombreStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.text_rotation_none, color: Colors.blueAccent),
              labelText: 'Nombres',
              counterText: snapshot.data,
              errorText: snapshot.error),
          onChanged: bloc.changeNombre,
        ),
      );
    },
  );
}

Widget _crearApellidos(RegistroBloc bloc) {
  return StreamBuilder(
    stream: bloc.apellidosStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.text_rotation_none, color: Colors.blueAccent),
              labelText: 'Apellidos',
              counterText: snapshot.data,
              errorText: snapshot.error),
          onChanged: bloc.changeApellidos,
        ),
      );
    },
  );
}

Widget _crearFechaNacimiento(RegistroBloc bloc) {
  return StreamBuilder(
    stream: bloc.fechaNacimientoStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
              icon: Icon(Icons.date_range, color: Colors.blueAccent),
              hintText: 'DD/MM/YYYY',
              labelText: 'Fecha De Nacimiento',
              counterText: snapshot.data,
              errorText: snapshot.error),
          onChanged: bloc.changeFechaNacimiento,
        ),
      );
    },
  );
}

Widget _crearNumeroTelefono(RegistroBloc bloc) {
  return StreamBuilder(
    stream: bloc.numeroTelefonoStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              icon: Icon(Icons.phone_android, color: Colors.blueAccent),
              hintText: '+57 800 77 77',
              labelText: 'Número De Teléfono',
              counterText: snapshot.data,
              errorText: snapshot.error),
          onChanged: bloc.changeNumeroTelefono,
        ),
      );
    },
  );
}

Widget _crearEmail(RegistroBloc bloc) {
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

Widget _crearContrasena(RegistroBloc bloc) {
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

Widget _crearConfirmacionContrasena(RegistroBloc bloc) {
  return StreamBuilder(
    stream: bloc.confirmacionContrasenaStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.blueAccent),
              labelText: 'Confirmacion Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error),
          onChanged: bloc.changeConfirmacionContrasena,
        ),
      );
    },
  );
}

Widget _crearBoton(RegistroBloc bloc) {
  return StreamBuilder(
    stream: bloc.formValidadoStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrar'),
          ),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          // elevation: 1.0,
          // color: Colors.blueAccent,
          // textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _registro(context, bloc) : null);
    },
  );
}

_registro(BuildContext context, RegistroBloc bloc) {
  Navigator.pushNamed(context, 'login');
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
                'Social Market',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ))
    ],
  );
}
