import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ifeeds/pages/history_page.dart';
import 'package:ifeeds/pages/home_page.dart';
import 'package:ifeeds/pages/login_page.dart';
import 'package:ifeeds/pages/update_form_page.dart';
import 'package:ifeeds/pages/utils/campus_utils.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    
    CampusUtils.campus = "Lagarto";
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              theme: ThemeData(primaryColor: Color(0xff4E986E)),
              debugShowCheckedModeBanner: false,
              title: 'IFeedS',
              initialRoute: '/login',
              routes: {
                '/home': (context) => HomePage(),
                '/login': (context) => LoginPage(),
                '/update/rating': (context) => UpdateFormPage(),
                '/history': (context) => HistoryPage(),
              },
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        });
  }
}
