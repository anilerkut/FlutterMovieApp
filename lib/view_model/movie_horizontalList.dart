import 'package:flutter/material.dart';
import 'package:intern_movie_app/view/movie_details.dart';

import 'movie_card.dart';

class MovieHorizontalList extends StatelessWidget {
  List movieList;
  List genreNames;
  bool borderFlag;
  final String baseURL = "https://image.tmdb.org/t/p/w500/";
  final String emptyImageURL =
      "https://demo.kolayko.com/public/templates/m-dore/assets/img/placeholder.jpg";
  final String emptyMovieCard =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlwzQ43PINV5ZUsfqNZSFkK2CytXj_dcjWLCu9KES7xfPCrVpooJfqws-8VlhH792xl_g&usqp=CAU";

  MovieHorizontalList(
      {@required this.movieList,
      @required this.borderFlag,
      @required this.genreNames});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.22,
          child: ListView.builder(
              itemCount: movieList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                          movie_genres: movieList[index]["genre_ids"],
                          movie_title: movieList[index]["title"],
                          movie_overview: movieList[index]["overview"],
                          movie_id: movieList[index]["id"],
                          movie_posterURL:
                              movieList[index]["poster_path"] != null
                                  ? baseURL + movieList[index]["poster_path"]
                                  : emptyMovieCard,
                          movie_backdropURL:
                              movieList[index]["backdrop_path"] != null
                                  ? baseURL + movieList[index]["backdrop_path"]
                                  : emptyImageURL,
                          movie_releaseDate: movieList[index]["release_date"],
                          movie_vote:
                              (movieList[index]["vote_average"]).toDouble(),
                          genre_names: genreNames,
                          movie_language: movieList[index]["original_language"],
                        ),
                      ),
                    );
                  },
                  child: MovieCard(
                      imagePath: baseURL + movieList[index]["poster_path"],
                      borderFlag: borderFlag,
                      releaseDate: movieList[index]["release_date"],
                      title: movieList[index]["title"]),
                );
              })),
        ),
      ),
    );
  }
}
