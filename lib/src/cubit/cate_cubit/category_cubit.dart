import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:dartz/dartz.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  void getCategoryById(String id,String number) async {
    emit(const CategoryLoadingState());
    final Either<CategoryErrorState, ContentByCateId> eitherResponse =
    await categoryRepository.getCategoryById(id,number);
    emit(eitherResponse.fold(
          (l) => const CategoryErrorState(message: 'Something Went Wrong'),
          (r) => CategorySuccessState(category: r),
    ));
  }


}
