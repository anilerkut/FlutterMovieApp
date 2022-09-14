import 'package:flutter/material.dart';
import 'package:intern_movie_app/widgets/movie_horizontalList.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../widgets/movie_card.dart';
import '../widgets/movie_gridList.dart';

class MovieSearch extends StatefulWidget {
  List genreNames;
  @override
  State<MovieSearch> createState() => _MovieSearchState();

  MovieSearch({this.genreNames});
}

class _MovieSearchState extends State<MovieSearch> {
  final String api_key = "9f6c3716bb8fdcb4893ceb6d3b77500d";
  final String access_token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjZjMzcxNmJiOGZkY2I0ODkzY2ViNmQzYjc3NTAwZCIsInN1YiI6IjYzMTg1YzE3YWFkOWMyMDA3ZjU1YjIyNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5NbYHQgSKJhZiORxQ2hXZCIiAPNx1gsUrd4xCnuyGQg";
  final String baseURL = "https://image.tmdb.org/t/p/w500/";
  List searchMovies = [];

  TextEditingController searchingMovieController = TextEditingController();

  Future<void> movieSearchingByName(String text) async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(api_key, access_token));
    logConfig:
    const ConfigLogger(
      //must be true than only all other logs will be shown
      showLogs: true,
      showErrorLogs: true,
    );

    Map searchResult = await tmdbWithCustomLogs.v3.search.queryMovies(text);
    searchMovies = searchResult["results"];
    setState(() {});
    print("asdads");
  }

  @override
  Widget build(BuildContext context) {
    if (searchingMovieController.text != null) {
      (searchingMovieController.text);
    }
    ;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded( //movie arama kısmı
                      flex: 6,
                      child: TextFormField(
                        controller: searchingMovieController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Enter Movie",
                          labelText: "Movie",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: new BorderSide(color: Colors.teal)),
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()), //search bottun ile arama kısmı arasındaki boşluk
                    Expanded( //search button
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          await movieSearchingByName(
                              searchingMovieController.text);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5),
                          child: Text(
                            'SEARCH',
                            style:
                                TextStyle(fontFamily: "Changa", fontSize: 10),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // <-- Radius
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            searchMovies.isEmpty //butona bastıktan sonra listenen film arama listesi
                ? Container()
                : MovieGridList(
                    movieList: searchMovies,
                    borderFlag: false,
                    genreNames: widget.genreNames,
                    listHeight: MediaQuery.of(context).size.height * 0.70,
                  )
          ],
        ),
      ),
    );
  }
}
