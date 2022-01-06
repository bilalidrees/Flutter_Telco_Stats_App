import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/namaz_provider/namaz_provider.dart';

class NamazMissed extends StatelessWidget {
  const NamazMissed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        textrow(context
            .read<NamazData>()
            .getTotalMissed(AppString.total)
            .toString()),
        const SizedBox(width: 5),
        textrow(
           context.read<NamazData>().getNamazCount(AppString.fajar).toString()
          ),
        const SizedBox(width: 5),
        textrow(
            context.read<NamazData>().getNamazCount(AppString.zohar).toString()
        ),
        const SizedBox(width: 5),
        textrow(
            context.read<NamazData>().getNamazCount(AppString.asr).toString()
        ),
        const SizedBox(width: 5),
        textrow(
            context.read<NamazData>().getNamazCount(AppString.magrib).toString()
        ),
        const SizedBox(width: 5),
        textrow(
            context.read<NamazData>().getNamazCount(AppString.isha).toString()
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}

class textrow extends StatelessWidget {
  final String text;

  const textrow(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: const TextStyle(color: Colors.white),
    );
  }
}
