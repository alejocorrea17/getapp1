import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:getapp/src/models/producto_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Producto> productos;
  CardSwiper({@required this.productos});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screeSize.width * 0.7,
          itemHeight: _screeSize.height * 0.5,
          itemCount: productos.length,
          itemBuilder: (context, i) {
            productos[i].uniqueId = '${productos[i].id}-tarjeta';
            return _tarjeta(context, productos[i]);
          }),
    );
  }

  Widget _tarjeta(BuildContext context, Producto producto) {
    final tarjeta = Hero(
      tag: producto.uniqueId,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(producto.getPosterImg()),
            fit: BoxFit.cover,
          )),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: producto);
      },
    );
  }
}
