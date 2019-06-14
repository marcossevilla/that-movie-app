import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:that_movie_app/src/models/movie_model.dart';

class MovieProvider {
  String _apiKey = '02e90984ead670df65a8c61a52e8ff6d';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}
