import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/screens/details_screen/details.dart';
import 'package:shopping_app/screens/home_screen/home_appbar.dart';
import 'package:shopping_app/screens/home_screen/homescreen2.dart';

import 'package:shopping_app/screens/signup_screen/Signup.dart';
import 'package:shopping_app/screens/login_screen/loginpage.dart';
import 'package:shopping_app/screens/resetpass_screen/resetpassword.dart';
import 'package:shopping_app/screens/splashscreen.dart';
import 'package:shopping_app/rout_file.dart';

import 'provider_file/cartprovider.dart';
import 'provider_file/favprovider.dart';
import 'components/navigationbar.dart';
import 'screens/otp_screen/otppage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        MultiProvider(
        providers: [
         ChangeNotifierProvider(create: (_) => WishlistProvider()),
         ChangeNotifierProvider(create: (_) => Cartprovider()),
        ],
         child:
        MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

brightness: Brightness.light,
        primarySwatch: Colors.lightBlue,
      ),

      routes: {
        '/otppage':(context)=>Otppage(),
        'sign-up':(context)=>SignUp(),
        '/ProductDetails':(context) => Details(),
        'MainHomeScreen' : (context)=> MyHomePage1(),
        '/Login' : (context) => LoginPage(),
        '/otpPage':(context) => Otppage(),
      },
      home:const MyHomePage(),
      // initialRoute: Routes_file.Appbarhome,
      // routes: {
      //   Routes_file.splash: (context) => const MyHomePage(),
      //   Routes_file.loginScreen: (context) => const LoginPage(),
      //   Routes_file.signup: (context) => const SignUp(),
      //   Routes_file.otpScreen: (context) => const Otppage(),
      //   Routes_file.ProductScreen: (context) => const MyHomePage1(),
      // },
      // debugShowCheckedModeBanner: false,
      // // home: const LoginPage(),
      // home:MyHomePage1(),
      //
        )
    );
  }
}
