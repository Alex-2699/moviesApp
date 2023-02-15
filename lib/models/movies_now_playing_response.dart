import 'dart:convert';

import 'package:movies/models/models.dart';

class MoviesNowPlayingResponse {
    MoviesNowPlayingResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    Dates dates;
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory MoviesNowPlayingResponse.fromJson(String str) => MoviesNowPlayingResponse.fromMap(json.decode(str));

    factory MoviesNowPlayingResponse.fromMap(Map<String, dynamic> json) => MoviesNowPlayingResponse(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}

class Dates {
    Dates({
        required this.maximum,
        required this.minimum,
    });

    DateTime maximum;
    DateTime minimum;

    factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );
}

