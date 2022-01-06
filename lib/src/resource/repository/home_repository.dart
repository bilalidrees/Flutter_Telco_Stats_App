import 'package:http/http.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class HomeRepository {
  static HomeRepository? _homeRepository;

  static HomeRepository? getInstance() {
    _homeRepository ??= HomeRepository();
    return _homeRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<MainMenuCategoryErrorState, List<MainMenuCategory>>>
      getMenuCategories(String number) async {
    try {
      final menuCategories = await remoteDataSource.getMainMenuCategory(number);
      return Right(menuCategories);
    } on ServerException {
      return Left(MainMenuCategoryErrorState(message: ''));
    } on Exception {
      return Left(MainMenuCategoryErrorState(message: ''));
    }
  }

  Future<Either<MainMenuTrendingErrorState, Trending>> getTrendingNews(String number) async {
    try {
      final trendingNews = await remoteDataSource.getTrendingNews(number);
      return Right(trendingNews);
    } on ServerException {
      return Left(MainMenuTrendingErrorState(message: ''));
    } on Exception {
      return Left(MainMenuTrendingErrorState(message: ''));
    }
  }

  Future<Either<SliderErrorState, List<CustomSlider>>> getSliderImage(String number) async {
    try {
      final List<CustomSlider> menuCategories = await remoteDataSource.getSliderImage(number);
      return Right(menuCategories);
    } on ServerException {
      return const Left(SliderErrorState(message: ''));
    } on Exception {
      return const Left(SliderErrorState(message: ''));
    }
  }

  Future<Either<SliderErrorState, List<String>>> getHomepageDetails(String number)async{
    try {
      final List<String> date = await remoteDataSource.getHomepageDetails(number);
      return Right(date);
    } on ServerException {
      return const Left(SliderErrorState(message: ''));
    } on Exception {
      return const Left(SliderErrorState(message: ''));
    }
  }
  Future<Either<SliderErrorState,PrayerInfo>> getPrayerInfo(String lat,String lng,String number)async{
    try{
      final PrayerInfo date = await remoteDataSource.getPrayer(lat,lng,number);
      return Right(date);
    } on ServerException{
      return const Left(SliderErrorState(message: ''));
    } on Exception{
      return const Left(SliderErrorState(message: ''));
    }
  }

}
