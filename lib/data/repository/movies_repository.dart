import 'package:mvp_assignment_movies/data/model/movies.dart';
import 'package:mvp_assignment_movies/data/model/result.dart';

abstract class MoviesRepository {
  Future<Result<Movies>> getMovies(String query);
}
