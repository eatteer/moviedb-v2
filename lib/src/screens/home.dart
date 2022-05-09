import 'package:flutter/material.dart';
import 'package:moviedbapp/src/screens/movies.dart';
import 'package:moviedbapp/src/screens/tv.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _screens = [ScreenMovies(), TV()];
  @override
  Widget build(BuildContext context) {
    print(_currentIndex);
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Theme.of(context).accentColor,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            title: Text('TV'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
