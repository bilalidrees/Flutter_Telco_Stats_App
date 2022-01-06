import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';
class VideoListTile extends StatelessWidget {
  final String imgUrl;
  final String contentTitle;
  final String contentSubTitle;
  final String likes;
  final String shares;
  final bool highlight;

  const VideoListTile(
      {Key? key,
        this.highlight= false,
        required this.imgUrl,
        required this.contentTitle,
        required this.contentSubTitle,
        required this.likes,
        required this.shares})
      : super(key: key);
  final SizedBox _sizeBox = const SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: highlight?Colors.orange[50]:null,
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 90,
            child: FadeInImage(
                fit: BoxFit.fill,
                placeholder: const AssetImage(ImageResolver.placeHolderImage),
                image: NetworkImage(imgUrl)),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Text(contentTitle,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16, overflow: TextOverflow.ellipsis)),
              ),
              _sizeBox,
              Text(contentSubTitle,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(overflow: TextOverflow.ellipsis)),
              _sizeBox,
              Row(
                children: [
                  WidgetIconImage(
                    iconOne: Icons.thumb_up_off_alt,
                    like: "$likes likes",
                    share: "$shares share",
                    iconTwo: Icons.share,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}