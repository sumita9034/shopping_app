import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/screens/cart_screen/cart.dart';
import 'package:shopping_app/screens/details_screen/details.dart';
import 'package:shopping_app/screens/favorite_screen/favoriteview.dart';
import 'package:shopping_app/screens/home_screen/home_appbar.dart';
import 'package:shopping_app/screens/home_screen/homescreen2.dart';
import 'package:shopping_app/screens/profile_screen/profile.dart';
import 'package:shopping_app/screens/resetpass_screen/forgot_otp.dart';

import 'package:shopping_app/screens/signup_screen/Signup.dart';
import 'package:shopping_app/screens/login_screen/loginpage.dart';
import 'package:shopping_app/screens/resetpass_screen/resetpassword.dart';
import 'package:shopping_app/screens/splashscreen.dart';

import 'order_histroy.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WishlistProvider()),
          ChangeNotifierProvider(create: (_) => Cartprovider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primarySwatch: Colors.lightBlue,
          ),

          routes: {
            '/otppage': (context) => Otppage(),
            'sign-up': (context) => SignUp(),
            '/ProductDetails': (context) => Details(),
            'MainHomeScreen': (context) => MyHomePage1(),
            '/Login': (context) => LoginPage(),
            '/proflie': (context) => Profile(),
            '/details': (context) => Details(),
            '/ForgotOtp': (context) => ForgotOtp(),
            '/favoriteview': (context) => FavoriteView(),
            '/Cart': (context) => Cart(),
            '/orderHistroy': (context) => OrderHistroy(),
            '/resetpassword': (context) => Resetpassword(),

          },
          home: const MyHomePage(),
           ));
  }
}
