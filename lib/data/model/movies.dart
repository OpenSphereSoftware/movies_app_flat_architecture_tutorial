import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mvp_assignment_movies/data/model/movie.dart';

class Movies {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<Movie> results;
  Movies({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  Movies copyWith({
    int? page,
    int? totalPages,
    int? totalResults,
    List<Movie>? results,
  }) {
    return Movies(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'totalPages': totalPages,
      'totalResults': totalResults,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory Movies.fromMap(Map<String, dynamic> map) {
    return Movies(
      page: map['page']?.toInt() ?? 0,
      totalPages: map['totalPages']?.toInt() ?? 0,
      totalResults: map['totalResults']?.toInt() ?? 0,
      results: List<Movie>.from(map['results']?.map((x) => Movie.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movies.fromJson(String source) => Movies.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movies(page: $page, totalPages: $totalPages, totalResults: $totalResults, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movies &&
        other.page == page &&
        other.totalPages == totalPages &&
        other.totalResults == totalResults &&
        listEquals(other.results, results);
  }

  @override
  int get hashCode {
    return page.hashCode ^
        totalPages.hashCode ^
        totalResults.hashCode ^
        results.hashCode;
  }
}
