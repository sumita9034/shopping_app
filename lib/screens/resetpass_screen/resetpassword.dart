import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'forgot_otp.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({Key? key}) : super(key: key);

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final Enterpass = TextEditingController();
   
  String emailInput="";
  void resetpassword(String emailId)async{
   try{
     var responce=await
     post(Uri.parse('https://shopping-app-backend-t4ay.onrender.com/user/forgotPassword'),
         body:{
          'emailId':emailId,
         });
     print("test");
     if(responce.statusCode==200){
       var data=jsonDecode(responce.body.toString());
       print(data);
       print('forgot password');
       Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotOtp()));
     }
     else if(responce.statusCode==400){
       var data=jsonDecode(responce.body.toString());
       print(data);
       print('User Not Registered!');
    }
   }catch(e){
     print(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Container(


          width: double.infinity,
          child: Padding(
            
            padding: EdgeInsets.only(left: 10,right: 10) ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgate Password",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: Enterpass,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Username',
                          suffixIcon: Icon(Icons.email_sharp)),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){

                        resetpassword(
                          Enterpass.text.toString(),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.redAccent,


                        ),
                     child: Center(
                       child: Text(
                         "OTP",
                         style: TextStyle(
                           fontWeight: FontWeight.w600,
                           fontSize: 18,
                           color: Colors.black
                         ),
                       ),
                     ),
                                         ),
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
}
