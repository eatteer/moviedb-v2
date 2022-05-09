import 'package:flutter/material.dart';
import 'package:moviedbapp/src/models/movie.dart';
import 'package:moviedbapp/src/providers/genres.dart';

class MovieDetail extends StatelessWidget {
  MovieDetail({Key key}) : super(key: key);
  final Genres genres = Genres();
  @override
  Widget build(BuildContext context) {
    //Movie come from screen Home
    Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: genres.getGenres(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Container();
            List genres = snapshot.data;
            List movieGenres = genreMatching(movie.genreIds, genres);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Poster(movie: movie),
                  Header(movie: movie, movieGenres: movieGenres),
                  Overview(movie: movie),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

List genreMatching(List genresId, List genres) {
  /* This function evaluates if the genre of the movie matches any genre in the API genre list.
  When the genres matches, the genre name of the API is added to list genreMovies */
  List genresMovie = List();
  for (int i = 0; i < genresId.length; i++) {
    for (int j = 0; j < genres.length; j++) {
      if (genresId[i] == genres[j]['id']) {
        genresMovie.add(genres[j]['name']);
      }
    }
  }
  return genresMovie;
}

class Poster extends StatelessWidget {
  final Movie movie;
  final double width = 330.0;
  Poster({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          fit: BoxFit.cover,
          width: width,
          height: width * 3 / 2,
          fadeInDuration: Duration(milliseconds: 1500),
          placeholder: AssetImage('lib/src/assets/placeholder.png'),
          image: NetworkImage(movie.getPosterPath()),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final Movie movie;
  final List movieGenres;
  Header({Key key, this.movie, this.movieGenres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 16.0,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                  ),
                ],
              ),
              Text(
                movie.releaseDate,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Text(
            movie.title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          height: 20.0,
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            itemCount: movie.genreIds.length,
            itemBuilder: (context, index) {
              return Text(
                movieGenres[index],
                style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(width: 8.0),
          ),
        ),
      ],
    );
  }
}

class Overview extends StatelessWidget {
  final Movie movie;
  Overview({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 32.0),
      child: Text(
        movie.overview,
      ),
    );
  }
}
