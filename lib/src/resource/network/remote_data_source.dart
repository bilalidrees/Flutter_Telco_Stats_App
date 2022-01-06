import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/model/prayer_information.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';
import 'package:zong_islamic_web_app/src/model/surah_wise.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/abs_remote_data_src.dart';
import 'package:zong_islamic_web_app/src/resource/utility/network_constants.dart';

class ZongIslamicRemoteDataSourceImpl extends ZongIslamicRemoteDataSource {
  final ApiClient _client = ApiClient();

  @override
  Future<List<MainMenuCategory>> getMainMenuCategory(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_CAT,
      'city': 'Karachi',
    });
    print(uri);
    final parsed = await _client.get(
      uri,
    );
    return parsed
        .map<MainMenuCategory>((json) => MainMenuCategory.fromJson(json))
        .toList();
  }

  @override
  Future<Trending> getTrendingNews(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_TRENDING,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return Trending.fromJson(parsed);
  }

  @override
  Future<ContentByCateId> getCategoryById(String id, String number)async {
    var uri = Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': "923142006707",
      'operator': 'Zong',
      'menu': NetworkConstant.GET_CONTENT,
      'cat_id': id,
      'p': "1",
      'city': 'Karachi',
    });
     print(uri);
    final parsed = await _client.get(uri);
    return ContentByCateId.fromJson(parsed);
  }

  @override
  Future<List<CustomSlider>> getSliderImage(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.GET_SLIDER,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return parsed
        .map<CustomSlider>((json) => CustomSlider.fromJson(json))
        .toList();
  }

  @override
  Future<Profile> getProfileData(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.VIEW_BASE_CONTENT,
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return Profile.fromJson(parsed);
  }

  @override
  Future<Profile> getSearchData(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.SEARCH,
      'keyword': "Quran",
      'city': 'Karachi',
    });
    final parsed = await _client.get(
      uri,
    );
    return Profile.fromJson(parsed);
  }

  @override
  Future<List<Notifications>> getNotifications(String number) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': NetworkConstant.PUSH_NOTIFICATION_LIST,
      'city': 'Karachi',
    });
    final parsed = await _client.get(uri);
    return parsed
        .map<Notifications>((json) => Notifications.fromJson(json))
        .toList();
  }

  @override
  Future<String> login(String number) async {
    //923128863374
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': number,
      'operator': 'Zong',
      'menu': NetworkConstant.CUREG_CKEY,
    });
    dynamic response = await _client.get(uri);
    print(response);
    return "success";
  }

  @override
  Future<String> verifyOtp(String number, String code) async {
    var uri =
        Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': number,
      'operator': 'Zong',
      'menu': NetworkConstant.CUREG_VKEY,
      'key': code,
    });
    var response = await _client.get(uri);
  //  Iterable lt = json.decode(response.body);
   // var firstObject = lt.first;
    //return firstObject["status"] as String;
    return 'success';
  }

  @override
  Future<List<String>> getAllCities() async{
    var data = await _client.get(Uri.parse( "https://api02.vectracom.net:8443/zg-location/location/getAllCity"));
    if (data["status"] == "SUCCESS") {
      Iterable l = data['data'];
      List<String> streetsList = [];
      l.forEach((element) {
        String city = element['name'];
        streetsList.add(city);
      });
      return streetsList;
    } else {
      throw data["status"];
    }
  }

  @override
  Future<List<String>> getHomepageDetails(String number) async{
    var uri = Uri.https(NetworkConstant.BASE_URL, NetworkConstant.BASE_END_POINT, {
      'msisdn': '923128863374',
      'operator': 'Zong',
      'menu': 'home_ramadan_mzapp',

    });
    var response = await _client.get(uri);
    List<String> dateList = [];
    dateList.add(response['englishDate']);
    dateList.add(response['islamicDate']);
    return dateList;
  }

  @override
  Future<PrayerInfo> getPrayer(String lat, String lng,String number) async{
    var uri = Uri.https('vp.vxt.net:31443', '/api/pt', {
      'msisdn': number,
      'operator': 'Zong',
      'menu': 'home_ramadan_mzapp',
      'tz': '5',
      'a': 'HANAFI',
      'm': 'Karachi',
      'lt': lat,
      'lg': lng,
    });
    print(uri);
    var response = await _client.get(uri);
    return PrayerInfo.fromJson(response);
  }

  @override
  Future<List<SurahWise>> getSurahWise(int surah,String lang) async{
    var uri = Uri.https("vp.vxt.net:31786","/api/surah", {
      'surah': "$surah",
      'ayat': '0',
      'limit': '0',
      'lang':lang,
    });
    print(uri);
    final parsed = await _client.get(uri);

    return parsed.map<SurahWise>((json) => SurahWise.fromJson(json)).toList();
  }




}



