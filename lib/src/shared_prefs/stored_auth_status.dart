import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';

class StoredAuthStatus with ChangeNotifier {
  final SharedPreferences? sharedPreferences;
  StoredAuthStatus(this.sharedPreferences){
    _getAuthStatus();
  }
  bool _authStatus = false;
  bool get authStatus=>_authStatus;
   int _navIndex=0;
  int get navIndex=>_navIndex;
  String _authNumber = '';
  String get authNumber=>_authNumber;

  void setBottomNav(int? value){
    _navIndex =value??0;
    notifyListeners();
  }
  void saveAuthStatus(bool? status,[String? number]) {
    if (status != null) {
      sharedPreferences!.setBool(AppString.auth, status);
      sharedPreferences!.setString(AppString.authNumber, number!);
    } else {
      sharedPreferences!.setBool(AppString.auth, false);
      sharedPreferences!.setString(AppString.authNumber, '');
    }
    _getAuthStatus();
  }

  void _getAuthStatus() {
    _authStatus= sharedPreferences!.getBool(AppString.auth)??false;
    _authNumber = sharedPreferences!.getString(AppString.authNumber)??'';
    notifyListeners();
  }
}
