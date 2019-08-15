import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:that_movie_app/src/models/actors_model.dart';
import 'package:that_movie_app/src/models/movie_model.dart';
import 'package:that_movie_app/src/providers/actor_provider.dart';
import 'package:that_movie_app/src/providers/movie_provider.dart';

class MovieDetail extends StatefulWidget {

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  ActorProvider actorProvider;

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
      backgroundColor: Colors.cyan,
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
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _postTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              image: NetworkImage(movie.getPosterImage()),
              height: 150.0,
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
          return _createCastPageView(context, snapshot.data);
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

  Widget _createCastPageView(BuildContext context, List<Actor> actors) {
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
            itemBuilder: (context, i) => _actorCard(context, actors[i]),
          ),
        ),
      ],
    );
  }

  Widget _actorCard(BuildContext context, Actor actor) {
    return GestureDetector(
      child: Container(
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
      ),
      onTap: () => Navigator.pushNamed(context, 'actor', arguments: actor),
    );

  }
}
