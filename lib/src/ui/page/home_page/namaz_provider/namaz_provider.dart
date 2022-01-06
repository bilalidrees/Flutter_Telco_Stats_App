import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';

class NamazData {
  final SharedPreferences? sharedPreferences;

  NamazData(this.sharedPreferences);

  int counter = 0;

  setNamazCount(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentValue = await getNamazCount(key);
    currentValue = currentValue + 1;
    prefs.setInt(key, currentValue);
  }

  int getNamazCount(String key) {
    counter = (sharedPreferences!.getInt(key) ?? 0);
    return counter;
  }

  int getTotalMissed(String key) {
    int totalmissed = 0;
    AppUtility.totalNamazCount.forEach((key, value) {
      totalmissed = getNamazCount(value) + totalmissed;
    });
    sharedPreferences!.setInt(key, totalmissed);
    return totalmissed;
  }

  setNamazRowClick(String key, bool status) {
    sharedPreferences!.setBool(key, status);
  }

  bool getNamazRowClick(String key) {
    return sharedPreferences!.getBool(key) ?? false;
  }
}
