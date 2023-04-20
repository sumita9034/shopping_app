import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/screens/home_screen/homescreen2.dart';
import 'package:shopping_app/components/navigationbar.dart';
import 'dart:async';

import 'login_screen/loginpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const String Keylogin = 'login';
 bool Opacity= true;
 bool? logInBool;
  @override
  void initState() {
    super.initState();
    whereTogo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Image.asset('assets/splash.png')
    );
  }

  void whereTogo() async {

     var sharePref = await SharedPreferences.getInstance();

    var isLogginedIn = sharePref.getBool(Keylogin);
    Timer(Duration(seconds: 3), () {
      if (isLogginedIn != null) {
        if (isLogginedIn) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (contex) => BottomBar()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }
      } else
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
    });
  }
}
