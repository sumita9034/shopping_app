import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(25),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.sort,size: 30,color: Colors.black87,),
            Padding(padding: EdgeInsets.only(left: 20),
            child: Text("Sk Shop",
        style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,
        color: Color(0xFF4C53A5),
        ),
            ),
            ),
            Spacer(),
            badge.Badge(
            //  badgeContent: Text(
            //    "3",
            //    style: TextStyle(color: Colors.white),
            //  ),
            //
            //
            //   child: InkWell(
            //     onTap: (){},
            //     child: Icon(Icons.shopping_bag_outlined,size: 35,),
            //   ),
              )

          ],
        ),
      ),
    );
    
  }
}
