class CustomSlider {
  String? sliderImage;
  String? catId;
  String? catTitle;

  CustomSlider({this.sliderImage, this.catId, this.catTitle});

  CustomSlider.fromJson(Map<String, dynamic> json) {
    sliderImage = json['slider_image'];
    catId = json['cat_id'];
    catTitle = json['cat_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slider_image'] = sliderImage;
    data['cat_id'] = catId;
    data['cat_title'] = catTitle;
    return data;
  }
}