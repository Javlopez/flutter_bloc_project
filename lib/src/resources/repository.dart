import 'dart:async';
import 'movie_api_provider.dart';
import 'package:inject/inject.dart';
import '../models/state.dart';

class Repository {
  final MovieApiProvider moviesApiProvider;

  @provide
  Repository(this.moviesApiProvider);

  Future<State> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<State> fetchTrailers(int movieId) =>
      moviesApiProvider.fetchTrailer(movieId);
}
