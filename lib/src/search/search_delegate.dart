import 'package:flutter/material.dart';

class DataSeach extends SearchDelegate {
  String selected = '';

  final movies = [
    'Spider-Man: Homecoming',
    'Aquaman',
    'Shazam!',
    'Iron Man',
    'Captain America: The Winter Soldier',
    'Spider-Man: Far from Home',
    'Avengers: Endgame',
    'Avengers: Infinity War',
  ];

  final recentMovies = [
    'Spider-Man: Far from Home',
    'Avengers: Endgame',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.redAccent,
        child: Text(selected),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listSuggested = (query.isEmpty)
        ? recentMovies
        : movies
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listSuggested.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listSuggested[i]),
          onTap: () {
            selected = listSuggested[i];
            showResults(context);
          },
        );
      },
    );
  }
}
