// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.status,
    required this.msg,
    required this.histroy,
  });

  int status;
  String msg;
  List<DataList> histroy;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    status: json["status"],
    msg: json["msg"],
    histroy: List<DataList>.from(json["data"].map((x) => DataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(histroy.map((x) => x.toJson())),
  };
}

class DataList {
  DataList({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.productTotalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String userId;
  String orderId;
  String productId;
  String title;
  String description;
  String price;
  String imageUrl;
  int quantity;
  String productTotalAmount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    id: json["_id"],
    userId: json["userId"],
    orderId: json["orderId"],
    productId: json["productId"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    quantity: json["quantity"],
    productTotalAmount: json["productTotalAmount"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "orderId": orderId,
    "productId": productId,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "quantity": quantity,
    "productTotalAmount": productTotalAmount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
