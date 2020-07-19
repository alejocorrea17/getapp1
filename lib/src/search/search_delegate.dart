import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  final seleccion ='';
  final productos = ['Alpha', 'HP'];
  final productosRecientes = ['Guason', 'El padrino'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de que tendra el Appbar
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
        child: Text('seleccion'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que apareceran de la busqueda

    final listaSugerida = (query.isEmpty)
        ? productosRecientes
        : productos
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.local_movies),
            title: Text(listaSugerida[i]),
            onTap: () => seleccion[i],
          );
        });
  }
}
