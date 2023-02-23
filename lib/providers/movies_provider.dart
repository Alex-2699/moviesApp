import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _apiKey = 'e93422fe2abf7ae39c620e4a67718ee8';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    //print('Inicialización del provider');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, {int page = 1}) async {
    var url = Uri.https(_baseUrl, endPoint,{
      'api_key': _apiKey, 
      'language': _language, 
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final String jsonData = await _getJsonData('3/movie/now_playing');
    final moviesNowPlaying = MoviesNowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = moviesNowPlaying.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage ++;

    final String jsonData = await _getJsonData('3/movie/popular', page: _popularPage);
    final popularResponse = MoviesPopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

}