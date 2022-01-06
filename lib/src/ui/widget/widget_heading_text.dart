import 'package:flutter/material.dart';

class WidgetHeadingText extends StatelessWidget {
  final String text;

  const WidgetHeadingText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18,overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
