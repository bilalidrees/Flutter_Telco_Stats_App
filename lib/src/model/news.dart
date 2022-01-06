class News {
  String? contentId;
  String? contentCatId;
  String? credits;
  String? contentCatTitle;
  String? contentTitle;
  String? contentDescEn;
  String? contentDescAr;
  String? contentDescUr;
  String? createdDate;
  String? catImage;
  String? catVideo;
  String? isLike;
  String? layoutId;
  String? detail;
  String? randomId;
  String? like;
  String? view;
  String? share;
  String? contentDate;
  String? catAudio;
  dynamic isSeen;
  String? templateId;

  News(
      {this.isSeen,
      this.contentDate,
      this.catAudio,
      this.templateId,
      this.contentId,
      this.contentCatId,
      this.credits,
      this.contentCatTitle,
      this.contentTitle,
      this.contentDescEn,
      this.contentDescAr,
      this.contentDescUr,
      this.createdDate,
      this.catImage,
      this.catVideo,
      this.isLike,
      this.layoutId,
      this.detail,
      this.randomId,
      this.like,
      this.view,
      this.share});

  News.fromJson(Map<String, dynamic> json) {
    contentDate = json['content_date'];
    catAudio = json['cat_audio'];
    templateId = json['template_id'];
    isSeen = json['is_seen'];
    contentId = json['content_id'];
    contentCatId = json['content_cat_id'];
    credits = json['credits'];
    contentCatTitle = json['content_cat_title'];
    contentTitle = json['content_title'];
    contentDescEn = json['content_desc_en'];
    contentDescAr = json['content_desc_ar'];
    contentDescUr = json['content_desc_ur'];
    createdDate = json['created_date'];
    catImage = json['cat_image'];
    catVideo = json['cat_video'];
    isLike = json['is_like'];
    layoutId = json['layout_id'];
    detail = json['detail'];
    randomId = json['random_id'];
    like = json['like'];
    view = json['view'];
    share = json['share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_date'] = contentDate;
    data['cat_audio'] = catAudio;
    data['template_id'] = templateId;
    data['is_seen'] = isSeen;
    data['content_id'] = contentId;
    data['content_cat_id'] = contentCatId;
    data['credits'] = credits;
    data['content_cat_title'] = contentCatTitle;
    data['content_title'] = contentTitle;
    data['content_desc_en'] = contentDescEn;
    data['content_desc_ar'] = contentDescAr;
    data['content_desc_ur'] = contentDescUr;
    data['created_date'] = createdDate;
    data['cat_image'] = catImage;
    data['cat_video'] = catVideo;
    data['is_like'] = isLike;
    data['layout_id'] = layoutId;
    data['detail'] = detail;
    data['random_id'] = randomId;
    data['like'] = like;
    data['view'] = view;
    data['share'] = share;
    return data;
  }
}
