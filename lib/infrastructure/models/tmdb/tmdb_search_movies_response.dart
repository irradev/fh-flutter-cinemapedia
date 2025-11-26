// To parse this JSON data, do
//
//     final searchMovieResponse = searchMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'tmdb_movie.dart';

TmdbSearchMovieResponse searchMovieResponseFromJson(String str) =>
    TmdbSearchMovieResponse.fromJson(json.decode(str));

String searchMovieResponseToJson(TmdbSearchMovieResponse data) =>
    json.encode(data.toJson());

class TmdbSearchMovieResponse {
  final int page;
  final List<TmdbMovie> results;
  final int totalPages;
  final int totalResults;

  TmdbSearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbSearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      TmdbSearchMovieResponse(
        page: json["page"],
        results: List<TmdbMovie>.from(
          json["results"].map((x) => TmdbMovie.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}
