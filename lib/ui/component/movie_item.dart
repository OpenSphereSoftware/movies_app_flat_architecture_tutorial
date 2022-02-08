import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mvp_assignment_movies/data/model/movie.dart';
import 'package:mvp_assignment_movies/ui/component/movie_info.dart';
import 'package:mvp_assignment_movies/ui/detail/detail_page.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: OpenContainer(
        closedColor: Colors.transparent,
        openColor: Colors.transparent,
        onClosed: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        closedBuilder: (context, action) => MovieInfo(movie: movie),
        openBuilder: (context, action) => DetailPage(movie: movie),
      ),
    );
  }
}
