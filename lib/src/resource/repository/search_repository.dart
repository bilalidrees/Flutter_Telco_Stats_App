import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class SearchRepository {
  static SearchRepository? _homeRepository;

  static SearchRepository? getInstance() {
    _homeRepository ??= SearchRepository();
    return _homeRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<SearchErrorState, Profile>> getSearchData(String number) async {
    try {
      final trendingNews = await remoteDataSource.getSearchData(number);
      return Right(trendingNews);
    } on ServerException {
      return Left(SearchErrorState(message: 'dumb'));
    } on Exception {
      return Left(SearchErrorState(message: 'also dumb'));
    }
  }
}
