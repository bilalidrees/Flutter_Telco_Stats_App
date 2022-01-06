part of 'main_menu_trending_cubit.dart';

@immutable
abstract class MainMenuTrendingState {}

class MainMenuTrendingInitial extends MainMenuTrendingState {}

class MainMenuTrendingLoadingState extends MainMenuTrendingState {
  final bool? isVisible;

  MainMenuTrendingLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class MainMenuTrendingSuccessState extends MainMenuTrendingState {
  bool? isSuccess;
  Trending? trending;

  MainMenuTrendingSuccessState({this.isSuccess, this.trending});
}

class MainMenuTrendingErrorState extends MainMenuTrendingState {
  final String? message;

  MainMenuTrendingErrorState({this.message});
}
