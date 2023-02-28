import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize{
  final String title;
  final Color backGroundColor;
  const CustomAppBar({
    //required Key key,
    required this.title, required this.backGroundColor,
  });
  //: super (key: key);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(45.0);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      backgroundColor: backGroundColor,
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 10,bottom: 10),
        child: Text(title,style: TextStyle(
            color: appBarTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
        ),),
      ),
      elevation: 2,
      actions: [
        IconButton(onPressed: null, icon: Icon(Icons.more_vert,color: appBarIconColor,),iconSize: 20,)
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();



}