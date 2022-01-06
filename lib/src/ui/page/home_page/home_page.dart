import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/geo_location/geo_location.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_section.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/current_detail_section.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/widget_news_item.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/trending_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? rootWidget;

  @override
  void initState() {
    rootWidget = getMainMenuCategoryWidget();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (context.watch<GeoLocationProvider>().state == GeoLocationState.loaded) {
      var pos = context.read<GeoLocationProvider>().position;
      final number = context.read<StoredAuthStatus>().authNumber;
      BlocProvider.of<SliderCubit>(context).getSlider(pos.latitude.toString(), pos.longitude.toString(), number);
      BlocProvider.of<MainMenuCategoryCubit>(context).getMenuCategories(number);
      BlocProvider.of<MainMenuTrendingCubit>(context).getTrendingNews(number);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return rootWidget!;
  }

  Widget getMainMenuCategoryWidget() {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          BlocBuilder<SliderCubit, SliderState>(
            builder: (context, state) {
              if (state is SliderInitial) {
                return const EmptySizedBox();
              } else if (state is SliderLoadingState) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: WidgetLoading());
              } else if (state is SliderSuccessState) {
                return CurrentDetailSection(
                  prayerInfo: state.combineClass!.prayerInfo,
                  backGroundImage:
                      state.combineClass!.slider.first.sliderImage!,
                  date: state.combineClass!.dateList,
                );
              } else if (state is SliderErrorState) {
                return const ErrorText();
              } else {
                return const ErrorText();
              }
            },
          ),
       //   Container(height: 4, width: double.infinity, color: Colors.pink),
          BlocBuilder<MainMenuCategoryCubit, MainMenuCategoryState>(
            builder: (context, state) {
              if (state is InitialMainMenuCategoryState) {
                return const EmptySizedBox();
              } else if (state is MainMenuCategoryLoadingState) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: WidgetLoading());
              } else if (state is MainMenuCategorySuccessState) {
                return CategorySection(category: state.mainMenuCategoryList!);
              } else if (state is MainMenuCategoryErrorState) {
                return const ErrorText();
              } else {
                return const ErrorText();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                const Align(
                  child: TrendingText(),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Container(
                    height: 5,
                    width: 200,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MainMenuTrendingCubit, MainMenuTrendingState>(
            builder: (context, state) {
              if (state is MainMenuTrendingInitial) {
                return const EmptySizedBox();
              } else if (state is MainMenuTrendingLoadingState) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: WidgetLoading());
              } else if (state is MainMenuTrendingSuccessState) {
                return TrendingSection(trending: state.trending!);
              } else if (state is MainMenuTrendingErrorState) {
                return const ErrorText();
              } else {
                return const ErrorText();
              }
            },
          )
        ])),
      ],
    );
  }
}
