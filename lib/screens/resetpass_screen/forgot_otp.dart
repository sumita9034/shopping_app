import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_screen/loginpage.dart';

class ForgotOtp extends StatefulWidget {
  const ForgotOtp({Key? key}) : super(key: key);

  @override
  State<ForgotOtp> createState() => _ForgotOtpState();
}
String digitInputValue="";

class _ForgotOtpState extends State<ForgotOtp> {
  void ResetOtpverify(String userId,String otp  ) async {
    try {
      var response = await post(
          Uri.parse(
              'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnRegister'),
          body: {
            'userId':userId,
            'otp': otp,

          });
      print("test");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Otp verify');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body.toString());
        SharedPreferences preferences= await SharedPreferences.getInstance();
        preferences.setString('userId', data['data']['userId']);
        print(data);
        print("otp invalid");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    body:

      Container(
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerificationCode(
                  length: 4,
                  textStyle: const TextStyle(fontSize: 20),
                  underlineColor: Colors.blueAccent,
                  keyboardType: TextInputType.number,

                  onCompleted: (value) {
                    digitInputValue = value;
                  },
                  onEditing: (value) {

                  },
                ),




              ],
            ),
            SizedBox(
              height: 22,
            ),
            SizedBox(
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {},
                color: Color(0xff0095FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  onPressed: () {
                   // ResetOtpverify();

                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
