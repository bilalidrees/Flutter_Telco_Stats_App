import 'package:zong_islamic_web_app/src/model/news.dart';

import 'main_menu_category.dart';
import 'news.dart';

class Profile {
  List<News>? recenltySearch;
  List<News>? suggestedVideo;
  List<MainMenuCategory>? suggestedCategory;
  List<News>? trendingVideo;

  Profile(
      {this.recenltySearch,
      this.suggestedVideo,
      this.suggestedCategory,
      this.trendingVideo});

  Profile.fromJson(Map<String, dynamic> json) {
    if (json['recenlty_search'] != null) {
      recenltySearch = [];
      json['recenlty_search'].forEach((v) {
        recenltySearch!.add(News.fromJson(v));
      });
    }
    if (json['suggested_video'] != null) {
      suggestedVideo = [];
      json['suggested_video'].forEach((v) {
        suggestedVideo!.add(News.fromJson(v));
      });
    }
    if (json['suggested_category'] != null) {
      suggestedCategory = [];
      json['suggested_category'].forEach((v) {
        suggestedCategory!.add(MainMenuCategory.fromJson(v));
      });
    }
    if (json['trending_video'] != null) {
      trendingVideo = [];
      json['trending_video'].forEach((v) {
        trendingVideo!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recenltySearch != null) {
      data['recenlty_search'] = recenltySearch!.map((v) => v.toJson()).toList();
    }
    if (suggestedVideo != null) {
      data['suggested_video'] = suggestedVideo!.map((v) => v.toJson()).toList();
    }
    if (suggestedCategory != null) {
      data['suggested_category'] =
          suggestedCategory!.map((v) => v.toJson()).toList();
    }
    if (trendingVideo != null) {
      data['trending_video'] = trendingVideo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
