import 'package:flutter/material.dart';

class ScreenArguments<T> {
  final int? tab;
  final Widget? currentPage;
  final String? message;
  final bool? flag;
  final T? data;
  final T? secondData;
  final BuildContext? buildContext;

  ScreenArguments(
      {this.tab,
        this.currentPage,
        this.message,
        this.data,
        this.secondData,
        this.flag,
        this.buildContext});
}