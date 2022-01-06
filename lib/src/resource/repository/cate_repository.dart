import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/sub_category/pillar_of_islam_cubit/pillar_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/sub_category/quran_translation_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class CategoryRepository {
  static CategoryRepository? _categoryRepository;

  static CategoryRepository? getInstance() {
    _categoryRepository ??= CategoryRepository();
    return _categoryRepository;
  }

  final _remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<CategoryErrorState, ContentByCateId>> getCategoryById(
      String id,String number) async {
    try {
      final menuCategories = await _remoteDataSource.getCategoryById(id,number);
      return Right(menuCategories);
    } on ServerException {
      return const Left(CategoryErrorState(message: 'Something Went Wrong'));
    } on Exception {
      return const Left(CategoryErrorState(message: 'Something Went Wrong'));
    }
  }

  Future<Either<PillarErrorState, ContentByCateId>> getPillarById(
      String id,String number) async {
    try {
      final menuCategories = await _remoteDataSource.getCategoryById(id,number);
      return Right(menuCategories);
    } on ServerException {
      return const Left(PillarErrorState(message: 'Something Went Wrong'));
    } on Exception {
      return const Left(PillarErrorState(message: 'Something Went Wrong'));
    }
  }

  Future<Either<QuranErrorState, ContentByCateId>> getQAndTById(
      String id,String number) async {
    try {
      final menuCategories = await _remoteDataSource.getCategoryById(id,number);
      print(menuCategories.vod.toString());
      return Right(menuCategories);
    } on ServerException {
      return const Left(QuranErrorState(message: 'Something Went Wrong'));
    } on Exception {
      return const Left(QuranErrorState(message: 'Something Went Wrong'));
    }
  }
}
