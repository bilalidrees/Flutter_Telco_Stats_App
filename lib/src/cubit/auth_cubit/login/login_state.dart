part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{
  final String? string;
  LoginSuccessState({this.string});
}

class LoginErrorState extends LoginState{
  final String? message;

  LoginErrorState({this.message});
}
