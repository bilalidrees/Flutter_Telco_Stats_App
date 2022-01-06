import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';

class CurrentDetailSection extends StatelessWidget {
  final String backGroundImage;
  final Color colorText = Colors.white;
  final List<String> date;
  final PrayerInfo prayerInfo;

  const CurrentDetailSection(
      {Key? key,
      required this.backGroundImage,
      required this.date,
      required this.prayerInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.network(backGroundImage).image, fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteString.prayer,
                  arguments: ScreenArguments(
                    buildContext: context,
                  ));
            },
            child: Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    Image.asset(
                      ImageResolver.prayerInfo,
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 5),
                    const Text('Namaz Timing',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
          Text("${date[0]}\n${date[1]} ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, color: colorText)),
          Text('duhr ' + prayerInfo.dhuhr!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 28, color: colorText)),
          const WidgetDivider(thickness: 3, endIndent: 100),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String string;
  final String value;
  final Color colorText = Colors.white;

  const _Row({Key? key, required this.string, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Row(
        children: [
          Expanded(
              child: Text(string,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18, color: colorText))),
          Expanded(
              flex: 2,
              child: Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 12, color: colorText))),
        ],
      ),
    );
  }
}
