part of 'quran_cubit.dart';

@immutable
abstract class QuranState {
  const QuranState();
}

class QuranInitial extends QuranState {
  const QuranInitial();
}

class QuranLoadingState extends QuranState {
  const QuranLoadingState();
}

class QuranSuccessState extends QuranState {
  final ContentByCateId? category;

  const QuranSuccessState({this.category});
}

class QuranErrorState extends QuranState {
  final String? message;

  const QuranErrorState({this.message});
}
