import 'dart:convert';

    
class Mydata {

  String img;
  String title;
 int price;
  bool? isSelected = false;
  late int itemCount=0;
  //int count;

  Mydata(
      {
        required this.img,
        required this.price,
        required this.title,
        this.isSelected,
      });
}

