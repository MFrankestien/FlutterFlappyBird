import 'dart:async';

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
  static double birdPos= 0;
  double time=0;
  double height=0;
  double intheight=birdPos;
  bool gameStarted=false; // hay4of hal el le3ba e4ta8alet aslan wla la2 3a4an y7sb el hieght w el time

  void jump() {
setState(() {
  time=0;
  intheight=birdPos;
});

  } // de 34an kol mara ados y jump w el timer yfdl wa7ed le2n lw kont 3amltha b nafs el taimer kan kol mara ha y create timer gded 1
  void startGame(){
    gameStarted=true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04; // for every frame
      height= -4.9 * time * time + 2.8 * time ;
      setState(() {
        birdPos= intheight - height;
      });
      if(birdPos > 1){
        gameStarted=false;
        timer.cancel();
      }
    });
  }// this function responsable to make the bird jump according to low attraction ahm mo3adlten 2

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: (){
              if(gameStarted){
                jump();
              }
              else{
                startGame();
              }
            },
            child: Container(
              child: AnimatedContainer(
                  alignment: Alignment(0,birdPos),
                  duration: Duration(milliseconds: 0),//0 to make the bird in the mid and birdPos is variable to make the bird go up and down
                  child: MyBird()),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: AssetImage("assets/images/day.png")))),
          ),
        ),
        Container(
          height: 10,
          color: Colors.green[800],
        ),
        Expanded(
            child: Container(
          color: Colors.brown[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SCORE",style: TextStyle(color: Colors.white,fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("0",style: TextStyle(color: Colors.white,fontSize: 40),)
                    ],

                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Best",style: TextStyle(color: Colors.white,fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("0",style: TextStyle(color: Colors.white,fontSize: 40),)
                    ],

                  )
                ],

              ),
        )),
      ]),
    );
  }
}
