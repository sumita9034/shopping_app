import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../models/watchlist_model.dart';

class WishlistProvider extends ChangeNotifier {
  List<WatchListListClass> _Item = [];
  List<dynamic> get Item => _Item;


  Future<List<WatchListListClass>> GetWatchFun() async {
    List<WatchListListClass> _Item1 = [];
    Uri url = Uri.parse("https://shopping-app-backend-t4ay.onrender.com/watchList/getWatchList");
    var res = await http.get(url);
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken = prefs.getString('jwtToken'.toString()) ?? '';
      var uri = Uri.parse(
          "https://shopping-app-backend-t4ay.onrender.com/watchList/getWatchList");
      var response = await http.get(uri, headers: {
        'Content-type': 'application/json',
        'Authorization': ' Bearer $jwtToken',
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      });
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<WatchListListClass> WatchList = [];
        WatchList =  [WatchListListClass.fromJson(jsonData)];
        _Item = WatchList;
        _Item1 = WatchList;
         // WatchList.clear();
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
        notifyListeners();
        print("Item Added To wish list!");
        //return data.Productdata;
      } else {
        print("product not addtowish");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Removewish(String wathListItemId) async {
    final uri = Uri.parse(
        "");
    var requestBody={"wathListItemId": wathListItemId
    };
    try {
      final pref = await SharedPreferences.getInstance();
      final jwtToken = pref.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          "https://shopping-app-backend-t4ay.onrender.com/watchList/removeFromWatchList");
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
