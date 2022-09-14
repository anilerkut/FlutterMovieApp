import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intern_movie_app/screens/login.dart';
import 'package:intern_movie_app/controllers/user_status.dart';
import "app_colors.dart";
import 'package:firebase_core/firebase_core.dart';
import 'services/auth.dart';
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: AppColors.munsell,
          accentColor: AppColors.deepCarrotOrange
        ),
        home: UserStatus(),
      ),
    );
  }
}

