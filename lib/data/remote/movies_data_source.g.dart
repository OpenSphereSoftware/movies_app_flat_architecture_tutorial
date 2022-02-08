// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MoviesDataSource implements MoviesDataSource {
  _MoviesDataSource(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Movies> getMovies(
      {required query, language = 'en-US', required apiKey}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'language': language,
      r'api_key': apiKey
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Movies>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/search/movie',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Movies.fromMap(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
