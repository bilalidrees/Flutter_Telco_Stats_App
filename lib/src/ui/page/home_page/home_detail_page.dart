import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';

class HomeDetailPage extends StatelessWidget {
  final Trending trending;
  final int index;

  const HomeDetailPage({Key? key, required this.trending, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoDetailPage(trending: trending.data!, index: index);
  }
}
