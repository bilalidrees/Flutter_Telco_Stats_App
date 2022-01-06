part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {
  final bool? isVisible;

  NotificationLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class NotificationSuccessState extends NotificationState {
  bool? isSuccess;
  List<Notifications>? notificationList;

  NotificationSuccessState({this.isSuccess, this.notificationList});
}

class NotificationErrorState extends NotificationState {
  final String? message;

  NotificationErrorState({this.message});
}
