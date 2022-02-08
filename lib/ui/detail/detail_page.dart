import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_assignment_movies/data/local/local_storage.dart';
import 'package:mvp_assignment_movies/data/model/movie.dart';
import 'package:mvp_assignment_movies/ui/component/movie_info.dart';
import 'package:mvp_assignment_movies/ui/detail/detail_view_model.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<Movie?>(
        stream: ref.read(rxSharedPreferencesProvider).observe(
            movie.id.toString(),
            (p0) =>
                p0 != null ? Movie.fromJson(jsonDecode(p0 as String)) : null),
        builder: (context, snapshot) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 64, 16, 0),
              child: Column(
                children: [
                  MovieInfo(movie: movie),
                  TextButton.icon(
                    onPressed: () => ref
                        .read(detailViewModel)
                        .toggleMovieToFavorites(
                            movie,
                            snapshot.data != null
                                ? FavoritesAction.remove
                                : FavoritesAction.add),
                    icon: Icon(snapshot.data != null
                        ? Icons.star
                        : Icons.star_outline),
                    label: const Text("Favorite"),
                  ),
                  const Gap(16),
                  TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      label: const Text("Back"),
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
          );
        });
  }
}
