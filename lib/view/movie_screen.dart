import 'package:flutter/material.dart';
import 'package:intern_movie_app/view/search.dart';
import 'package:intern_movie_app/services/auth.dart';
import 'package:intern_movie_app/widgets/movie_category_header.dart';
import 'package:intern_movie_app/widgets/movie_gridList.dart';
import 'package:intern_movie_app/widgets/movie_horizontalList.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int bottomBarIndex = 0;
  PageController pageController = PageController();
  List popularMovies = [];
  List topRatedMovies = [];
  List upcomingMovies = [];
  List nowPlayingMovies = [];
  List genres = [];

  final String upcomingText = "Upcoming Movies";
  final String topRatedText = "Top Rated Movies";
  final String popularText = "What's Popular?";
  final String nowPlaying = "Playing in Theatres";
  final String appBarHeader = "GoldenPopcorn";

  final String api_key = "9f6c3716bb8fdcb4893ceb6d3b77500d";
  final String access_token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjZjMzcxNmJiOGZkY2I0ODkzY2ViNmQzYjc3NTAwZCIsInN1YiI6IjYzMTg1YzE3YWFkOWMyMDA3ZjU1YjIyNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5NbYHQgSKJhZiORxQ2hXZCIiAPNx1gsUrd4xCnuyGQg";
  final String baseURL = "https://image.tmdb.org/t/p/w500/";

  @override
  void initState() {
    // TODO: implement initState
    loadMovies();
    super.initState();
  }

  void loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(api_key, access_token));
    logConfig:
    const ConfigLogger(
      //must be true than only all other logs will be shown
      showLogs: true,
      showErrorLogs: true,
    );

    Map popularResult = await tmdbWithCustomLogs.v3.movies.getPopular(page: 1);
    Map topRatedResult =
        await tmdbWithCustomLogs.v3.movies.getTopRated(page: 1);
    Map upcomingMovieResult =
        await tmdbWithCustomLogs.v3.movies.getUpcoming(page: 2);
    Map nowPlayingResult = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    Map movieGenresList = await tmdbWithCustomLogs.v3.genres.getMovieList();

    popularMovies = popularResult["results"];
    topRatedMovies = topRatedResult["results"];
    upcomingMovies = upcomingMovieResult["results"];
    nowPlayingMovies = nowPlayingResult["results"];
    genres = movieGenresList["genres"];
    setState(() {});
  }

  void onTappedBottomBar(int index) {
    bottomBarIndex = index;
    setState(() {});
    pageController.jumpToPage(bottomBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      //appbar ın heightını almak için ayrı obje olarak tanımladık
      actions: [
        IconButton(
          onPressed: () async {
            Provider.of<AuthService>(context, listen: false).signOut();
          },
          icon: Icon(Icons.exit_to_app),
        )
      ],
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(
        appBarHeader,
        style: TextStyle(fontFamily: "Changa"),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: PageView(
          //bottom bar için pageview yaptık
          controller: pageController,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  1,
              child: ListView(
                children: [
                  Column(
                    //movie screenin what's popular column u
                    children: [
                      MovieCategoryHeader(
                          popularText), //ana sayfada 3 tane aynı başlığı kullandığımız için bunu widget yaptık.
                      MovieHorizontalList(
                          genreNames: genres,
                          movieList: popularMovies,
                          borderFlag:
                              false), // ana sayfada 2 tane aynı horizontal listeden kullandığım için bunu da widget yaıp koydum içine ilgili olduğu listeyi gönderdim.
                    ],
                  ),
                  Column(
                    //movie screenin upcoming movies column u
                    children: [
                      MovieCategoryHeader(
                          upcomingText), //ana sayfada 3 tane aynı başlığı kullandığımız için bunu widget yaptık.
                      MovieHorizontalList(
                          genreNames: genres,
                          movieList: upcomingMovies,
                          borderFlag:
                              false), // ana sayfada 2 tane aynı horizontal listeden kullandığım için bunu da widget yaıp koydum içine ilgili olduğu listeyi gönderdim.
                    ],
                  ),
                  Column(
                    //movie screenin top Rated column u , GridView ile yapıldı
                    children: [
                      MovieCategoryHeader(topRatedText),
                      MovieGridList(
                        movieList: topRatedMovies,
                        borderFlag: true,
                        genreNames: genres,
                        listHeight: MediaQuery.of(context).size.height * 0.50,
                      )
                    ],
                  ),
                  Column(
                    //movie screenin upcoming movies column u
                    children: [
                      MovieCategoryHeader(
                        nowPlaying,
                      ), //ana sayfada 3 tane aynı başlığı kullandığımız için bunu widget yaptık.
                      MovieHorizontalList(
                          genreNames: genres,
                          movieList: nowPlayingMovies,
                          borderFlag:
                              false), // ana sayfada 2 tane aynı horizontal listeden kullandığım için bunu da widget yaıp koydum içine ilgili olduğu listeyi gönderdim.
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover),
              ),
            ),
            MovieSearch(genreNames: genres)
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomBarIndex,
            backgroundColor: Theme.of(context).accentColor,
            selectedItemColor: Colors.white,
            onTap: onTappedBottomBar,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search")
            ]),
      ),
    );
  }
}
