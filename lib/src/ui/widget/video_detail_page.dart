import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_video_tile.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final List<News> trending;
  final int index;
  final bool appBar;

  const VideoDetailPage(
      {Key? key,
      required this.trending,
      required this.index,
      this.appBar = true})
      : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late final YoutubePlayerController controller;
  late int currentIndex;
  bool? isMp4;
  String? video;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    currentIndex = widget.index;
    isMp4 = widget.trending[widget.index].catVideo!.endsWith(".mp4");
    if (isMp4!) {
      video = widget.trending[widget.index].catVideo!;
    } else {
      controller = YoutubePlayerController(
          initialVideoId: YoutubePlayerController.convertUrlToId(
              widget.trending[widget.index].catVideo!)!);
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar
          ? WidgetAppBar(
              title: widget.trending[currentIndex].contentCatTitle!,
            )
          : null,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: isMp4!
                ? BetterPlayer.network(
                    video!,
                    betterPlayerConfiguration: const BetterPlayerConfiguration(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                    ),
                  )
                : YoutubeAppDemo(
                    videoUrl: widget.trending[widget.index].catVideo!,
                    controller: controller,
                  ),
          ),
          Container(
            color: Colors.grey[400],
            height: 80,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.trending[currentIndex].contentTitle!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 20,overflow: TextOverflow.ellipsis)),
                SizedBox(height: 5),
                Text(widget.trending[currentIndex].contentCatTitle!),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Text('YouTube Credits: ITGN',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const WidgetDivider(thickness: 2),
                itemBuilder: (context, index) => GestureDetector(
                      onTap: isMp4!
                          ? () {
                              setState(() {
                                currentIndex = index;
                                video = widget.trending[index].catVideo!;
                              });
                            }
                          : () {
                              setState(() {
                                currentIndex = index;
                                controller.load(
                                    YoutubePlayerController.convertUrlToId(
                                        widget.trending[index].catVideo!)!);
                              });
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: VideoListTile(
                            highlight: currentIndex == index,
                            contentSubTitle:
                                widget.trending[index].contentCatTitle!,
                            contentTitle: widget.trending[index].contentTitle!,
                            likes: '0',
                            shares: '1',
                            imgUrl: widget.trending[index].catImage!),
                      ),
                    ),
                itemCount: widget.trending.length),
          )
        ]),
      ),
    );
  }
}

class YoutubeAppDemo extends StatefulWidget {
  final String videoUrl;
  final YoutubePlayerController controller;

  const YoutubeAppDemo(
      {Key? key, required this.videoUrl, required this.controller})
      : super(key: key);

  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  String? video;

  @override
  void initState() {
    super.initState();
    video = YoutubePlayerController.convertUrlToId(widget.videoUrl)!;
    widget.controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      print('Entered Fullscreen');
    };
    widget.controller.onExitFullscreen = () {
      print('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: widget.controller,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: player),
                ],
              );
            }
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    player,
                    Positioned.fill(
                      child: YoutubeValueBuilder(
                        controller: widget.controller,
                        builder: (context, value) {
                          return AnimatedCrossFade(
                            firstChild: const SizedBox.shrink(),
                            secondChild: Material(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      YoutubePlayerController.getThumbnail(
                                        videoId: video!,
                                        quality: ThumbnailQuality.medium,
                                      ),
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            crossFadeState: value.isReady
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.close();
    super.dispose();
  }
}
