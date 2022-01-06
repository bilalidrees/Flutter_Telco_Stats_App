import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';

class TrendingText extends StatelessWidget {
  const TrendingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text('TRENDING',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(letterSpacing: 1, color: Colors.black, fontSize: 20)),
    );
  }
}
