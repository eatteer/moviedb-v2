import 'package:flutter/material.dart';
import 'package:moviedbapp/src/models/movie.dart';

class ListViewMovies extends StatelessWidget {
  final double height = 430.0;
  final List movies;
  ListViewMovies({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Movie movie = movies[index];
          return GestureDetector(
            child: MovieCard(movie: movie),
            onTap: () => Navigator.pushNamed(context, 'movie_detail', arguments: movie),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 32.0),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double width = 230.0;
  MovieCard({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: FadeInImage(
            fit: BoxFit.cover,
            width: width,
            height: width * 3 / 2,
            placeholder: AssetImage('lib/src/assets/placeholder.png'),
            image: NetworkImage(movie.getPosterPath()),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(223, 228, 231, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
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
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Text(
                        movie.releaseDate,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
