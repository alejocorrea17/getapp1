import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getapp/src/controller/controller.dart';
import 'package:getapp/src/models/news_models.dart';
import 'package:getapp/src/models/product_model.dart';
import 'package:getapp/src/pages/carrito_page.dart';
import 'package:getapp/src/pages/tab1_page.dart';
import 'package:getapp/src/pages/tab2_page.dart';
import 'package:getapp/src/services/news_service.dart';
import 'package:getapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            label: 'Para ti',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.public,
                color: Colors.black,
              ),
              label: 'Recomendados'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              label: 'Carrito'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            label: 'Favoritos',
          ),
        ]);
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      //Con cada accion que ejecute el pageController cambiara la vista de la pagina.
      controller: navegacionModel._pageController,
      //Esto cambia como se muestra el borde la pantalla
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
        Carrito(controller: controller),
        Favoritos(controller: controller)
      ],
    );
  }
}

class Favoritos extends StatefulWidget {
  const Favoritos({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final Controller controller;

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  @override
  Widget build(BuildContext context) {
    List<Article> listaDeFavoritos = [];
    final controller = Get.put(Controller());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<Controller>(
          id: 'favoritos',
          builder: (_) {
            return FutureBuilder(
                future: widget.controller.traerFavoritos(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData || snapshot.data != null) {
                    listaDeFavoritos = [];
                    for (var item in snapshot.data) {
                      listaDeFavoritos.add(Article.fromJson(item));
                    }
                    controller.articulosFavoritos = listaDeFavoritos;
                    Map<String, Article> mp = {};
                    for (var item in listaDeFavoritos) {
                      mp[item.title] = item;
                    }
                    List<Article> listaDeFavoritosFiltrada = mp.values.toList();
                    return ListaNoticias(
                      listaDeFavoritosFiltrada,
                      favoritos: true,
                    );
                  } else {
                    return Container();
                  }
                });
          },
        ),
      ),
    );
  }
}

// List<Map<String, dynamic>> subjects = [
//   {'subjectName': 'Ingles', 'teacherName': 'Profesor 1'},
//   {'subjectName': 'Matematicas', 'teacherName': 'Profesor 2'},
//   {'subjectName': 'Ingles', 'teacherName': 'Profesor 1'},
// ];

// final Map<String, dynamic> mapFilter = {};

// for (Map<String, dynamic> myMap in subjects) {
//   mapFilter[myMap['subjectName']] = myMap;
// }

// final List<Map<String, dynamic>> listFilter =
//     mapFilter.keys.map((key) => mapFilter[key] as Map<String,dynamic>).toList();

// print(listFilter);

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
