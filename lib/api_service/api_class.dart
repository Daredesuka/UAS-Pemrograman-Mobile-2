import 'package:dio/dio.dart';
import '../model/film.dart';

class ClassApi {
  static const String baseUrl = 'https://api.tvmaze.com/shows?page=1';

  static Future<List<Film>> getFilmList() async {
    List<Film> _list = [];

    var result = await Dio().get(baseUrl);

    _list = (result.data as List).map((e) => Film.fromJson(e)).toList();

    return _list;
  }
}
