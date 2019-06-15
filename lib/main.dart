import 'package:flutter/material.dart';

import 'package:that_movie_app/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'That Movies App',
      theme: new ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red,
          primaryColorDark: Colors.redAccent),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}
