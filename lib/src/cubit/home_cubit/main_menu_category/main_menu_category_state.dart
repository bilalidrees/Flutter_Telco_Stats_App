part of 'main_menu_category_cubit.dart';

@immutable
abstract class MainMenuCategoryState {}

class InitialMainMenuCategoryState extends MainMenuCategoryState {
  InitialMainMenuCategoryState();
}

class MainMenuCategoryLoadingState extends MainMenuCategoryState {
  final bool? isVisible;

  MainMenuCategoryLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class MainMenuCategorySuccessState extends MainMenuCategoryState {
  bool? isSuccess;
  List<MainMenuCategory>? mainMenuCategoryList;

  MainMenuCategorySuccessState({this.isSuccess, this.mainMenuCategoryList});
}

class MainMenuCategoryErrorState extends MainMenuCategoryState {
  final String? message;

  MainMenuCategoryErrorState({this.message});
}
