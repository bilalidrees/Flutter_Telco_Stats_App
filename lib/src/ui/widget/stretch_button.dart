import 'package:flutter/material.dart';

class StretchButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final double vertical;
  const StretchButton({Key? key,this.text,this.onPressed,this.vertical=18}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
            style: ButtonStyle(
                shape:
                MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
            onPressed: onPressed,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: vertical),
              child: Text(
                text!,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(
                  //color: AppColor.pinkTextColor,
                    fontSize: 18,
                    color: Colors.white),
              ),
            )),
      ],
    );
  }
}
