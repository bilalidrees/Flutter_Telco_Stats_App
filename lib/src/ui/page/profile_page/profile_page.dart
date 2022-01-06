import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/main_page/main_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_review_container.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_category_avatar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<StoredAuthStatus>(context).authStatus) {
      BlocProvider.of<ProfileCubit>(context).getProfileData(context.read<StoredAuthStatus>().authNumber);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return const EmptySizedBox();
        } else if (state is ProfileLoadingState) {
          return const Center(child: WidgetLoading());
        } else if (state is ProfileSuccessState) {
          return _ProfilePage(profile: state.profle!);
        } else if (state is ProfileErrorState) {
          return const Center(child: ErrorText());
        } else {
          return const Center(child: ErrorText());
        }
      },
    );
  }
}

class _ProfilePage extends StatelessWidget {
  final Profile profile;
  final SizedBox _sizedBox = const SizedBox(height: 10);

  const _ProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DeactivateButton(
            callback: () {
              context.read<StoredAuthStatus>().setBottomNav(TabName.home.index);
              context.read<StoredAuthStatus>().saveAuthStatus(false);
            },
          ),
          _sizedBox,
           _LineText(context.read<StoredAuthStatus>().authNumber,
              size: 18, fontWeight: FontWeight.w300),
          _sizedBox,
          _RecentlyViewed(news: profile.recenltySearch!),
          _sizedBox,
          _SuggestionCategories(category: profile.suggestedCategory!),
          _sizedBox,
          _SuggestedVideos(videos: profile.suggestedVideo!),
        ],
      ),
    );
  }
}

class _DeactivateButton extends StatelessWidget {
  final VoidCallback? callback;

  const _DeactivateButton({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ImageResolver.profileImage, height: 200, width: 200),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: AppColor.pinkTextColor),
          onPressed: callback,
          child: Text(AppString.deactivate,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}

class _RecentlyViewed extends StatelessWidget {
  final List<News> news;

  const _RecentlyViewed({Key? key, required this.news}) : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const _LineText(AppString.recentlyViewed, fontWeight: FontWeight.w400),
      _sizedBox,
      SizedBox(
        height: 350,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const WidgetDivider(thickness: 2),
              itemCount: news.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoDetailPage(
                                    index: index,
                                    trending: news,
                                  )));
                    },
                    leading: Image.network(
                      news[index].catImage!,
                      height: 240,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      news[index].contentCatTitle!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(news[index].contentTitle!),
                        const SizedBox(height: 10),
                        const WidgetIconImage(
                          iconOne: Icons.thumb_up_off_alt,
                          like: "${null ?? ""} likes",
                          share: "${null ?? ""} share",
                          iconTwo: Icons.share,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    ]);
  }
}

class _SuggestionCategories extends StatelessWidget {
  final SizedBox _sizedBox = const SizedBox(height: 10);
  final List<MainMenuCategory> category;

  const _SuggestionCategories({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LineText(AppString.suggestedCategories),
        _sizedBox,
        SizedBox(
         height: 110,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteString.categoryDetail,
                            arguments: ScreenArguments(
                                buildContext: context,
                                data: category[index].catId));
                      },
                      child: CategoryAvatar(
                        value: category[index].title,
                        imageNetworkPath: category[index].image,
                          isFromHompage: false,
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}

class _SuggestedVideos extends StatelessWidget {
  final List<News> videos;

  const _SuggestedVideos({Key? key, required this.videos}) : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LineText(AppString.suggestedVideos),
        _sizedBox,
        SizedBox(
          height: 140,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoDetailPage(
                                index: index,
                                trending: videos,
                              )));
                },
                child: VideoPreview(
                    text: videos[index].contentCatTitle!,
                    imgSrc: videos[index].catImage!),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LineText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;

  const _LineText(this.text,
      {Key? key, this.size = 27, this.fontWeight = FontWeight.w400})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: fontWeight, fontSize: size, color: Colors.black),
    );
  }
}
