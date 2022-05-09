import 'dart:convert';

import 'package:http/http.dart' as http;

class Genres {
  //SINGLETON
  static final Genres _singleton = Genres._internal();
  factory Genres() {
    return _singleton;
  }
  Genres._internal();

  String _url = 'api.themoviedb.org';
  String _apiKey = '27bfcbd1174e4ca3999637f6e1233e98';
  String _languague = 'en-US';

  Future<List> getGenres() async {
    Uri url = Uri.https(_url, '/3/genre/movie/list', {
      'api_key': _apiKey,
      'language': _languague,
    });
    http.Response response = await http.get(url);
    Map<String, dynamic> decoded = json.decode(response.body);
    return decoded['genres'];
  }
}
