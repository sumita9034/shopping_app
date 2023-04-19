// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJsonProduct(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJsonProduct(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.staus,
    required this.msg,
    required this.totalProduct,
    required this.Productdata,
  });

  int? staus;
  String? msg;
  int? totalProduct;

  List<Datum> Productdata;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    staus: json["staus"] ?? 0,
    msg: json["msg"] ?? '',
    totalProduct: json["totalProduct"] ?? 0,
    Productdata: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "staus": staus,
    "msg": msg,
    "totalProduct": totalProduct,
    "data": List<dynamic>.from(Productdata.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
     this.quantity,
    this.watchListItemId,
    this.cartItemId,
  });

  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int? v;
  String createdAt;
  String updatedAt;
  int? quantity ;
  String? cartItemId;
  String? watchListItemId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
    v: json["__v"] ?? 0,
    createdAt: json["createdAt"] ?? '',
    updatedAt: json["updatedAt"] ?? '',
    quantity: json["quantity"] ?? 0,
    cartItemId: json["cartItemId"],
    watchListItemId: json["watchListItemId"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "__v": v,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "quantity": quantity,
    "watchListItemId": watchListItemId,
    "cartItemId": cartItemId,
  };
}
