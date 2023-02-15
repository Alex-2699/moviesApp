import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _apiKey = 'e93422fe2abf7ae39c620e4a67718ee8';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  MoviesProvider() {
    //print('Inicialización del provider');
    notifyChange();
  }

  notifyChange() async {
    var url = Uri.https(this._baseUrl, '3/movie/now_playing', {
        'api_key' : _apiKey,
        'language' : _language,
        'page' : '1'
      });

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);
  final moviesNowPlaying = MoviesNowPlayingResponse.fromJson(response.body);
  print(moviesNowPlaying.results[0].title);
  }
}