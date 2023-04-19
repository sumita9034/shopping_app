import 'package:flutter/material.dart';
import 'package:shopping_app/screens/home_screen/home_appbar.dart';
class ListofItem extends StatefulWidget {
  const ListofItem({Key? key}) : super(key: key);

  @override
  State<ListofItem> createState() => _ListofItemState();
}

class _ListofItemState extends State<ListofItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppbar(),
          Container(height: double.infinity,)

        ],
      ),
    );
  }
}
