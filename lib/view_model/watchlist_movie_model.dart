import 'package:flutter/material.dart';

class WatchlistMovieModel extends StatelessWidget {
  double movie_vote;
  String imagePath;
  String title;
  String release_date;

  WatchlistMovieModel(
      {this.imagePath, this.title, this.movie_vote, this.release_date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.width * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            ClipRRect( //film posteri bölümü
              borderRadius: BorderRadius.circular(8),
              child: Image(image: NetworkImage(imagePath)), //filmin posteri
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,), 
            Expanded( //filmin ismini ve release date i içeren container
              flex: 5,
              child: Container(
                child: Column(
                  //film bilgileri için olan column
                  children: [                                    
                    Container(       //film isminin containerı               
                      alignment: Alignment.centerLeft,                                             
                      child: FittedBox(
                        child: Text(
                          title,
                          style: TextStyle(fontFamily: "Changa", fontSize: 20),
                        ),
                      ),
                    ), //karttaki filmin ismi                 
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text( //release date
                        release_date,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                ),
              ),
            ),            
            Expanded( //filmin puanını gösteren bölüm
              flex: 2,
              child: Container(                                
                child: Row(
                  //kart ikonundaki film puanı bölümü
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 35,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                    Text(
                      movie_vote.toString(),
                      style: TextStyle(fontSize: 20,fontFamily: "Changa"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        //container ın şekil alanı
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
