import 'package:http/http.dart' as http;
import 'package:that_movie_app/src/models/actors_model.dart';

import 'package:that_movie_app/src/models/movie_model.dart';

import 'dart:async';
import 'dart:convert';

class MovieProvider {
  String _apiKey = '02e90984ead670df65a8c61a52e8ff6d';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStream() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await _processResponse(url);
  }

  Future<List<Movie>> getPopular() async {
    if (_loading) return [];
    _loading = true;
    _popularPage++;

    // print('loading movies...');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final res = await _processResponse(url);

    _populars.addAll(res);
    popularSink(_populars);

    _loading = false;

    return res;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/{$movieId}/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}
