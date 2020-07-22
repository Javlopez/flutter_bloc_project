import 'package:bloc_project/src/models/trailer_model.dart';

import '../models/item_model.dart';
import 'movie_api_provider.dart';
import 'package:inject/inject.dart';

class Repository {
  final MovieApiProvider moviesApiProvider;

  @provide
  Repository(this.moviesApiProvider);

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) =>
      moviesApiProvider.fetchTrailer(movieId);
}
