import 'package:flutter/material.dart';

class WidgetDivider extends StatelessWidget {
  final double? height, thickness, indent, endIndent;

  const WidgetDivider(
      {Key? key, this.height, this.thickness, this.indent, this.endIndent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.pink[700],
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
