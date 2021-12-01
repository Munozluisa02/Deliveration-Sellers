import 'dart:async';

import 'package:deliveration_sellers/authentication/auth_screen.dart';
import 'package:deliveration_sellers/global/global.dart';
import 'package:deliveration_sellers/main_screens/home_screen.dart';
import 'package:flutter/material.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer(){
    Timer(const Duration(seconds: 1), () async {

      //if seller is logged in home screen will be shown

      if(firebaseAuth.currentUser != null){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(""),
              //TODO replace container by Image.assets("")
              Container(
                color: Colors.red,
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Sell Food Online",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40,
                    //TODO fix fontfamily
                    fontFamily: "",
                    letterSpacing: 3,
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
