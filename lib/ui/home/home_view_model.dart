import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_assignment_movies/data/model/movies.dart';
import 'package:mvp_assignment_movies/data/model/result.dart';
import 'package:mvp_assignment_movies/data/repository/movies_repository.dart';
import 'package:mvp_assignment_movies/data/repository/movies_repository_impl.dart';
import 'package:mvp_assignment_movies/foundation/debounce.dart';

final homeViewModelProvider =
    ChangeNotifierProvider((ref) => HomeViewModel(ref.read));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._reader);

  final Reader _reader;

  late final MoviesRepository _repository = _reader(moviesRepositoryProvider);

  final Debounce _debounce = Debounce(const Duration(milliseconds: 400));

  Result<Movies>? _movies;

  Result<Movies>? get movies => _movies;

  String? _query;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setQuery(String newQuery) {
    _debounce(() {
      if (newQuery.isNotEmpty) {
        if (newQuery != _query) {
          _query = newQuery;
          fetchMovies(_query!);
        }
      } else {
        _movies = null;
        notifyListeners();
      }
    });
  }

  Future<void> fetchMovies(String query) {
    setToLoading();
    return _repository
        .getMovies(query)
        .then((value) => _movies = value)
        .whenComplete(() => setToLoading(reverse: true));
  }

  void setToLoading({bool reverse = false}) {
    _isLoading = reverse ? false : true;
    notifyListeners();
  }
}
