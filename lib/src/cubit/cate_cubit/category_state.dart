part of 'category_cubit.dart';

@immutable
abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {
  const CategoryLoadingState();
}

class CategorySuccessState extends CategoryState {
  final ContentByCateId? category;

  const CategorySuccessState({this.category});
}


class CategoryErrorState extends CategoryState {
  final String? message;

  const CategoryErrorState({this.message});
}
