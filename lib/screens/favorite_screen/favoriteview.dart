import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/watchlist_model.dart';

import '../../apidata/api_cart_service.dart';
import '../../components/navigationbar.dart';
import '../../models/watchlist_model.dart';

import '../../provider_file/favprovider.dart';

import '../cart_screen/cart.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {

    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    final wishProvider = Provider.of<WishlistProvider>(context);
    wishProvider.GetWatchFun();
   // final listcart = wishProvider.Item[0].data;
    return Scaffold(
        appBar: AppBar(
          title: Text("WishList(${wishProvider.Item[0].data.length})",style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottomBar()));
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),

        ),
        body: FutureBuilder(
          future: wishProvider.GetWatchFun(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: wishProvider.Item[0].data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        leading: Image.network(wishProvider
                            .Item[0].data[index].productDetails.imageUrl),
                        title: Text(wishProvider
                            .Item[0].data[index].productDetails.title),
                        subtitle: Text(wishProvider
                            .Item[0].data[index].productDetails.price),
                        trailing: IconButton(
                          onPressed: () async{
                            await wishProvider.Removewish(
                                wishProvider.Item[0].data[index].id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
