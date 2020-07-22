import 'package:bloc_project/src/blocs/bloc_base.dart';
import 'package:inject/inject.dart';

import '../models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class MoviesBloc extends BlocBase {
  final Repository _repository;
  PublishSubject<ItemModel> _moviesFetcher;

  @provide
  MoviesBloc(this._repository);

  init() {
    _moviesFetcher = PublishSubject<ItemModel>();
  }

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  @override
  dispose() {
    _moviesFetcher.close();
  }
}

final blocMovies = MoviesBloc();
