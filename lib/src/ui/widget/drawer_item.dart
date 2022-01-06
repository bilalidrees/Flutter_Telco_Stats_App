import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  String text;

  DrawerItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Padding(
          padding: EdgeInsets.only(left: 28.0, top: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10,right: 10),
          child: Divider(
            height: 5,
            color: Colors.pinkAccent,
          ),
        ),
      ],
    );

  }
}
