import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider_file/favprovider.dart';
import '../../apidata/api_cart_service.dart';
import '../cart_screen/cart.dart';
import '../../provider_file/cartprovider.dart';
import '../../apidata/api_service.dart';
import '../../provider_file/favprovider.dart';
import '../details_screen/details.dart';
import '../../models/model_api_data.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    dataAccess();
  }

  List<Datum> mainData = [];

  dataAccess() async{
    isLoading = false;
   setState(() {
     mainData =  GetProduct();
     isLoading = true;
   });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<Cartprovider>(context);
    bool isFavorite = false;
    final favProvider = Provider.of<WishlistProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: ,
      // ),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 22,
                    ),
                    onPressed: () {}),
                hintText: 'Search...',
                border: InputBorder.none),
            onChanged: (value) {},
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child:
            IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push((MaterialPageRoute(builder: (context) => Cart())));
                  }, icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 28,
                  ),
           
          ),)
        ],
      ),
      body:
         FutureBuilder(
          future: GetProduct(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Datum> datum = snapshot.data;

              return

                  //color: Colors.pinkAccent,
                  Container(
                // color: Colors.amberAccent,
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisExtent: 276,
                      mainAxisSpacing: 12.0),
                  itemCount: datum.length,
                  itemBuilder: (BuildContext context, int index) {
                    // bool isFavorite = favProvider.Item.any(
                    //     (element) => element.datum[index].id);
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(100, 22, 44, 33),
                      ),
                      //padding: EdgeInsets.only(left: 5),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/ProductDetails',
                                    arguments: {
                                      'price': datum[index].price,
                                      'imageurl': datum[index].imageUrl,
                                      'description': datum[index].description,
                                      'title': datum[index].title,
                                      'index': index,
                                    });
                              },
                              child: Column(
                                children: [
                                  Container(
                                      color: Colors.white,
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            datum[index].imageUrl,
                                            height: 160,
                                            width: double.infinity,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          Positioned(
                                              top: -3,
                                              right: -6,
                                              child: datum[index]
                                                          .watchListItemId ==
                                                      ''
                                                  ? IconButton(
                                                      onPressed: ()async {
                                                        await favProvider.AddtoWish(
                                                            datum[index].id);

                                                       // GetProduct();
                                                        print('added');
                                                      },
                                                      icon: Icon(
                                                        Icons.favorite_outline,
                                                        color: Colors.black,
                                                      ))
                                                  : IconButton(
                                                      onPressed: () {
                                                        favProvider.Removewish(
                                                            favProvider.Item[0]
                                                                .data[index].id);

                                                        print(
                                                            'already added to cart !');
                                                      },
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )))
                                        ],
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5, top: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          datum[index].title,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          datum[index].description,
                                          maxLines: 2,
                                        )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          datum[index].price,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .merge(TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24,
                                                color: Colors.grey.shade800,
                                              )),
                                        ),
                                        datum[index].quantity == 0
                                            ? IconButton(
                                                onPressed: () {
                                                  AddToCart(datum[index].id);
                                                  /* if (datum[index].id == null) {
                                                    AddToCart(datum[index].id);
                                                    GetProduct();
                                                    print('added');
                                                  } else {


                                                    print(
                                                        'already added to cart !');
                                                  }*/
                                                },
                                                icon: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.black,
                                                ))
                                            : IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.done_outline,
                                                  color: Colors.black,
                                                ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.lightBlueAccent,
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/profile.jpg'),
                        )),
                  ),
                  // Text(
                  //   "Sumita khasiya",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  Text(
                    "",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              title: Text('Home', style: TextStyle(fontSize: 18)),
              onTap: () {
                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                // Navigate to the home screen.
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
              ),
              title: Text('Profile', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ),
              title: Text(
                'Setting',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Setting()));
                // Navigate to the home screen.
              },
            ),
            ListTile(
              leading: Icon(
                Icons.history_outlined,
                color: Colors.black,
              ),
              title: Text('History', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Histroy()));
                // // Navigate to the home screen.
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_outline,
                color: Colors.black,
              ),
              title: Text('My List', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Favirot()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star_border,
                color: Colors.black,
              ),
              title: Text('Rate Us', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            ListTile(
              // leading: Icon(Icons.,color: Colors.black,),
              title: Text('Version', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Navigate to the home screen.
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              title:

              TextButton(
                   onPressed: () async {
                SharedPreferences pref =
                await SharedPreferences.getInstance();
                pref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/Login', (route) => false); }, child: Text('LogOut',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),),
                ),

                // 'LogOut',
                // style: TextStyle(
                //     color: Colors.red,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18),
              ),

          ],
        ),
      ),
    );
  }
}
