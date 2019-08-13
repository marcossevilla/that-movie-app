import 'package:flutter/material.dart';

import 'package:that_movie_app/src/pages/home_page.dart';
import 'package:that_movie_app/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'That Movies App',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan,
        primaryColorDark: Colors.cyanAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail(),
      },
    );
  }
}
