import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/helpers/debouncer.dart';
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _apiKey = '41837e2043d5240ff452f169c777f77d';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> moviesByPeople = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  MoviesProvider() {
    // Inicialización del provider
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, {int page = 1}) async {
    final url = Uri.https(_baseUrl, endPoint,{
      'api_key': _apiKey, 
      'language': _language, 
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  // Movies
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

  Future<List<Movie>> getMoviesByPeople(String peopleIds) async {
    final url = Uri.https(_baseUrl, '3/discover/movie',{
      'api_key': _apiKey, 
      'language': _language, 
      'with_people': peopleIds,
      'sort_by': 'popularity.desc'
    });

    final response = await http.get(url);
    final result = MoviesPopularResponse.fromJson(response.body);
    return moviesByPeople = result.results;
  }

  // Cast And Persons
  Future<List<Cast>> getMovieCast(int movieId) async {

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  // Search
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',{
      'api_key': _apiKey, 
      'language': _language, 
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponseDto.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){
    debouncer.value = '';
    debouncer.onValue = (value) async{
      final results = await searchMovies(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

}