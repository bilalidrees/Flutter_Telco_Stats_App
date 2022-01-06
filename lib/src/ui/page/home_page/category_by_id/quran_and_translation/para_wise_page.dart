import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_video_tile.dart';

class ParaWisePage extends StatelessWidget {
  final List<News> news;

  const ParaWisePage(this.news, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoDetailPage(
                        appBar: true, trending: news, index: index)));
          },
          child: VideoListTile(
            shares: '0',
            likes: '0',
            contentTitle: news[index].contentTitle!,
            contentSubTitle: news[index].contentCatTitle!,
            imgUrl: news[index].catImage!,
            highlight: false,
          ),
        ),
        separatorBuilder: (context, index) => const WidgetDivider(thickness: 2),
        itemCount: news.length);
  }
}