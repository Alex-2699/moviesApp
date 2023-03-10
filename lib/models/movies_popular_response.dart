import 'dart:convert';

import 'package:movies/models/models.dart';

class MoviesPopularResponse {
    MoviesPopularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory MoviesPopularResponse.fromJson(String str) => MoviesPopularResponse.fromMap(json.decode(str));

    factory MoviesPopularResponse.fromMap(Map<String, dynamic> json) => MoviesPopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
