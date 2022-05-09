import 'package:flutter/material.dart';
import 'package:moviedbapp/src/models/movie.dart';
import 'package:moviedbapp/src/providers/movies.dart';
import 'package:moviedbapp/src/widgets/listview_movies.dart';

class ScreenMovies extends StatelessWidget {
  ScreenMovies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MoviesProvider moviesProvider = MoviesProvider();
    moviesProvider.getPopularMovies();
    moviesProvider.getNowPlayingMovies();
    moviesProvider.getUpcomingMovies();
    Stream popularMovies = moviesProvider.popularMoviesStream;
    Stream nowPlayingMovies = moviesProvider.nowPlayingMoviesStream;
    //Stream upcomingMovies = moviesProvider.upcomigMoviesStream;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Movies(title: 'Popular Movies', stream: popularMovies),
          Movies(title: 'Now Playing', stream: nowPlayingMovies),
          //Movies(title: 'Upcoming', stream: upcomingMovies),
        ],
      ),
    );
  }
}

class Movies extends StatelessWidget {
  final String title;
  final Stream stream;
  Movies({Key key, this.title, this.stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container(height: ListViewMovies().height);
        return Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 32.0),
          child: Column(
            children: <Widget>[
              //TITLE
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 32.0, bottom: 16.0),
                child: Text(title, style: Theme.of(context).textTheme.headline5),
              ),
              ListViewMovies(movies: snapshot.data),
            ],
          ),
        );
      },
    );
  }
}
