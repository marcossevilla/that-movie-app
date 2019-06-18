import 'package:that_movie_app/src/models/movie_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 25.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.63,
        itemHeight: _screenSize.height * 0.45,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              image: NetworkImage(movies[index].getPosterImage()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.fill,
            ),
          );
        },
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
