class MainMenuCategory {
  late final String catId;
  late final String parentId;
  late final String parentTitle;
  late final String title;
  late final String image;
  late final String sidemenuImage;
  late final String templateId;
  late final String isChild;

  MainMenuCategory(
      {required this.catId,
      required this.parentId,
      required this.parentTitle,
      required this.title,
      required this.image,
      required this.sidemenuImage,
      required this.templateId,
      required this.isChild,});

  MainMenuCategory.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    parentId = json['parent_id'];
    parentTitle = json['parent_title'];
    title = json['title'];
    image = json['image'];
    sidemenuImage = json['sidemenu_image'];
    templateId = json['template_id'];
    isChild = json['is_child'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['parent_id'] = parentId;
    data['parent_title'] = parentTitle;
    data['title'] = title;
    data['image'] = image;
    data['sidemenu_image'] = sidemenuImage;
    data['template_id'] = templateId;
    data['is_child'] = isChild;
    return data;
  }
}




