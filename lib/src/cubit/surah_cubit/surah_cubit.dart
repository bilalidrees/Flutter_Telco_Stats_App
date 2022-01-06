import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/surah_wise.dart';
import 'package:zong_islamic_web_app/src/resource/repository/surah_repository.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  final SurahRepository _surahRepository;

  SurahCubit(this._surahRepository) : super(const SurahInitial());

  Future<void> getSurahByIdAndLang(int surah) async {
    emit(const SurahLoadingState());
    final Either<SurahErrorState, List<SurahWise>> eitherResponse =
        await _surahRepository.getSurah(surah, "ar");
    final Either<SurahErrorState, List<SurahWise>> eitherResponse2 =
        await _surahRepository.getSurah(surah, "ur");
    eitherResponse
        .fold((l) => const SurahErrorState(message: 'Something Went Wrong'),
            (arbiList) {
      emit(eitherResponse2.fold(
          (l) => const SurahErrorState(message: 'Something Went Wrong'),
          (urduList) =>
              SurahSuccessState(arbiSurah: arbiList, urduSurah: urduList)));
    });
  }
}
