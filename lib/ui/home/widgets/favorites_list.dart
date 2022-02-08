import 'package:flutter/material.dart';
import 'package:mvp_assignment_movies/data/model/movie.dart';
import 'package:mvp_assignment_movies/foundation/extensions/async_snapshot.dart';
import 'package:mvp_assignment_movies/ui/component/container_with_loading.dart';
import 'package:mvp_assignment_movies/ui/component/movie_item.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    Key? key,
    required this.favoritesStream,
    required this.favorites,
  }) : super(key: key);

  final AsyncSnapshot<Map<String, Object?>> favoritesStream;
  final AsyncSnapshot<List<Movie>> favorites;

  @override
  Widget build(BuildContext context) {
    return ContainerWithLoading(
        isLoading: favoritesStream.isWaiting,
        child: favorites.data != null && favorites.data!.isNotEmpty
            ? ListView.builder(
                itemCount: favorites.data?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return MovieItem(movie: favorites.data![index]);
                },
              )
            : const Center(
                child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text("No favorites."),
              )));
  }
}
