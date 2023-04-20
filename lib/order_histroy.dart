import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider_file/cartprovider.dart';

import 'apidata/api_service.dart';
import 'components/navigationbar.dart';
import 'models/model_get_Order_histroy.dart';
import 'models/model_get_Order_histroy.dart';

class OrderHistroy extends StatefulWidget {
  const OrderHistroy({Key? key}) : super(key: key);

  @override
  State<OrderHistroy> createState() => _OrderHistroyState();
}

class _OrderHistroyState extends State<OrderHistroy> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
        //  title: Text("WishList(${wishProvider.Item[0].data.length})",style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottomBar()));
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),

        ),

        body: FutureBuilder(
        future: GetOrderHistroy(),
    builder: (context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    } else {
    List<DataList> datalist = snapshot.data;
    dynamic data = snapshot.data;
    // if (data is List) {
    //   datalist = data.map((e) => DataList.fromJson(e)).toList();
    // }

      //List<DataList> datalist = snapshot.data;

    return ListView.builder(itemCount:datalist.length,
        itemBuilder: (BuildContext context,int index){
      return Card(
        elevation: 4,
        child: ListTile(
          leading:  Image.network(datalist[index].imageUrl),
          title: Text(datalist[index].title),
          subtitle: Text(datalist[index].price),
        ),
      );

    });


            }
          },
        ));

  }
}
