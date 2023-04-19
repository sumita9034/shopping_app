import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/model_api_data.dart';
import '../models/model_get_Order_histroy.dart';
//import '../models/model_get_Order_histroy.dart';


GetProduct() async {
  // Uri url = Uri.parse(
  //     "https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct");
  // var res = await http.get(url);
  try {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwtToken'.toString()) ?? '';
    print(jwtToken);
    final uri = Uri.parse(
        "https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct");
    var res = await http.get(uri, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${jwtToken}',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    var jsonData = jsonDecode(res.body);
    print(jsonData);
    if (res.statusCode == 200) {
      var data = welcomeFromJsonProduct(res.body);
      print(data);

      return data.Productdata;
    } else {
      print("error during get the data");
    }
  } catch (e) {
    print(e.toString());
  }
}




GetOrderHistroy() async {
  Uri url = Uri.parse(
      "https://shopping-app-backend-t4ay.onrender.com/order/getOrderHistory");
  var res = await http.get(url);
  try {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwtToken'.toString()) ?? '';
    print(jwtToken);
    final uri = Uri.parse(
        "https://shopping-app-backend-t4ay.onrender.com/order/getOrderHistory");
    var res = await http.get(uri, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${jwtToken}',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    var jsonData = jsonDecode(res.body);
    //print(jsonData);
    if (res.statusCode == 200) {
      var data = welcomeFromJson(res.body);
      print(data);
      print("dataaa");
      return data.histroy;
    } else {
      print("error during get the data product list");
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<void> ResendOtp(String userId) async {
  // final uri = Uri.parse(
  //     "https://shopping-app-backend-t4ay.onrender.com/watchList/addToWatchList");
  var requestBody={

    "userId": userId
  };

  try {
    final pref = await SharedPreferences.getInstance();
    final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

    var uri = Uri.parse(

        "https://shopping-app-backend-t4ay.onrender.com/user/resendOtp"
    );
    var res = await http.post(uri,headers: {
      // 'Content-type': 'application/json',
      'Authorization': ' Bearer $jwtToken',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    }, body:requestBody);

    var jsonData = jsonDecode(res.body);

    if (res.statusCode == 200) {
      //var data=welcomeFromJson(res.body);

      print("resend otp");
      //return data.Productdata;
    } else {
      print("not resend otp");
    }
  } catch (e) {
    print(e.toString());
  }
}

