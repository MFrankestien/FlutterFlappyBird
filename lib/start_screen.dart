import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/day.png',
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8,
          ),
          child: Stack(
            children: [Column(
              children: [
                Spacer(),
                Spacer(),
                Image.asset(
                  'assets/images/bird.png',
                  width: deviceWidth / 2,
                ),
                Image(image:AssetImage('assets/images/name.bng.png')),
                Spacer(),
                MenuButton(
                  width: deviceWidth,
                  color: Colors.blue,
                  textColor: Colors.white,
                  text: 'Start Game',
                  onPress: () {
                    Navigator.of(context).pushNamed(HomePage.ROUTE_NAME);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                MenuButton(
                  width: deviceWidth,
                  color: Colors.red[900],
                  textColor: Colors.white,
                  text: 'Quit',
                  onPress: () {
                    SystemNavigator.pop();
                  },
                ),
                Spacer(),
              ],
            ),],
          )
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final double width;
  final String text;
  final Color textColor;
  final Color color;
  final Function onPress;

  const MenuButton({
    this.width,
    this.text,
    this.textColor,
    this.color,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 52,
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: onPress,
      ),
    );
  }
}