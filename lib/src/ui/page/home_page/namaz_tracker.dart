import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/namaz_provider/namaz_provider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/namaz_missed_row.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

import 'Calender/calendar_carousel.dart';
import 'namaz_selection.dart';

class NamazTracker extends StatefulWidget {
  const NamazTracker({Key? key}) : super(key: key);

  @override
  _NamazTrackerState createState() => _NamazTrackerState();
}

class _NamazTrackerState extends State<NamazTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(title: 'Nazmaz Tracker'),
      body: SafeArea(
        child: Column(children: [
          Container(
            color: AppColor.darkPurple,
            height: 115,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Text(
                      'Total '
                      '10',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      alignment: Alignment.topRight,
                      height: 45,
                      color: AppColor.darkPink,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Fajar',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Zohar',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Asr',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Magrib',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Isha',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ]),
                    ),
                  ),
                ]),
                NamazMissed(),
              ],
            ),
          ),
          //calender
          const Calender(),
          const SizedBox(height: 10),

          NamazRow(
            namaz: "Fajar",
            index: 0,
            callback: (int value) async {
              if (value == 1) {
                bool status = context.read<NamazData>().getNamazRowClick(
                    "${AppString.fajar}${DateTime.now().day}");
                if (!status) {
                  await context
                      .read<NamazData>()
                      .setNamazCount(AppString.fajar);
                  setState(() {});
                  context.read<NamazData>().setNamazRowClick(
                      "${AppString.fajar}${DateTime.now().day}", true);

                }

              }
            },
          ),
          const SizedBox(height: 10),
          NamazRow(
              namaz: "Zuhar",
              index: 1,
              callback: (int value) async {
                if (value == 1) {
                  bool status = context.read<NamazData>().getNamazRowClick(
                      "${AppString.zohar}${DateTime.now().day}");
                  if (!status) {
                    context.read<NamazData>().setNamazRowClick(
                        "${AppString.zohar}${DateTime.now().day}", true);
                    await context
                        .read<NamazData>()
                        .setNamazCount(AppString.zohar);
                    setState(() {});
                  }
                }
              }),

          const SizedBox(height: 10),
          NamazRow(
            namaz: "Asr",
            index: 2,
            callback: (int value) async {
              if (value == 1) {
                bool status = context
                    .read<NamazData>()
                    .getNamazRowClick("${AppString.asr}${DateTime.now().day}");
                print(status);
                if (!status) {
                  context.read<NamazData>().setNamazRowClick(
                      "${AppString.asr}${DateTime.now().day}", true);
                  await context
                      .read<NamazData>()
                      .setNamazCount(AppString.asr);
                  setState(() {});
                }
              }
            },
          ),
          const SizedBox(height: 10),
          NamazRow(
            namaz: "Magrib",
            index: 3,
            callback: (int value) async {
              if (value == 1) {
                bool status = context.read<NamazData>().getNamazRowClick(
                    "${AppString.magrib}${DateTime.now().day}");
                print(status);
                if (!status) {
                  context.read<NamazData>().setNamazRowClick(
                      "${AppString.magrib}${DateTime.now().day}", true);
                  await context
                      .read<NamazData>()
                      .setNamazCount(AppString.magrib);
                  setState(() {});
                }
              }
            },
          ),
          const SizedBox(height: 10),
          NamazRow(
            namaz: "Isha",
            index: 4,
            callback: (int value) async {
              if (value == 1) {
                bool status = context
                    .read<NamazData>()
                    .getNamazRowClick("${AppString.isha}${DateTime.now().day}");
                print(status);
                if (!status) {
                  context.read<NamazData>().setNamazRowClick(
                      "${AppString.isha}${DateTime.now().day}", true);
                  await context
                      .read<NamazData>()
                      .setNamazCount(AppString.isha);
                  setState(() {});
                }
              }
            },
          ),

//Radio
        ]),
      ),
    );
  }
}
