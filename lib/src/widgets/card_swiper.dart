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
      padding: EdgeInsets.only(top: 5.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = '${movies[index].id}-card';

          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detail',
                    arguments: movies[index]),
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImage()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
