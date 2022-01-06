part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {
  final bool? isVisible;

  SearchLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class SearchSuccessState extends SearchState {
  bool? isSuccess;
  Profile? profle;

  SearchSuccessState({this.isSuccess, this.profle});
}

class SearchErrorState extends SearchState {
  final String? message;

  SearchErrorState({this.message});
}
