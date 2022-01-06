import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';

part 'main_menu_trending_state.dart';

class MainMenuTrendingCubit extends Cubit<MainMenuTrendingState> {
  final HomeRepository homeRepository;

  MainMenuTrendingCubit(this.homeRepository) : super(MainMenuTrendingInitial());

  void getTrendingNews(String number) async {
    emit(MainMenuTrendingLoadingState());
    final Either<MainMenuTrendingErrorState, Trending> eitherResponse =
        await homeRepository.getTrendingNews(number);
    emit(eitherResponse.fold(
      (l) => MainMenuTrendingErrorState(message: 'Something Went Wrong'),
      (r) => MainMenuTrendingSuccessState(trending: r),
    ));
  }
}
