import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_assignment_movies/data/local/local_storage.dart';
import 'package:mvp_assignment_movies/data/model/movie.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

final detailViewModel =
    ChangeNotifierProvider((ref) => DetailViewModel(ref.read));

class DetailViewModel extends ChangeNotifier {
  DetailViewModel(this._reader);

  final Reader _reader;

  late final RxSharedPreferences _rxSharedPreferences =
      _reader(rxSharedPreferencesProvider);

  void toggleMovieToFavorites(Movie movie, FavoritesAction action) {
    if (action == FavoritesAction.add) {
      _rxSharedPreferences.write<Movie>(
          movie.id.toString(), movie, (p0) => jsonEncode(p0));
    } else {
      _rxSharedPreferences.remove(movie.id.toString());
    }
  }
}

enum FavoritesAction { add, remove }
