import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/stretch_button.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

import '../../../route_generator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static final TextEditingController _controller =
      TextEditingController(text: "92")
        ..addListener(() {
          if (!_controller.text.startsWith("92")) {
            _controller.value = _controller.value.copyWith(text: "92");
            _controller.selection =
                TextSelection.fromPosition(const TextPosition(offset: 2));
          }
        });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _checkBox = false;

  void _onchange(bool? value) {
    setState(() {
      _checkBox = value!;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.signIn,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColor.pinkTextColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10),
                Text(
                  AppString.mobileNumber,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      //color: AppColor.pinkTextColor,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length < 12 || value.isEmpty) {
                        return 'Please enter correct number';
                      }
                      return null;
                    },
                    maxLength: 12,
                    controller: SignInPage._controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        fillColor: Colors.white70),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(value: _checkBox, onChanged: _onchange),
                    const SizedBox(width: 10),
                    RichText(
                        text: TextSpan(
                      text: "${AppString.agree} ",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w300),
                      children: [
                        TextSpan(
                          text: AppString.term,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.red,
                                    letterSpacing: 2,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(height: 15),
                StretchButton(
                  onPressed: _checkBox
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .getLogin(SignInPage._controller.value.text);
                          }
                        }
                      : null,
                  text: AppString.next,
                ),
                const SizedBox(height: 15),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      Navigator.pushReplacementNamed(context, RouteString.otp,
                          arguments: ScreenArguments(
                              message: SignInPage._controller.value.text));
                      //context.read<StoredAuthStatus>().setOtpStatus(true);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginInitial) {
                      return const EmptySizedBox();
                    } else if (state is LoginLoadingState) {
                      return const WidgetLoading();
                    } else if (state is LoginSuccessState) {
                      return const SizedBox.shrink();
                    } else if (state is LoginErrorState) {
                      return const ErrorText();
                    } else {
                      return const ErrorText();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
