import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/model_signup.dart';
import '../login_screen/loginpage.dart';
import '../otp_screen/otppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool passwordVisible = false;
  final _formfild = GlobalKey<FormState>();

  bool pass = false;

  late SharedPreferences pref;

  @override
  void initState() {
    //initPreferences();

    // TODO: implement initState
    super.initState();
  }

  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final number = TextEditingController();

  String emailInputValue = "";
  String passwordInputValue = "";
  String usernameInputValue = "";
  String mobileInputValue = "";

  void register (
      String name, String mobileNo, String emailId, String password) async {
    try {
      var response = await post(
          Uri.parse('https://shopping-app-backend-t4ay.onrender.com/user/registerUser'),
          body: {
            'name': name,
            'mobileNo': mobileNo,
            'emailId': emailId,
            'password': password,
          });
      print("test");
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());

        String userID = data['data']['_id'];
        // print(data['token']);
        print('signup Successfull');
        Navigator.pushNamed(context,'/otpPage',arguments: userID.toString());
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("User already exist!!!");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("NOTE"),
                content:
                Text("This  gmail is already Registered."),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   brightness: Brightness.light,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       size: 20,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(

            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 90,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an account",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    )
                  ],
                ),
                Form(
                  key: _formfild,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (value) {
                          value = usernameInputValue;
                        },
                        controller: username,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'UserName',
                          suffixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter username";
                          }

                        },
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          value = emailInputValue;
                        },
                        controller: email,
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
                          value = mobileInputValue;
                        },
                        controller: number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Mobile number',
                          suffixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Phone number";
                          }
                          else if(number.text.length<10){
                             return "Enter valide phone number";
                           }
                        },
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          value = passwordInputValue;
                        },
                        controller: password,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            child: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          }
                        },
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      TextFormField(
                        obscureText: !pass,
                        //controller: ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Confirm Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                pass = !pass;
                              });
                            },
                            child: Icon(
                                pass ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                          validator: (val){
                            if(val!.isEmpty)
                              return 'Enter confirm password';
                            if(val != password.text)
                              return 'Not Match';
                            return null;
                          }
                      ),
                    ],
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      if (_formfild.currentState!.validate()) {
                        // print("Success");
                        // email.clear();
                        // password.clear();

                        register(
                          username.text.toString(),
                          number.text.toString(),
                          email.text.toString(),
                          password.text.toString(),
                        );
                      }
                      // Navigator.push(context,
                      //            MaterialPageRoute(builder: (context) => BottomBar()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    TextButton(
                       onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));

                    }, child: Text(" Login",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
//   void registerUser() async{
//     final Data data= Data(name: '',
//         mobileNo: number.,
//         emailId: email.text,
//     )
//     }
//   void initPreferences() async {
//     pref = await SharedPreferences.getInstance();
//   }
}

