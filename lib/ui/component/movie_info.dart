import 'package:flutter/material.dart';
import 'package:mvp_assignment_movies/data/model/movie.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
              "https://image.tmdb.org/t/p/w300/${movie.poster_path}",
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(movie.title),
        ),
        if (movie.overview.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(movie.overview),
          ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text("${movie.vote_average.toString()}/10.0"),
        ),
      ],
    );
  }
}
