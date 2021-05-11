import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flappybird_game/day_night_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class StartScreen extends StatefulWidget {

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  static const String Theme_KEY = 'theme';
  Future<void> setTheme () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Theme_KEY, isDark);

  }
  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool(Theme_KEY) ?? 0;
    });
  }
bool isDark= true;


  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        height: deviceHeight,
        width: deviceWidth ,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image:isDark? AssetImage(
              'assets/images/day.png',
            ): AssetImage(
              'assets/images/night.PNG',
            ),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 5,
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [Column(
                  children: [
                    Spacer(),
                    Spacer(),
                    Image.asset(
                      'assets/images/bird.png',
                      width: deviceWidth / 2,
                    ),
                    Image(image:AssetImage('assets/images/name.bng.png'),width: deviceWidth /2,),
                    Spacer(),
                    Container(
                      child: DayNightSwitch(
                        height: deviceHeight /4,
                        width: deviceWidth/4,
                        onSelection: (isCheck){
                          setState(() {
                            isDark = isCheck;
                           setTheme();
                            print(isDark);
                            print(isCheck);
                          });

                        },
                      ),
                    ),

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
              ),
            )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getTheme();
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
      height: 30,
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
