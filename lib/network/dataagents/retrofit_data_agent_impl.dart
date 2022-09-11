import 'package:dio/dio.dart';
import 'package:movieapp/data/vos/actor_vo.dart';
import 'package:movieapp/data/vos/credit_vo.dart';
import 'package:movieapp/data/vos/genre_vo.dart';
import 'package:movieapp/data/vos/movie_vo.dart';
import 'package:movieapp/network/api_constants.dart';
import 'package:movieapp/network/the_movie_api.dart';

import 'movie_data_agent.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  TheMovieApi? mApi;
  static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl._internal();

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mApi
        ?.getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<ActorVO>>? getActors(int page) {
    return mApi?.getActors(API_KEY, LANGUAGE_EN_US, page).asStream().map((response) => response.results).first;
  }

  @override
  Future<List<MovieVO>>? getMoviesByGenre(int genreId) {
    return mApi
        ?.getMoviesByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>>? getPopularMovies(int page) {
    return mApi
        ?.getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>>? getTopRatedMovies(int page) {
    return mApi
        ?.getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>>? getGenres() {
    return mApi?.getGenres(API_KEY, LANGUAGE_EN_US).asStream().map((response) => response.genres).first;
  }

  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mApi
        ?.getCreditByMovieResponse(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1)
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mApi?.getMovieDetails(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1);
  }
}
