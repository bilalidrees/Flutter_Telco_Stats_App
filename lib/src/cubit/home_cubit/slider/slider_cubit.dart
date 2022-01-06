import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/prayer.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/time_conversion.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> with PrayerConvertion {
  final HomeRepository homeRepository;
  SliderCubit(this.homeRepository)
      : super(const SliderInitial());

  void getSlider(String lat,String lng,String number) async {
    emit(const SliderLoadingState());
    final Either<SliderErrorState, List<CustomSlider>> slider =
        await homeRepository.getSliderImage(number);
    final Either<SliderErrorState, List<String>> timeList =
        await homeRepository.getHomepageDetails(number);
    final Either<SliderErrorState, PrayerInfo> prayerInfo =
        await homeRepository.getPrayerInfo(lat,lng,number);

    slider.fold(
      (l) => const SliderErrorState(message: 'Something Went Wrong'),
      (slide) {
        timeList.fold(
            (l) => const SliderErrorState(message: 'Something Went Wrong'),
            (date) {
          prayerInfo.fold(
            (l) => const SliderErrorState(message: 'Something Went Wrong'),
            (prayer) async {
              await prayerUpdates(prayer);
              emit(SliderSuccessState(
                  combineClass: CombineClass(
                      slider: slide,
                      prayerInfo: prayer,
                      dateList: date,
                      currentNamazTime: prayerList)));
            },
          );
        });
      },
    );
  }
}

class CombineClass {
  final List<CustomSlider> slider;
  final List<String> dateList;
  final PrayerInfo prayerInfo;
  final List<Prayer> currentNamazTime;

  const CombineClass(
      {required this.slider,
      required this.dateList,
      required this.prayerInfo,
      required this.currentNamazTime});
}
