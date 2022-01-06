import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final CategoryRepository _categoryRepository;
  QuranCubit(this._categoryRepository) : super(const QuranInitial());


  void getQuranTranslationById(String id,String number) async {
    emit(const QuranLoadingState());
    final Either<QuranErrorState, ContentByCateId> eitherResponse =
    (await _categoryRepository.getQAndTById(id,number));
    emit(eitherResponse.fold(
          (l) => const QuranErrorState(message: 'Something Went Wrong'),
          (r) => QuranSuccessState(category: r),
    ));
  }
}
