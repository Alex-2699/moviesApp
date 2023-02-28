import 'dart:convert';

import 'package:movies/models/models.dart';

class SearchResponseDto {
    SearchResponseDto({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchResponseDto.fromJson(String str) => SearchResponseDto.fromMap(json.decode(str));

    factory SearchResponseDto.fromMap(Map<String, dynamic> json) => SearchResponseDto(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}