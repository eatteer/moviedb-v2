import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviedbapp/src/models/movie.dart';

class MoviesProvider {
  //SINGLETON
  static final MoviesProvider _singleton = MoviesProvider._internal();
  factory MoviesProvider() {
    return _singleton;
  }
  MoviesProvider._internal();

  String _url = 'api.themoviedb.org';
  String _apiKey = '27bfcbd1174e4ca3999637f6e1233e98';
  String _languague = 'en-US';

  StreamController _popularMoviesStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get popularMoviesSink => _popularMoviesStreamController.sink.add;
  Stream<List<Movie>> get popularMoviesStream => _popularMoviesStreamController.stream;

  StreamController _upcomingMoviesStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get upcomingMoviesSink => _upcomingMoviesStreamController.sink.add;
  Stream<List<Movie>> get upcomigMoviesStream => _upcomingMoviesStreamController.stream;

  StreamController _nowPlayingMoviesStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get nowPlayingMoviesSink => _nowPlayingMoviesStreamController.sink.add;
  Stream<List<Movie>> get nowPlayingMoviesStream => _nowPlayingMoviesStreamController.stream;

  void dispose() {
    _popularMoviesStreamController?.close();
    _upcomingMoviesStreamController?.close();
    _nowPlayingMoviesStreamController?.close();
  }

  void getPopularMovies() async {
    Uri url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _languague,
      'page': '1',
    });
    http.Response res = await http.get(url);
    Map decoded = json.decode(res.body);
    Movies movies = Movies.toListMovies(decoded['results']);
    popularMoviesSink(movies.movies);
  }

  void getUpcomingMovies() async {
    Uri url = Uri.https(_url, '/3/movie/upcoming', {
      'api_key': _apiKey,
      'language': _languague,
      'page': '1',
    });
    http.Response res = await http.get(url);
    Map decoded = json.decode(res.body);
    Movies movies = Movies.toListMovies(decoded['results']);
    upcomingMoviesSink(movies.movies);
  }

  void getNowPlayingMovies() async {
    Uri url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _languague,
      'page': '1',
    });
    http.Response res = await http.get(url);
    Map decoded = json.decode(res.body);
    Movies movies = Movies.toListMovies(decoded['results']);
    nowPlayingMoviesSink(movies.movies);
  }
}
