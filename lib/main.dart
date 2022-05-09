import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviedbapp/src/screens/home.dart';
import 'package:moviedbapp/src/screens/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieDB App',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        'movie_detail': (context) => MovieDetail(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(36, 39, 44, 1),
        accentColor: Color.fromRGBO(156, 156, 156, 1),
        canvasColor: Color.fromRGBO(36, 39, 44, 1),
        fontFamily: 'Open Sans',
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
          ),
          caption: TextStyle(
            color: Color.fromRGBO(28, 28, 28, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(156, 156, 156, 1),
          ),
        ),
      ),
    );
  }
}
