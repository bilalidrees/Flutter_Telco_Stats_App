import 'package:flutter/material.dart';

class CategoryAvatar extends StatelessWidget {
  final String imageNetworkPath;
  final String value;
  final bool isFromHompage;

  const CategoryAvatar(
      {Key? key,
      required this.value,
      required this.imageNetworkPath,
      required this.isFromHompage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(child: Image.network(imageNetworkPath), maxRadius: 30),
        const SizedBox(height: 5),
        SizedBox(
          width: isFromHompage ? 70 : 100,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.black,fontSize: 13),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
