part of 'surah_cubit.dart';

@immutable
abstract class SurahState {
  const SurahState();
}

class SurahInitial extends SurahState {
  const SurahInitial();
}

class SurahLoadingState extends SurahState {
  const SurahLoadingState();
}

class SurahSuccessState extends SurahState {
  final List<SurahWise> arbiSurah;
  final List<SurahWise> urduSurah;

  const SurahSuccessState({required this.arbiSurah, required this.urduSurah});
}

class SurahErrorState extends SurahState {
  final String message;

  const SurahErrorState({required this.message});
}
