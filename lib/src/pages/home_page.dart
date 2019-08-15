import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:that_movie_app/src/providers/movie_provider.dart';
import 'package:that_movie_app/src/search/search_delegate.dart';
import 'package:that_movie_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    movieProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'That Movie', 
          style: TextStyle(
            // fontWeight: FontWeight.bold, 
            fontSize: 22.0
          )
        ),
        centerTitle: Platform.isAndroid ? false : true,
        // backgroundColor: Colors.redAccent[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSeach(),
                // query: 'Type a movie...',
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Movies on Theaters',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 20.0
                  )
                )
              ),
              _onTheaters(),
              Container(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Popular Movies', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 20.0
                  )
                )
              ),
              _footer(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pan_tool),
        onPressed: () => Navigator.of(context).pushNamed('snap'),
      ),
    );
  }

  Widget _onTheaters() {
    return FutureBuilder(
      future: movieProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return MovieHorizontal(movies: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
                child: Platform.isAndroid
                    ? CircularProgressIndicator()
                    : CupertinoActivityIndicator()
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return StreamBuilder(
      stream: movieProvider.popularStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MovieHorizontal(
            movies: snapshot.data,
            nextPage: movieProvider.getPopular,
          );
        } else {
          return Container(
            child: Center(
              child: Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}
