import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import '../models/trailer_model.dart';
import '../models/item_model.dart';
import 'package:inject/inject.dart';
import '../models/state.dart';

class MovieApiProvider {
  final Client client;
  final _apiKey = "af9ae3997d25e9a6fa2ca1a11f73fc0e";
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  @provide
  MovieApiProvider(this.client);

  Future<State> fetchMovieList() async {
    Response response;

    // if (_apiKey != 'api-key') {
    //   return State<String>.error('Please add your API key'));
    //}

    response = await client.get("$_baseUrl/popular?api_key=$_apiKey");

    print(response.body.toString());

    if (response.statusCode == 200) {
      return State<ItemModel>.success(
          ItemModel.fromJson(json.decode(response.body)));
    }

    return State<String>.error(response.statusCode.toString());
  }

  Future<State> fetchTrailer(int movieId) async {
    //Response response;

    final response =
        await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return State<TrailerModel>.success(
          TrailerModel.fromJson(json.decode(response.body)));
    }
    return State<String>.error(response.statusCode.toString());
  }
}
