import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/navigationbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController mobileNo = TextEditingController();

  String name1 = '';
  String emailId1 = '';
  String mobileNo1 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('jwtToken');
    setState(() {
      name1 = preferences.getString('name').toString();
      name.text = name1;
     // name1 = name.text;

      print(name1);
      emailId1 = preferences
          .getString(
            'emailId',
          )
          .toString();
      emailId.text = emailId1;
      mobileNo1 = preferences.getString('mobileNo').toString();
      mobileNo.text = mobileNo1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomBar()));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 25),
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.black),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/profile.jpg")))),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.black),
                            color: Colors.pink,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: name,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: emailId,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: mobileNo,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Address",
                    hintText: "Add You'r Assress",
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
              child: Container(
                  height: 50,
                  color: Colors.white,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                  ))),
          Expanded(
              child: Container(
                  height: 50,
                 // color: Colors.orange,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Cancle",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                    ),
                  ))),
        ],
      ),
    );
  }
}
