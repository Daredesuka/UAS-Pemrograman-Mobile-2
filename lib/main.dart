import 'package:flutter/material.dart';
import 'package:uas_pemrograman_mobile_2/api_service/api_class.dart';
import 'constants/constants.dart';
import 'model/film.dart';
import 'widgets/child_cardstyle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Api',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<List<Film>> _filmList = ClassApi.getFilmList();

  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClassApi.getFilmList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        centerTitle: true,
        elevation: 4,
      ),
      body: FutureBuilder<List<Film>>(
        future: _filmList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Film> _films = snapshot.data!;

            return ListView.builder(
                itemCount: _films.length,
                itemBuilder: (context, index) {
                  var currentFilm = _films[index];
                  return ChildCardStyle(
                      title: Film.trimString(currentFilm.name.toString()),
                      subtitle: Film.readTimestamp(currentFilm.getUpdated),
                      details: Film.removeAllHtmlTags(currentFilm.summary!),
                      rating: currentFilm.getWeight.toString(),
                      originalImg: currentFilm.image!.getOriginal!,
                      imageurl: currentFilm.image!.getMedium!);
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Terjadi Kesalahan'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
