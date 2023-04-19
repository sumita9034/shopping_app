class WatchListListClass {
  int status;
  String msg;
  double cartTotal;
  List<WatchItemData> data;

  WatchListListClass(
      {required this.status, required this.msg, required this.cartTotal,required this.data});

  factory WatchListListClass.fromJson(Map json) {
    final List<WatchItemData> dataList = [];
    if (json['data'] != null) {
      for (var data in json['data']) {
        dataList.add(WatchItemData.fromJson(data));
      }
    }
    return WatchListListClass(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        cartTotal : json['cartTotal'] != null ?json['cartTotal'].toDouble() : 0.00 ,
        data:  dataList ?? []
    );
  }
}

class WatchItemData {
  String id;
  String userId;
  String cartId;
  int quantity;
  int productCount;
  ProductAllAPIData? productDetails;

  WatchItemData(
      {required this.id,
        required this.userId,
        required this.cartId,
        required this.quantity,
        required this.productCount,
        required this.productDetails});

  factory WatchItemData.fromJson(Map json) {

    return WatchItemData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      cartId: json['cartId'] ?? '',
      quantity: json['quantity'] ?? 0,
      productCount: json['productCount'] ?? 0,
      productDetails: json['productDetails'] != null
          ? ProductAllAPIData.fromJson(json['productDetails'])
          : null,
    );
  }
}


class ProductAllAPIData {
  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int quantity;
  String cartItemId;
  String watchListItemId;

  ProductAllAPIData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.cartItemId,
    required this.watchListItemId
  });

  factory ProductAllAPIData.fromJson(Map<String, dynamic> json) {
    return ProductAllAPIData(
        id: json['_id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        price: json['price'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        quantity: json['quantity'] ?? 0,
        cartItemId: json['cartItemId'] ?? '',
        watchListItemId: json['watchListItemId'] ?? ''
    );
  }
}