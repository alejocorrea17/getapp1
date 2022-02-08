import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getapp/src/pages/login_page.dart';
import 'package:getapp/src/pages/registro_page.dart';
import 'package:getapp/src/search/search_delegate.dart';
//Importaciones propias
import 'package:getapp/src/widgets/card_swiper_widget.dart';
import 'package:getapp/src/widgets/productos_horizontal.dart';
import 'package:getapp/src/providers/productos_provider.dart';

class LandingPage extends StatelessWidget {
  final ProductosProvider productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    productosProvider.getPopulares();

    return Scaffold(
      bottomNavigationBar: _navegacion(),
      appBar: AppBar(
        centerTitle: false,
        title: Text('Social Market'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                // showSearch(context: context, delegate: DataSearch(), query: 'Hola'),
                showSearch(context: context, delegate: DataSearch()),
          )
        ],
      ),
      body: _tabs(context, productosProvider),
    );
  }
}

Widget _home(BuildContext context, ProductosProvider productosProvider) {
  return Container(
    child: Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // _encabezado(context),
            SizedBox(
              height: 10,
            ),
            _swiperTarjetas(productosProvider),
            SizedBox(
              height: 10,
            ),
            _footer(context, productosProvider),
            // _botones(context)
          ],
        ),
      ),
    ),
  );
}

int paginaActual = 0;
PageController pageController = PageController();

Widget _tabs(BuildContext context, ProductosProvider productosProvider) {
  return PageView(
    //Con cada accion que ejecute el pageController cambiara la vista de la pagina.
    controller: pageController,
    //Esto cambia como se muestra el borde la pantalla
    // physics: BouncingScrollPhysics(),
    physics: NeverScrollableScrollPhysics(),
    children: <Widget>[
      _home(context, productosProvider),
      Registrarse(),
      InicioSesion(),
    ],
  );
}

Widget _navegacion() {
  return BottomNavigationBar(
      currentIndex: paginaActual,
      onTap: (i) {
        print('paginaActual: ' + paginaActual.toString());
        paginaActual = i;
        pageController.jumpToPage(i);
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black87,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            label: 'Registrarse'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.login,
              color: Colors.black,
            ),
            label: 'Iniciar sesion'),
      ]);
}

Widget _swiperTarjetas(ProductosProvider productosProvider) {
  return FutureBuilder(
    future: productosProvider.getNuevos(),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return CardSwiper(productos: snapshot.data);
      } else {
        return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      }
    },
  );
}

Widget _footer(BuildContext context, ProductosProvider productosProvider) {
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('Productos Populares',
              style: Theme.of(context).textTheme.subtitle1),
        ),
        SizedBox(height: 5.0),
        StreamBuilder(
          stream: productosProvider.popularesStream,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ProductosHorizontal(
                productos: snapshot.data,
                siguientePagina: productosProvider.getPopulares,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    ),
  );
}
