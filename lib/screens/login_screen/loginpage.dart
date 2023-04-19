import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/screens/home_screen/homescreen2.dart';
import 'package:shopping_app/components/navigationbar.dart';
import 'package:shopping_app/screens/splashscreen.dart';

import '../resetpass_screen/resetpassword.dart';
import '../signup_screen/Signup.dart';
import '../../models/model_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formfild = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool passwordVisible = false;

  String emailId = "";
  String password = "";
  void Login(String emailId, String password) async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://shopping-app-backend-t4ay.onrender.com/user/login'),
          body: {
            'emailId': emailId,
            'password': password,
          });
      print("test");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        SharedPreferences preferences= await SharedPreferences.getInstance();
        preferences.setString('jwtToken', data['data']['jwtToken']);
        preferences.setString('emailId', data['data']['emailId']);
        preferences.setString('name', data['data']['name']);
        preferences.setString('mobileNo', data['data']['mobileNo']);

        preferences.setBool('isLoggedIn', true);
       print('jwtToken : ${preferences.get("jwtToken")}');
        final token = data['data']['jwttoken'];
        print('Login Successfull');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomBar()));
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("not valid id and pass");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid email or password'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _submitForm() async{
    if(_formfild.currentState!.validate()){
      _formfild.currentState?.save();

      Navigator.pushNamed(context, 'MainHomeScreen');
    }
              }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: const Image(
                        image: AssetImage('assets/background.png'),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to Your Account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formfild,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            value = emailId;
                          },
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'email',
                            suffixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email";
                            }
                            bool emailvalid =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value);
                            if (value!.isEmpty) {
                              return "Enter email";
                            } else if (!emailvalid) {
                              return "Enter valid email";
                            }
                          },
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            value = password;
                          },

                          controller: passwordcontroller,
                          obscureText: !passwordVisible,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'password',

                            //  helperText: "wwwwwwwsedr",
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible? Icons.visibility
                                    : Icons.visibility_off,
                              //  color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },

                          ),
                            ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            } else if (passwordcontroller.text.length < 6) {
                              return "Enter password correct...";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: InkWell(
                    onTap: () async{
                      var sharePref=await SharedPreferences.getInstance();
                      sharePref.setBool(MyHomePageState.Keylogin, true);

                      if (_formfild.currentState!.validate()) {
                        Login(
                          emailcontroller.text.toString(),
                          passwordcontroller.text.toString(),
                        );
                      }
                      print("onsubmit");
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          if (_formfild.currentState!.validate()) {
                            // print("Success");
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black,fontSize: 19),
                        ))
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Resetpassword()));
                        },
                        child: Text(
                          "Forgote password?",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ))
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void saveLogin (String emailshare,String passwordshare) async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString('emailshare', emailshare);
  pref.setString('passwordshare', passwordshare);

}