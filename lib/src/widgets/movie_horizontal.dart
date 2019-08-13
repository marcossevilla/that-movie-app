import 'package:flutter/material.dart';

import 'package:that_movie_app/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({@required this.movies, this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.4,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.35,
      width: double.infinity,
      child: PageView.builder(
        // children: _cards(context),
        pageSnapping: true,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) => _card(context, movies[i], _screenSize),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie, Size size) {
    movie.uniqueId = '${movie.id}-popular';

    final card = Container(
      width: size.width * 0.8,
      margin: EdgeInsets.only(right: 25.0),
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(movie.getPosterImage()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fit: BoxFit.cover,
            height: size.height * 0.3,
            width: size.width * 0.7,
          ),
          SizedBox(height: 10.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

  // Cards was a waste of resources, RIP.

  // List<Widget> _cards(BuildContext context) {
  //   return movies.map((movie) {
  //     return Container(
  //       margin: EdgeInsets.only(right: 25.0),
  //       child: Column(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(15.0),
  //             child: FadeInImage(
  //               image: NetworkImage(movie.getPosterImage()),
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               fit: BoxFit.cover,
  //               height: 150.0,
  //             ),
  //           ),
  //           SizedBox(height: 10.0),
  //           Text(
  //             movie.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
