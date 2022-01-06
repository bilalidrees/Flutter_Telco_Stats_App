class Notifications {
  String? title;
  String? body;
  String? catId;
  String? contId;
  String? image;
  String? sound;
  String? catTitle;
  String? ago;

  Notifications(
      {this.title,
        this.body,
        this.catId,
        this.contId,
        this.image,
        this.sound,
        this.catTitle,
        this.ago});

  Notifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    catId = json['cat_id'];
    contId = json['cont_id'];
    image = json['image'];
    sound = json['sound'];
    catTitle = json['cat_title'];
    ago = json['ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['cat_id'] = catId;
    data['cont_id'] = contId;
    data['image'] = image;
    data['sound'] = sound;
    data['cat_title'] = catTitle;
    data['ago'] = ago;
    return data;
  }
}