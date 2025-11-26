// To parse this JSON data, do
//
//     final tmdbResponse = tmdbResponseFromJson(jsonString);

import 'dart:convert';

import 'tmdb_movie.dart';

TmdbMoviesResponse tmdbResponseFromJson(String str) =>
    TmdbMoviesResponse.fromJson(json.decode(str));

String tmdbResponseToJson(TmdbMoviesResponse data) =>
    json.encode(data.toJson());

class TmdbMoviesResponse {
  final Dates? dates;
  final int page;
  final List<TmdbMovie> results;
  final int totalPages;
  final int totalResults;

  TmdbMoviesResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbMoviesResponse.fromJson(Map<String, dynamic> json) =>
      TmdbMoviesResponse(
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        page: json["page"],
        results: List<TmdbMovie>.from(
          json["results"].map((x) => TmdbMovie.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum":
        "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum":
        "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };
}
