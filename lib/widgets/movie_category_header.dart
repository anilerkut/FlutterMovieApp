import 'package:flutter/material.dart';

class MovieCategoryHeader extends StatelessWidget {

  // Bu widget movie_screen ekranındaki her listview ın üstündeki logo ve kategori alan adı için oluşturuldu, dışardan kategoriyi string olarak aldım.
  String categoryHeader;

  MovieCategoryHeader(@required this.categoryHeader);

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset("assets/images/logopopcorn.png"),
                        Text(
                          categoryHeader,
                          style: TextStyle(
                              fontFamily: "Changa",
                              color: Theme.of(context).accentColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),               
                        ),
                      ],
                    ),
                  );
  }
}