import 'package:flutter/material.dart';

class EmptySizedBox extends StatelessWidget {
  const EmptySizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
