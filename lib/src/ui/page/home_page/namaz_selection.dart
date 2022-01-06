import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/namaz_provider/namaz_provider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/namaz_missed_row.dart';

class NamazRow extends StatefulWidget {
  String namaz;
  int index;


  ValueChanged<int>? callback;

  NamazRow(
      {Key? key,
      required this.namaz,
      required this.index,
      required this.callback})
      : super(key: key);

  @override
  State<NamazRow> createState() => _NamazRowState();
}

class _NamazRowState extends State<NamazRow> {
  int _radioValue = 0;

  // void handleRadioValueChange(int? value) async{
  //   setState(() {
  //     //next otherwise previous
  //     _radioValue = value?? _radioValue;
  //     switch (_radioValue) {
  //       case 0:
  //         print(_radioValue);
  //         break;
  //       case 1:

  //         print(_radioValue);
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: 110,
        height: 60,
        color: AppColor.darkPink,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.namaz,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )),
      ),
      Container(
        height: 60,
        width: 500,
        margin: const EdgeInsets.only(left: 95),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.red,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Offered',
                  style: TextStyle(fontSize: 17.0),
                ),
                Expanded(
                  child: Radio(
                    value: 0,
                    // groupValue: provider.radioValue,
                    groupValue:AppUtility.namazTrackerMap[widget.index],
                    // onChanged: provider.handleRadioValueChange,

                    onChanged: (value) {
                      widget.callback!(value as int);
                      setState(() {
                        AppUtility.namazTrackerMap[widget.index] = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(width: 80),
            Column(
              children: [
                const Text(
                  'Not Offered',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                Expanded(
                  child: Radio(
                    value: 1,
                    // groupValue: provider.radioValue,
                    groupValue: AppUtility.namazTrackerMap[widget.index],
                    // onChanged: provider.handleRadioValueChange,
                    onChanged: (value) {
                      widget.callback!(value as int);
                      setState(() {
                        AppUtility.namazTrackerMap[widget.index] = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
