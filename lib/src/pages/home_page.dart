import 'package:that_movie_app/src/widgets/card_swiper.dart';

import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies on Theaters'),
        centerTitle: Platform.isAndroid ? false : true,
        backgroundColor: Colors.redAccent[700],
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
    return CardSwiper(movies: [1, 2, 3, 4, 5]);
  }
}
