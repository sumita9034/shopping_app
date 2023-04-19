import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../apidata/api_cart_service.dart';
import '../../provider_file/cartprovider.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  int currentIndex = 0;
  final PageController controller = PageController();
  List<String> images = [
    "assets/d1.jpg",
    "assets/d2.jpg",
    "assets/d3.jpg",
  ];
  Widget build(BuildContext context) {
    Map<String, dynamic>? argument = {};
    final cartptovider = Provider.of<Cartprovider>(context);
int index = 0 ;
    argument = ModalRoute.of(context)!.settings.arguments as Map<String , dynamic>;


    return Scaffold(
      appBar: AppBar(),
      body:

          Column(
            children:[
              Container(
              height: 300,
              width: double.infinity,
              child: Image.network(argument!['imageurl']),
          ),
              Card(
                color: Colors.transparent,
              elevation: 20,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 15),
                height: 255,
                width: double.infinity,
                // padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(argument!['title'].toString(),

                        style: GoogleFonts.hind(fontSize: 18,fontWeight: FontWeight.w600)
                        //      TextStyle(fontSize: 17,fontWeight: FontWeight.w400),
                        ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(argument!['description'].toString(),
                        style: GoogleFonts.hind(
                            fontSize: 18, ),
                    maxLines: 5,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Price: ₹${argument!['price'].toString()}",

                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          color: Colors.grey[800]),
                    )
                  ],
                ),
              ),
            ),

        ],
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
                      "Add to Cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 21,color: Colors.black87),
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
                    onPressed: () {
                      PlaceOrder(cartptovider.Item[0].data[index].cartId,
                          cartptovider.Item[0].cartTotal.toString());
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Order Placed"),
                              content:
                              Text("Your order has been placed successfully."),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      "Buy Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 21,color: Colors.black87),
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

Widget buildIndicator(bool isSelected) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 1),
    child: Container(
      height: isSelected ? 12 : 10,
      width: isSelected ? 12 : 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey.shade700),
    ),
  );
}
