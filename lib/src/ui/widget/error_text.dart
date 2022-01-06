import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(AppString.errorMessage);
  }
}
