import 'package:that_movie_app/src/providers/movie_provider.dart';
import 'package:that_movie_app/src/widgets/card_swiper.dart';

import 'dart:io' show Platform;
import 'package:flutter/material.dart';

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
            children: <Widget>[
              _cardSwiper(),
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
}
