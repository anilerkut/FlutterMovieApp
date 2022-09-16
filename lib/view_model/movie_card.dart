import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  String imagePath;
  String title;
  String releaseDate;
  bool borderFlag;

  MovieCard({this.imagePath, this.title, this.releaseDate, this.borderFlag});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      padding: const EdgeInsets.fromLTRB(3, 10, 3, 0),
      margin: borderFlag == false
          ? null
          : const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 4,
              child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Image(image: NetworkImage(imagePath))))),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              title,
              textAlign: TextAlign.center,
            )),
          )
        ],
      ),
      decoration: borderFlag == false
          ? BoxDecoration(borderRadius: BorderRadius.circular(20))
          : BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0.2),
            ),
    );
  }
}
