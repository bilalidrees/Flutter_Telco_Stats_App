import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';

import 'home_detail_page.dart';

class TrendingSection extends StatelessWidget {
  final Trending trending;

  const TrendingSection({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trending.data!.length,
        separatorBuilder: (context, index) => const WidgetDivider(
              indent: 18.0,
              endIndent: 18.0,
              thickness: 2.5,
            ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeDetailPage(trending: trending, index: index)));
              },
              leading: FadeInImage.assetNetwork(
                placeholder: ImageResolver.placeHolderImage,
                image: trending.data![index].catImage!,
                height: 250,
                width: 80,
                fit: BoxFit.fitHeight,
              ),
              title: Text(
                trending.data![index].contentTitle!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black, overflow: TextOverflow.ellipsis),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trending.data![index].contentDescEn!),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      WidgetIconImage(
                        iconOne: Icons.thumb_up_off_alt,
                        like: "${trending.data![index].like ?? ""} likes",
                        share: "${trending.data![index].like ?? ""} share",
                        iconTwo: Icons.share,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
