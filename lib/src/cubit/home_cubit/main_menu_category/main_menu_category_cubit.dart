import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';

part 'main_menu_category_state.dart';

class MainMenuCategoryCubit extends Cubit<MainMenuCategoryState> {
  final HomeRepository homeRepository;

  MainMenuCategoryCubit(this.homeRepository)
      : super(InitialMainMenuCategoryState());

  void getMenuCategories(String number) async {
    emit(MainMenuCategoryLoadingState());
    final Either<MainMenuCategoryErrorState, List<MainMenuCategory>>
        eitherResponse = await homeRepository.getMenuCategories(number);
    emit(eitherResponse.fold(
      (l) => MainMenuCategoryErrorState(message: 'Something Went Wrong'),
      (r) => MainMenuCategorySuccessState(mainMenuCategoryList: r),
    ));
  }
}
