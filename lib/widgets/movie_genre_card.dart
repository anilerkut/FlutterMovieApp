import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_movie_app/app_colors.dart';

class GenreCard extends StatelessWidget {
  String genre;

  GenreCard({@required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: AppColors.deepCarrotOrange),
      child: Text(genre,style: TextStyle(fontFamily: "Changa",color: Colors.white),));
  }
}