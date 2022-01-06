import 'package:http/http.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class NotificationRepository {
  static NotificationRepository? _homeRepository;

  static NotificationRepository? getInstance() {
    _homeRepository ??= NotificationRepository();
    return _homeRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<NotificationErrorState, List<Notifications>>>
  getNotifications(String number) async {
    try {
      final menuCategories = await remoteDataSource.getNotifications(number);
      return Right(menuCategories);
    } on ServerException {
      return Left(NotificationErrorState(message: 'dumb'));
    } on Exception {
      return Left(NotificationErrorState(message: 'also dumb'));
    }
  }

}
