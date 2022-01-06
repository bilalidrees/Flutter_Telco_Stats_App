import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';

class VideoPreview extends StatelessWidget {
  final String imgSrc;
  final String text;

  const VideoPreview({Key? key, required this.imgSrc, required this.text})
      : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInImage.assetNetwork(
            placeholder: ImageResolver.placeHolderImage,
            image: imgSrc,
            height: 100,
            width: 95,
            fit: BoxFit.fill),
        _sizedBox,
        Text(text),
      ],
    );
  }
}
