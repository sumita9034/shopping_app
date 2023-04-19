import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../models/cart_model1.dart';
import '../models/model_api_data.dart';

class Cartprovider extends ChangeNotifier {
  List<CartAddItemModelClass> _Item = [];
  List<dynamic> get Item => _Item;

  Future<List<CartAddItemModelClass>> GetCart() async {
    List<CartAddItemModelClass> _Item1 = [];
     //Uri url = Uri.parse("https://shopping-app-backend-t4ay.onrender.com/cart/getMyCart");
    // var res = await http.get(url);
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken = prefs.getString('jwtToken'.toString()) ?? '';
      var uri = Uri.parse(
          "https://shopping-app-backend-t4ay.onrender.com/cart/getMyCart");
      var response = await http.get(uri, headers: {
        'Content-type': 'application/json',
        'Authorization': ' Bearer $jwtToken',
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      });
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<CartAddItemModelClass> productList = [];
        productList = [CartAddItemModelClass.fromJson(jsonData)];
        _Item = productList;
        _Item1 = productList;

        notifyListeners();

        return _Item1;
      } else {
        print("error during get the data");
      }
    } catch (e) {
      print(e.toString());
    }
    return _Item1;
  }

  Future<void> IncreaseCartItem(String cartItemId) async {
    var requestBody = {"cartItemId": cartItemId};

    try {
      final pref = await SharedPreferences.getInstance();
      final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          "https://shopping-app-backend-t4ay.onrender.com/cart/increaseProductQuantity");
      var res = await http.post(uri,
          headers: {
            // 'Content-type': 'application/json',
            'Authorization': ' Bearer $jwtToken',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: requestBody);

      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
       // var data=welcomeFromJson(res.body);

        print("item Increase");

        notifyListeners();
        //return data.Productdata;
      } else {
        print("NOT Increase");
      }
    } catch (e) {
      print(e.toString());
    }
  }
 Future<void> DecreaseItem(String cartItemId) async {
     // final uri = Uri.parse(
     //    "https://shopping-app-backend-t4ay.onrender.com/cart/decreaseProductQuantity");
    var requestBody={

      'cartItemId':cartItemId,
    };

    try {
      final pref = await SharedPreferences.getInstance();
      final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          "https://shopping-app-backend-t4ay.onrender.com/cart/decreaseProductQuantity");
      var res = await http.post(uri,headers: {
        // 'Content-type': 'application/json',
        'Authorization': ' Bearer $jwtToken',
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      }, body:requestBody);

      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        //var data=welcomeFromJson(res.body);

        print("Decrease");
        notifyListeners();
        //return data.Productdata;
      } else {
        print("Not Decrease");

      }
    } catch (e) {
      print(e.toString());
    }
  }

 Future<void> RemoveFromCart(String cartItemId) async {
     // final uri = Uri.parse(
     //     "https://shopping-app-backend-t4ay.onrender.com/cart/removeProductFromCart");
    var requestBody={

      "cartItemId": cartItemId
    };

    try {
      final pref = await SharedPreferences.getInstance();
      final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          "https://shopping-app-backend-t4ay.onrender.com/cart/removeProductFromCart");
      var res = await http.post(uri,headers: {
        // 'Content-type': 'application/json',
        'Authorization': ' Bearer $jwtToken',
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      }, body:requestBody);

      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        //var data=welcomeFromJson(res.body);

        print("remove");
        notifyListeners();
        //return data.Productdata;
      } else {
        print("product not remove");
      }
    } catch (e) {
      print(e.toString());
    }
  }


}
