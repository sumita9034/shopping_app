import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/screens/home_screen/homescreen2.dart';
import 'package:shopping_app/components/navigationbar.dart';

import '../../apidata/api_service.dart';
import '../login_screen/loginpage.dart';

class Otppage extends StatefulWidget {
  const Otppage({Key? key}) : super(key: key);

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  String digitInputValue = "";


  Future<Map<String, dynamic>> Otpverify(String userId, String otp) async {
    try {
      var response = await post(
          Uri.parse(
              'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnRegister'),
          body: {
            'userId': userId,
            'otp': otp,
          });
      String responseBody=response.body;

      print("test");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        print(data);
        print('Otp verify');
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        return jsonDecode(responseBody) as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body.toString());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('userId', data['data']['userId']);
        print(data);
        print("otp invalid");

      }
    } catch (e) {
      print(e.toString());
      return {};
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
  return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/otp.jpg',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
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
                        SizedBox(
                          width: 45,
                          height: 68,
                        ),
                        VerificationCode(
                          length: 4,
                          textStyle: const TextStyle(fontSize: 20),
                          underlineColor: Colors.blueAccent,
                          keyboardType: TextInputType.number,
                          onCompleted: (value) {
                            digitInputValue = value;
                          },
                          onEditing: (value) {},
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

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginPage()));
                            Otpverify(id.toString(), digitInputValue.toString()
                           );
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
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              TextButton(
                onPressed: () {
                  ResendOtp(id.toString());
                },
                child: Text("Resend New Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
