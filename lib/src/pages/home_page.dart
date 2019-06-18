import 'package:that_movie_app/src/providers/movie_provider.dart';
import 'package:that_movie_app/src/widgets/card_swiper.dart';

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:that_movie_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies on Theaters'),
        centerTitle: Platform.isAndroid ? false : true,
        // backgroundColor: Colors.redAccent[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _cardSwiper(),
              SizedBox(height: 5.0),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      future: movieProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(
                value: null,
                strokeWidth: 5.0,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25.0),
            child: Text('Popular', style: Theme.of(context).textTheme.subhead),
          ),
          SizedBox(height: 15.0),
          FutureBuilder(
            future: movieProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data);
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 5.0,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
