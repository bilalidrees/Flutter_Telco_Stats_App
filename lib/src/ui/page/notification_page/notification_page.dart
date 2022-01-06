import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<StoredAuthStatus>(context).authStatus) {
      BlocProvider.of<NotificationCubit>(context)
          .getNotifications(context.read<StoredAuthStatus>().authNumber);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationInitial) {
          return const EmptySizedBox();
        } else if (state is NotificationLoadingState) {
          return const Center(child: WidgetLoading());
        } else if (state is NotificationSuccessState) {
          return _NotificationPage(notification: state.notificationList!);
        } else if (state is NotificationErrorState) {
          return const Center(child: ErrorText());
        } else {
          return const Center(child: ErrorText());
        }
      },
    );
  }
}

class _NotificationPage extends StatelessWidget {
  final List<Notifications> notification;

  const _NotificationPage({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
              title: Text(notification[index].title!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text(notification[index].ago!)],
              ),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(notification[index].image!),
                backgroundColor: AppColor.darkPink,
              ),
            ),
        separatorBuilder: (context, index) =>
            const Divider(color: AppColor.pinkTextColor),
        itemCount: 5);
  }
}
