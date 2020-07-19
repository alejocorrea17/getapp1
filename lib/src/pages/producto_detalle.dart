import 'package:flutter/material.dart';
import 'package:getapp/src/models/producto_model.dart';

class ProductoDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Producto producto = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(producto),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(context, producto),
            _descripcion(producto),

          ]
          )
        )
        ],
      ),
    );
  }

  Widget _crearAppBar(Producto producto) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueAccent,
      expandedHeight: 450.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            producto.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(producto.getBackgroundImg()),
            fadeInDuration: Duration(microseconds: 150),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _posterTitulo(BuildContext context, Producto producto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(producto.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                producto.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                producto.originalTitle,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star),
                  Text(
                    producto.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Producto producto){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(producto.overview, textAlign: TextAlign.justify,),
    );
  }
}
