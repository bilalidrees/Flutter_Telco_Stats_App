import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';

part 'pillar_state.dart';

class PillarCubit extends Cubit<PillarState> {
  final CategoryRepository _categoryRepository;
  PillarCubit(this._categoryRepository) : super(const PillarInitial());




  void getPillarById(String id,String number) async {
    emit(const PillarLoadingState());
    final Either<PillarErrorState, ContentByCateId> eitherResponse =
    (await _categoryRepository.getPillarById(id,number));
    emit(eitherResponse.fold(
          (l) => const PillarErrorState(message: 'Something Went Wrong'),
          (r) => PillarSuccessState(category: r),
    ));
  }
}
