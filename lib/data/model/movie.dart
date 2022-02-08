// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Movie {
  final String title;
  final double vote_average;
  final String poster_path;
  final String overview;
  final int id;
  Movie({
    required this.title,
    required this.vote_average,
    required this.poster_path,
    required this.overview,
    required this.id,
  });

  Movie copyWith({
    String? title,
    double? vote_average,
    String? poster_path,
    String? overview,
    int? id,
  }) {
    return Movie(
      title: title ?? this.title,
      vote_average: vote_average ?? this.vote_average,
      poster_path: poster_path ?? this.poster_path,
      overview: overview ?? this.overview,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'vote_average': vote_average,
      'poster_path': poster_path,
      'overview': overview,
      'id': id,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      vote_average: map['vote_average']?.toDouble() ?? 0.0,
      poster_path: map['poster_path'] ?? '',
      overview: map['overview'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(title: $title, vote_average: $vote_average, poster_path: $poster_path, overview: $overview, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.vote_average == vote_average &&
        other.poster_path == poster_path &&
        other.overview == overview &&
        other.id == id;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        vote_average.hashCode ^
        poster_path.hashCode ^
        overview.hashCode ^
        id.hashCode;
  }
}
