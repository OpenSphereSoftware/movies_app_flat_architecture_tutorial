import 'package:flutter/material.dart';
import 'package:mvp_assignment_movies/data/model/movies.dart';
import 'package:mvp_assignment_movies/data/model/result.dart';
import 'package:mvp_assignment_movies/ui/component/container_with_loading.dart';
import 'package:mvp_assignment_movies/ui/component/movie_item.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    Key? key,
    required this.isLoading,
    required this.movies,
  }) : super(key: key);

  final bool isLoading;
  final Result<Movies>? movies;

  @override
  Widget build(BuildContext context) {
    return ContainerWithLoading(
        isLoading: isLoading,
        child: movies!.when(success: (data) {
          if (data.results.isEmpty) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text("No results."),
            ));
          }
          return ListView.builder(
            itemCount: data.results.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return MovieItem(movie: data.results[index]);
            },
          );
        }, failure: (e) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text("Fetch failed."),
          ));
        }));
  }
}
