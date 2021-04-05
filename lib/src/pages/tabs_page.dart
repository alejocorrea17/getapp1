import 'package:flutter/material.dart';
import 'package:getapp/src/models/product_model.dart';
import 'package:getapp/src/pages/tab1_page.dart';
import 'package:getapp/src/pages/tab2_page.dart';
import 'package:getapp/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => new _NavegacionModel()),
          ChangeNotifierProvider(create: (_) => new NewsService()),
          ChangeNotifierProvider(create: (_) => new ProductoModelo())
        ],
        child: Scaffold(
          body: _Paginas(),
          bottomNavigationBar: _Navegacion(),
        ));
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacioModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: navegacioModel.paginaActual,
        onTap: (i) => navegacioModel.paginaActual = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: ('Para ti')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: ('Recomendados')),
          // ,title: Text('Recomendados')
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.shopping_cart), title: Text('Carrito')),
        ]);
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      //Con cada accion que ejecute el pageController nos cambiara la vista de la pagina.
      controller: navegacionModel._pageController,
      //Esto cambia como se muestra el borde la pantalla
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
        Container(
          color: Colors.black87,
        )
      ],
    );
  }
}

//Esta clase va implementar el provider para que otros Widgets puedan hacer uso de la pagina actual
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;
  set paginaActual(int valor) {
    this._paginaActual = valor;

    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOutSine);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
