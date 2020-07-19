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
        itemBuilder: (BuildContext context, int index) {
          return new ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(productos[index].getPosterImg()),
                  fit: BoxFit.cover,
                  )
                  );
        },

        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
