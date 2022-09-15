import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_movie_app/view/movie_screen.dart';
import 'package:provider/provider.dart';
import 'package:intern_movie_app/view/login.dart';

import '../../services/auth.dart';

class UserStatus extends StatefulWidget {

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
        stream: _auth.authStatus(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data == null ? LoginScreen() : MovieScreen();
          } else {
            return SizedBox(
              height: 300,
              width: 300,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
