import 'package:flutter/material.dart';

class WidgetIconImage extends StatelessWidget {
  final String like;
  final String share;
  final IconData iconOne;
  final IconData iconTwo;

  const WidgetIconImage(
      {Key? key,
      required this.like,
      required this.iconOne,
      required this.share,
      required this.iconTwo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Row(
        children: [
          Expanded(child: Icon(iconOne, size: 20, color: Colors.pink)),
          Expanded(
              flex: 2,
              child: Text(like,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14, color: Colors.black54))),
          Expanded(child: Icon(iconTwo, size: 20, color: Colors.pink)),
          Expanded(
              flex: 2,
              child: Text(share,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14, color: Colors.black54))),
        ],
      ),
    );
  }
}
