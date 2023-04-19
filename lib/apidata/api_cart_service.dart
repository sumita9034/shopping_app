import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/models/model_api_data.dart';

AddToCart(String productId) async {
  // final uri = Uri.parse(
  //     "https://shopping-app-backend-t4ay.onrender.com/cart/addToCart");
  var requestBody={

    "productId": productId
  };

  try {
    final pref = await SharedPreferences.getInstance();
    final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

    var uri = Uri.parse(
        "https://shopping-app-backend-t4ay.onrender.com/cart/addToCart");
    var res = await http.post(uri,headers: {
     // 'Content-type': 'application/json',
      'Authorization': ' Bearer $jwtToken',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    }, body:requestBody);

    var jsonData = jsonDecode(res.body);

    if (res.statusCode == 201) {
      //var data=welcomeFromJson(res.body);

      print("Item Added To Cart!");
      //return data.Productdata;
    } else {
      print("product not add");
    }
  } catch (e) {
    print(e.toString());
  }
}

AddtoWish(String productId) async {
  // final uri = Uri.parse(
  //     "https://shopping-app-backend-t4ay.onrender.com/watchList/addToWatchList");
  var requestBody={

    "productId": productId
  };

  try {
    final pref = await SharedPreferences.getInstance();
    final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

    var uri = Uri.parse(

            "https://shopping-app-backend-t4ay.onrender.com/watchList/addToWatchList"
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

      print("Item Added To wish list!");
      //return data.Productdata;
    } else {
      print("product not addtowish");
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<void> PlaceOrder(String cartId , String cartTotal) async{
  // final uri = Uri.parse(
  //     "https://shopping-app-backend-t4ay.onrender.com/order/placeOrder");
  var requestBody={

    "cartId": cartId,
    "cartTotal" : cartTotal
  };

  try {
    final pref = await SharedPreferences.getInstance();
    final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

    var uri = Uri.parse(

        "https://shopping-app-backend-t4ay.onrender.com/order/placeOrder"
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

      print("Item Place Order!");
      //return data.Productdata;
    } else {
      print("product no order");
    }
  } catch (e) {
    print(e.toString());
  }
}




