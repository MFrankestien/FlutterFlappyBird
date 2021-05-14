import 'package:flappybird_game/start_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  if(kIsWeb){
    runApp(MaterialApp(home: HomePage(),) );
  }
  else(
      runApp(MyApp())
  );

  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
      routes: {
        HomePage.ROUTE_NAME: (context) => HomePage(),
      },
    );
  }
}

