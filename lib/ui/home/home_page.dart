import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_assignment_movies/data/local/local_storage.dart';
import 'package:mvp_assignment_movies/data/model/movie.dart';
import 'package:mvp_assignment_movies/ui/home/home_view_model.dart';
import 'package:mvp_assignment_movies/ui/home/widgets/favorites_list.dart';
import 'package:mvp_assignment_movies/ui/home/widgets/search_list.dart';
import 'package:mvp_assignment_movies/ui/network_detector_notifier.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkAware = ref.read(networkAwareProvider);
    final homeViewModel = ref.read(homeViewModelProvider);

    /// Movie Search
    final movies =
        ref.watch(homeViewModelProvider.select((value) => value.movies));
    final isLoading =
        ref.watch(homeViewModelProvider.select((value) => value.isLoading));

    // Favorites
    final sharedPrefs = ref.read(rxSharedPreferencesProvider);
    final favoritesStream =
        useStream(useMemoized(() => sharedPrefs.observeAll()));
    final favorites = useFuture(useMemoized(
        () => sharedPrefs.readAll().then((value) => value.values
            .map((e) => Movie.fromJson(jsonDecode(e as String)))
            .toList()),
        [favoritesStream.data.toString()]));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(32),
              TextField(
                onChanged: (value) => homeViewModel.setQuery(value),
              ),
              (movies == null)
                  ? FavoritesList(
                      favoritesStream: favoritesStream, favorites: favorites)
                  : SearchList(isLoading: isLoading, movies: movies),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
