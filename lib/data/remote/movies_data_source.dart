import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_assignment_movies/data/model/movies.dart';
import 'package:mvp_assignment_movies/data/remote/app_dio.dart';
import 'package:retrofit/retrofit.dart';

part 'movies_data_source.g.dart';

final moviesDataSourceProvider = Provider((ref) => MoviesDataSource(ref.read));

@RestApi()
abstract class MoviesDataSource {
  factory MoviesDataSource(Reader reader) =>
      _MoviesDataSource(reader(dioProvider));

  @GET('/3/search/movie')
  Future<Movies> getMovies({
    @Query("query") required String query,
    @Query("language") String? language = 'en-US',
    @Query("api_key") required String apiKey,
  });
}
