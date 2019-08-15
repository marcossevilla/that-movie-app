import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:that_movie_app/src/models/actors_model.dart';

class ActorProvider {
  
  String _apiKey = '02e90984ead670df65a8c61a52e8ff6d';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Actor actor;

  Future<Actor> getActorInfo(String actorId) async {

    // * the url
    // * https://api.themoviedb.org/3/person/1515478?api_key=02e90984ead670df65a8c61a52e8ff6d&language=en-US
    
    final url = Uri.https(_url, '3/person/$actorId', {
      'api_key': _apiKey,
      'language': _language,
    });

    final res = await http.get(url);

    final decodedData = json.decode(res.body);

    final actorObj = new Actor.fromJsonMap(decodedData);

    return actorObj;

  }
}