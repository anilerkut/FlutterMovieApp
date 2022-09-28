import 'package:flutter/material.dart';
import 'package:intern_movie_app/view_model/movie_genre_card.dart';
import 'package:intern_movie_app/user_watchlist.dart';

class MovieDetails extends StatefulWidget {

  List movie_genres;
  List genre_names;
  String movie_title;
  String movie_overview;
  int movie_id;
  String movie_posterURL;
  String movie_backdropURL;
  String movie_releaseDate;
  double movie_vote;
  String movie_language;

  MovieDetails(
      {this.movie_genres,this.genre_names, this.movie_title,this.movie_overview,this.movie_id,this.movie_posterURL,this.movie_backdropURL,this.movie_releaseDate,this.movie_vote,this.movie_language});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: (MediaQuery.of(context).size.height * 1),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                      child: Image(
                          image: NetworkImage(widget
                              .movie_backdropURL))), //burası sayfanın en üstünde yer alan film arka planı
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          //burası film scoreunu ve releasedate i barındıran row
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 40,
                            ),
                            Text(
                              widget.movie_vote.toString(),
                              style: TextStyle(
                                  fontSize: 23,fontFamily: "Changa"),
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            //release date sütunu
                            children: [
                              Text("Release Date",
                                  style: TextStyle(fontSize: 11)),
                              Text(widget.movie_releaseDate,
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //burası genre cardları bölümü
                    width: MediaQuery.of(context).size.width * 1,
                    child: widget.movie_genres.isEmpty
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: widget.movie_genres.map(
                              (e) {
                                for (var index = 0;
                                    index < widget.genre_names.length;
                                    index++) {
                                  if (e == widget.genre_names[index]["id"]) {
                                    return GenreCard(
                                        genre: (widget.genre_names[index]
                                                ["name"])
                                            .toString());
                                  }
                                }
                              },
                            ).toList(),
                          ),
                  ),
                  Container(
                    //burası da film afişinin , overview in ve başlığın olduğu alan
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      children: [
                        Expanded(
                          //Filmin title ı burda yer alıyor
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            child: FittedBox(
                              child: Text(
                                widget.movie_title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Changa"),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          //filmin posteri ve overviewi burda yer alıyor
                          flex: 7,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(widget.movie_posterURL),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 11,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Overview",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        child: Text(widget.movie_overview),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    //add to watchlist butonu
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor:
                              UserWatchlist.user_watchList.contains(widget.movie_id)
                                  ? Colors.grey
                                  : Theme.of(context).primaryColor),
                      onPressed: UserWatchlist.user_watchList.contains(widget.movie_id)
                          ? () {
                              UserWatchlist.user_watchList.remove(widget.movie_id);
                              setState(() {});
                            }
                          : () {
                              UserWatchlist.user_watchList.add(widget.movie_id);
                              setState(() {});
                            }, //burada user listte film idsinin kontrolünü yaptım, listede id varsa button disable oldu.
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserWatchlist.user_watchList.contains(widget.movie_id)
                              ? Text(
                                  "ALREADY ADDED",
                                  style: TextStyle(fontFamily: "Changa"),
                                )
                              : Text(
                                  "ADD TO WATHCLIST",
                                  style: TextStyle(fontFamily: "Changa"),
                                )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
