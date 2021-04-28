import 'dart:async';

import 'package:flappybird_game/barriers.dart';
import 'package:flutter/material.dart';
import 'bird.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;
  int score = 0;
  int highscore = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
      print("barier 1  $barrierXOne");
      print("barier 2  $barrierXTwo");
      print("bird axis $birdYAxis");
      print(score);
    });
    keepScore();
  }

  void restart() {
    setState(() {
      barrierXOne = 1;
      barrierXTwo = barrierXOne + 1.5;
      time = 0;
      birdYAxis = 0;
      height = 0;
      score = 0;
    });

  }

  void _showDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GAME OVER",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "SCORE:  ${score.toString()}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            actions: [
              FlatButton(
                child:
                Text("PLAY AGAIN", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  if (score > highscore) {
                    highscore = score;
                  }
                  setState(() {
                    gameHasStarted = false;
                  });
                  restart();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;

        barrierXOne -= 0.05;
        barrierXTwo -= 0.05;
      });

      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.04;
        }
      });

      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3.5;
        } else {
          barrierXTwo -= 0.04;
        }
      });

      if (birdYAxis > 1) {
        timer.cancel();
        print(birdYAxis);
        gameHasStarted = false;
        _showDialog();
      }
    });
  }

  void keepScore() {
    setState(() {
      if (barrierXOne > 0.04) {
        score += 1;
      } else if (barrierXOne < 0.04) {
        score += 1;
      }
    });
  } // this function responsable to make the bird jump according to low attraction ahm mo3adlten 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
            flex: 2,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (gameHasStarted) {
                      jump();
                    } else {
                      startGame();
                    }
                  },
                  child: Container(
                      child: AnimatedContainer(
                          alignment: Alignment(0, birdYAxis),
                          duration: Duration(
                              milliseconds:
                                  0), //0 to make the bird in the mid and birdPos is variable to make the bird go up and down
                          child: MyBird()),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/day.png")))),
                ),
                Container(child: Text("0")),
        AnimatedContainer(
          alignment: Alignment(barrierXOne, 1.4),
          duration: Duration(milliseconds: 0),
          child: MyBarrier(
            position: "bot",
            size: 150.0,
          ),
        ),
        AnimatedContainer(
          alignment: Alignment(barrierXOne, -1.4),
          duration: Duration(milliseconds: 0),
          child: MyBarrier(
            position: "top",
            size: 150.0,
          ),
        ),
        AnimatedContainer(
          alignment: Alignment(barrierXTwo, 1.2),
          duration: Duration(milliseconds: 0),
          child: MyBarrier(
            size: 100.0,
            position: "bot",
          ),
        ),
        AnimatedContainer(
          alignment: Alignment(barrierXTwo, -1.2),
          duration: Duration(milliseconds: 0),
          child: MyBarrier(


            size: 220.0,
          ),
        )],
            )),

        Container(
          height: 10,
          color: Colors.green[800],
        ),
        Expanded(
            child: Container(
          color: Colors.brown[700],
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SCORE",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(score.toString(),
                      style:
                      TextStyle(color: Colors.white, fontSize: 35)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "BEST",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(highscore.toString(),
                      style:
                      TextStyle(color: Colors.white, fontSize: 35)),

                ],
              ),
            ],
          ),
            ),
        )
      ],
      ),

    );

  }
}

