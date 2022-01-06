import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/cubit/surah_cubit/surah_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/model/surah_wise.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

class SurahRepository{
  static SurahRepository? _surahRepository;

  static SurahRepository? getInstance() {
    _surahRepository ??= SurahRepository();
    return _surahRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<SurahErrorState, List<SurahWise>>> getSurah(int surah,String lang) async {
    try {
      final surahWise = await remoteDataSource.getSurahWise(surah,lang);
      return Right(surahWise);
    } on ServerException {
      return const Left(SurahErrorState(message: ''));
    } on Exception {
      return const Left(SurahErrorState(message: ''));
    }
  }
}