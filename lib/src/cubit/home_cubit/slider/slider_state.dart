

part of 'slider_cubit.dart';

@immutable
abstract class SliderState {
  const SliderState();
}

class SliderInitial extends SliderState {
  const SliderInitial();
}

class SliderLoadingState extends SliderState {
  final bool? isVisible;

  const SliderLoadingState({this.isVisible});
}

class SliderSuccessState extends SliderState {
  final CombineClass? combineClass;
  const SliderSuccessState({this.combineClass});
}
class CombineSuccessState extends SliderState {
  final CombineClass combineClass;
  const CombineSuccessState({required this.combineClass});
}

class SliderErrorState extends SliderState {
  final String? message;

  const SliderErrorState({this.message});
}
