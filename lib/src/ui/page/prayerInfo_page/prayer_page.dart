import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PrayerInfoPage extends StatefulWidget {
  const PrayerInfoPage({Key? key}) : super(key: key);

  @override
  State<PrayerInfoPage> createState() => _PrayerInfoPageState();
}

class _PrayerInfoPageState extends State<PrayerInfoPage> {
  @override
  void initState() {
    print(BlocProvider.of<SliderCubit>(context).prayerList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return const _PrayerInfo();
  }
}

class _PrayerInfo extends StatelessWidget {
  const _PrayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(
        title: 'Namaz Timing',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color(0xffCC0E74), width: 2)),
            child: Text('Dhikr',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),),
          ),
          Row(
            children: [
              Expanded(child: Image.asset(ImageResolver.mosqueImage)),
              Expanded(
                  child: RichText(
                text: TextSpan(
                    text: '${BlocProvider.of<SliderCubit>(context).nowText}\n',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22, fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text:
                            '${BlocProvider.of<SliderCubit>(context).nextText}\n',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w300),
                      ),
                      TextSpan(
                        text: BlocProvider.of<SliderCubit>(context).currentTime,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w300),
                      ),
                    ]),
              )),
            ],
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            child: Text(
              '17 Rabi ul Awwal 1443 AH\nOct 2020',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColor.whiteTextColor),
              textAlign: TextAlign.center,
            ),
            decoration: const BoxDecoration(color: AppColor.darkPink),
          ),
          Column(
            children: BlocProvider.of<SliderCubit>(context)
                .prayerList
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            gradient: e.isCurrentNamaz
                                ? const LinearGradient(stops: [
                                    0.05,
                                    1
                                  ], colors: [
                                    AppColor.lightPink,
                                    AppColor.whiteTextColor
                                  ])
                                : null),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.namazName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                            ),
                            Text(
                              e.namazTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
