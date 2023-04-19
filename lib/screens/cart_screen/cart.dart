import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/model_api_data.dart';

import '../../apidata/api_cart_service.dart';
import '../../components/navigationbar.dart';

import '../../provider_file/cartprovider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  String count1 = '';
  String totalPrice = '0.0';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataAccess(context);
  }


  dataAccess(BuildContext context) async{
    final cartView = Provider.of<Cartprovider>(context,listen: false);
   await cartView.GetCart();
    setState(() {
      count1 = cartView.Item[0].data.length.toString();
      totalPrice = cartView.Item[0].cartTotal.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartView = Provider.of<Cartprovider>(context);
    //cartView.GetCart();
   // final listcart = cartView.Item[0].data;
  //  int index = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart(${count1})",
            textAlign: TextAlign.center),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomBar()));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: FutureBuilder(
        future: cartView.GetCart(),
        builder: (context, snapshot) {
          return cartView.Item.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset('assets/lap.jpg'),
                      )
                    ],
                  ),
                )
              :
              // if (!snapshot.hasData) {
              // return const Center(
              //   child: Image.asset(image: )
              //
              // );
              // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //   // Show an image if the item list is empty
              //   return Center(
              //     child: Image.asset('assets/lap.jpg'),
              //   );
              // }
              // else{
              ListView.builder(
                  itemCount: cartView.Item[0].data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 7,
                      child: ListTile(
                        leading: Image.network(cartView
                            .Item[0].data[index].productDetails!.imageUrl),
                        title: Text(
                          cartView.Item[0].data[index].productDetails!.title,
                          maxLines: 1,
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartView
                                    .Item[0].data[index].productDetails!.price,
                                style: TextStyle(fontSize: 30),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async{
                                      String printId =
                                         await cartView.Item[0].data[index].id;
                                      await cartView.IncreaseCartItem(printId);
                                      print('printId: $printId');
                                      dataAccess(context);

                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      size: 29,
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      cartView.Item[0].data[index].quantity
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async{
                                     await cartView.DecreaseItem(
                                          cartView.Item[0].data[index].id);
                                     dataAccess(context);
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      size: 29,
                                    ),
                                  )
                                ],
                              ),
                            ]),
                        trailing: IconButton(
                          onPressed: ()async {
                           await cartView.RemoveFromCart(
                                cartView.Item[0].data[index].id);
                           dataAccess(context);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: Card(
        elevation: 10,
        child: Row(
          children: [
            Container(
              //color:Colors.lightBlue,
              //  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 60,
              // color: Colors.blue[200],
              child: ElevatedButton(
                onPressed: () {
                  PlaceOrder(cartView.Item[0].data[0].cartId,
                      cartView.Item[0].cartTotal.toString());
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
                  "Place order now",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Text(
              "Total Price : ${totalPrice} ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            //   Text( cartView.Item[0].data.quantity.toString(
          ],
        ),
      ),
    );
  }
}
