part of 'city_cubit.dart';

@immutable
abstract class CityState {
  const CityState();
}

class CityInitial extends CityState {}

class CityLoadingState extends CityState {
  const CityLoadingState();
}

class CitySuccessState extends CityState {
  final List<String>? city;

  const CitySuccessState({this.city});
}

class CityErrorState extends CityState {
  final String? message;

  const CityErrorState({this.message});
}
