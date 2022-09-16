import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intern_movie_app/user.dart';
import 'package:intern_movie_app/view_model/watchlist_movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'movie_details.dart';

class Watchlist extends StatefulWidget {
  List genreNames;

  @override
  State<Watchlist> createState() => _WatchlistState();

  Watchlist({this.genreNames});
}

class _WatchlistState extends State<Watchlist> {
  final String api_key = "9f6c3716bb8fdcb4893ceb6d3b77500d";
  final String access_token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjZjMzcxNmJiOGZkY2I0ODkzY2ViNmQzYjc3NTAwZCIsInN1YiI6IjYzMTg1YzE3YWFkOWMyMDA3ZjU1YjIyNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5NbYHQgSKJhZiORxQ2hXZCIiAPNx1gsUrd4xCnuyGQg";
  final String baseURL = "https://image.tmdb.org/t/p/w500/";
  List userWatchlist = [];
  List movie_externalID = [];

  Future<void> getUserWatchlist() async {
    //ilk olarak external idlerini, idyi kullanarak çağırdık sonra imdb adi kullanarak film bilgilerine eriştik
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(api_key, access_token));
    logConfig:
    const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    );
    Map watchlistResult;
    Map externalIDResult;
    for (int i = 0; i < User.user_watchList.length; i++) {
      externalIDResult = await tmdbWithCustomLogs.v3.movies
          .getExternalIds(User.user_watchList[i]);
      String movie_imdbID = externalIDResult["imdb_id"];
      watchlistResult = await tmdbWithCustomLogs.v3.find.getById(movie_imdbID);
      userWatchlist.add(watchlistResult["movie_results"]);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserWatchlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: userWatchlist.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                //her elemana yine tıklama özelliği verildi,tıklayınca detay sayfasına yönlendirildi
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetails(
                    movie_genres: userWatchlist[index][0]["genre_ids"],
                    movie_title: userWatchlist[index][0]["title"],
                    movie_overview: userWatchlist[index][0]["overview"],
                    movie_id: userWatchlist[index][0]["id"],
                    movie_posterURL:
                        userWatchlist[index][0]["poster_path"] != null
                            ? baseURL + userWatchlist[index][0]["poster_path"]
                            : userWatchlist,
                    movie_backdropURL:
                        userWatchlist[index][0]["backdrop_path"] != null
                            ? baseURL + userWatchlist[index][0]["backdrop_path"]
                            : userWatchlist,
                    movie_releaseDate: userWatchlist[index][0]["release_date"],
                    movie_vote: double.parse(userWatchlist[index][0]
                            ["vote_average"]
                        .toStringAsFixed(1)),
                    genre_names: widget.genreNames,
                    movie_language: userWatchlist[index][0]
                        ["original_language"],
                  ),
                ),
              );
            },
            child: Padding(
              //listview in item i burada verildi,oluşturduğmuz watchlistModel kullanıldı
              padding: const EdgeInsets.all(5.0),
              child: WatchlistMovieModel(
                  imagePath: baseURL + userWatchlist[index][0]["poster_path"],
                  movie_vote: double.parse(userWatchlist[index][0]
                          ["vote_average"]
                      .toStringAsFixed(1)),
                  release_date: userWatchlist[index][0]["release_date"],
                  title: userWatchlist[index][0]["title"]),
            ),
          );
        }),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}
