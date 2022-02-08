import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_assignment_movies/data/model/movies.dart';
import 'package:mvp_assignment_movies/data/model/result.dart';
import 'package:mvp_assignment_movies/data/remote/movies_data_source.dart';
import 'package:mvp_assignment_movies/data/repository/movies_repository.dart';
import 'package:mvp_assignment_movies/foundation/constants.dart';

final moviesRepositoryProvider =
    Provider((ref) => MoviesRepositoryImpl(ref.read));

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl(this._reader);

  final Reader _reader;

  late final MoviesDataSource _dataSource = _reader(moviesDataSourceProvider);

  @override
  Future<Result<Movies>> getMovies(String query) {
    return Result.guardFuture(
      () async => await _dataSource.getMovies(
        query: query,
        apiKey: Constants.instance.apiKey,
      ),
    );
  }
}
