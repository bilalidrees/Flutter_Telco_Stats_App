part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoadingState extends ProfileState {
  final bool? isVisible;

  ProfileLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class ProfileSuccessState extends ProfileState {
  bool? isSuccess;
  Profile? profle;

  ProfileSuccessState({this.isSuccess, this.profle});
}

class ProfileErrorState extends ProfileState {
  final String? message;

  ProfileErrorState({this.message});
}
