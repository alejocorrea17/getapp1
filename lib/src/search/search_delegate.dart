import 'package:flutter/material.dart';
import 'package:getapp/src/models/producto_model.dart';
//Importaciones propias
import 'package:getapp/src/providers/productos_provider.dart';

class DataSearch extends SearchDelegate {
  final productosProvider = new ProductosProvider();
  String seleccion = '';
  final productos = [
    'Alpha',
    'HP',
    'Guason',
    'El padrino',
    'Alpha 2',
    'HP 2',
    'Guason 2',
    'El padrino 2'
  ];
  final productosRecientes = ['Guason', 'El padrino', 'Aquaman', 'Vengador'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones que tendrá el Appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que se van a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que apareceran de la busqueda
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: productosProvider.buscarProductos(query),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView(
              children: productos.map((producto) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(producto.getPosterImg()),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(producto.title),
              subtitle: Text(producto.originalTitle),
              onTap: () {
                close(context, null);
                producto.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: producto);
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //Metodo de ejemplo para mostrar sugerencias con lista local
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   //Sugerencias que apareceran de la busqueda

  //   final listaSugerida = (query.isEmpty)
  //       ? productosRecientes
  //       : productos
  //           .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //       itemCount: listaSugerida.length,
  //       itemBuilder: (context, i) {
  //         return ListTile(
  //             leading: Icon(Icons.local_movies),
  //             title: Text(listaSugerida[i]),
  //             onTap: () {
  //               seleccion = listaSugerida[i];
  //               showResults(context);
  //             });
  //       });
  // }

}
