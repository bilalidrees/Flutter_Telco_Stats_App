import 'package:zong_islamic_web_app/src/model/trending.dart';

import 'trending.dart';

class ContentByCateId {
  String? catId;
  String? title;
  String? parentId;
  List<SubMenu>? subMenu;
  dynamic vod;

  ContentByCateId(
      {this.catId, this.title, this.parentId, this.subMenu, this.vod});

  ContentByCateId.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    title = json['title'];
    parentId = json['parent_id'];
    if (json['vod'] != null) {
      if (json['vod'] is List) {
        vod = <Trending>[];
        json['vod'].forEach((v) {
          vod!.add(Trending.fromJson(v));
        });
      }
      else{
        vod = (json['vod'] != null ? Trending.fromJson(json['vod']) : null)!;
      }
    }


    if (json['subMenu'] != null) {
      subMenu = [];
      json['subMenu'].forEach((v) {
        subMenu!.add(SubMenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cat_id'] = catId;
    data['title'] = title;
    data['parent_id'] = parentId;
    if (vod != null) {
      data['vod'] = vod!.toJson();
    }
    if (subMenu != null) {
      data['subMenu'] = subMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubMenu {
  String? status;
  String? msg;
  String? catId;
  String? parentId;
  String? parentTitle;
  String? title;
  String? image;
  String? sidemenuImage;
  String? templateId;
  String? isChild;
  String? menu;
  String? menuLink;
  String? menuLinkLow;

  SubMenu(
      {this.status,
      this.msg,
      this.title,
      this.catId,
      this.image,
      this.isChild,
      this.menu,
      this.menuLink,
      this.menuLinkLow,
      this.parentId,
      this.parentTitle,
      this.sidemenuImage,
      this.templateId});

  SubMenu.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    catId = json['cat_id'];
    parentId = json['parent_id'];
    parentTitle = json['parent_title'];
    title = json['title'];
    image = json['image'];
    sidemenuImage = json['sidemenu_image'];
    templateId = json['template_id'];
    isChild = json['is_child'];
    menu = json['menu'];
    menuLink = json['menu_link'];
    menuLinkLow = json['menu_link_low'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['msg'] = msg;
    data['cat_id'] = catId;
    data['parent_id'] = parentId;
    data['parent_title'] = parentTitle;
    data['title'] = title;
    data['image'] = image;
    data['sidemenu_image'] = sidemenuImage;
    data['template_id'] = templateId;
    data['is_child'] = isChild;
    data['menu'] = menu;
    data['menu_link'] = menuLink;
    data['menu_link_low'] = menuLinkLow;
    return data;
  }
}
