import 'dart:convert';

import '../models/trailer_model.dart';
import 'package:http/http.dart' show Client, Response;
import '../models/item_model.dart';
import 'package:inject/inject.dart';

class MovieApiProvider {
  final Client client;
  final _apiKey = "af9ae3997d25e9a6fa2ca1a11f73fc0e";
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  @provide
  MovieApiProvider(this.client);

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");

    print(response.body.toString());

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    }
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
        await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load trailers');
  }
}
