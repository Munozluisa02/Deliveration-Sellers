import 'package:deliveration_sellers/authentication/login.dart';
import 'package:deliveration_sellers/authentication/register.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                //TODO implement color
                color: Colors.grey,
              ),
            ),
            automaticallyImplyLeading: false,
            title: const Text(
              "Deliveration",
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                //TODO implement fontfamily
                  fontFamily: "",
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.lock, color: Colors.white),
                    text: "Login",
                  ),
                  Tab(
                    icon: Icon(Icons.person, color: Colors.white),
                    text: "Register",
                  )
                ],
              indicatorColor: Colors.white38,
              indicatorWeight: 6,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              //TODO implement color
              color: Colors.grey
            ),
            child: const TabBarView(
              children: [
                LoginScreen(),
                RegisterScreen(),
              ],
            ),
          ),
        )
    );
  }
}
