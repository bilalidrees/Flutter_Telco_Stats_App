part of 'pillar_cubit.dart';

@immutable
abstract class PillarState {
  const PillarState();
}

class PillarInitial extends PillarState {
  const PillarInitial();
}


class PillarLoadingState extends PillarState {
  const PillarLoadingState();
}

class PillarSuccessState extends PillarState {
  final ContentByCateId? category;

  const PillarSuccessState({this.category});
}


class PillarErrorState extends PillarState {
  final String? message;

  const PillarErrorState({this.message});
}
