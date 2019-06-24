import 'package:that_movie_app/src/models/actors_model.dart';
import 'package:that_movie_app/src/models/movie_model.dart';
import 'package:that_movie_app/src/providers/movie_provider.dart';

import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _postTitle(context, movie),
              _overview(movie),
              _createCast(movie),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.redAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        background: FadeInImage(
            image: NetworkImage(movie.getBackgroundImage()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fadeInDuration: Duration(microseconds: 100),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _postTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: NetworkImage(movie.getPosterImage()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 30.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    SizedBox(width: 5.0),
                    Text(
                      movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _overview(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _createCast(Movie movie) {
    final movieProvider = new MovieProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createCastPageView(snapshot.data);
        } else {
          return Center(
            child: Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  Widget _createCastPageView(List<Actor> actors) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200.0,
          child: PageView.builder(
            pageSnapping: false,
            controller: PageController(
              initialPage: 1,
              viewportFraction: 0.3,
            ),
            itemCount: actors.length,
            itemBuilder: (context, i) => _actorCard(actors[i]),
          ),
        ),
      ],
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPicture()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 140.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            actor.character,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
