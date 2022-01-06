class SurahWise {
  late final String ar;
  late final int surah;
  late final int ayat;
  late final String en;
  late final String ur;

  SurahWise({required this.ar, required this.surah, required this.ayat});

  SurahWise.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    surah = json['surah'];
    ayat = json['ayat'];
    en = json['en'];
    ur = json['ur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ar'] = ar;
    data['surah'] = surah;
    data['ayat'] = ayat;
    data['en'] = en;
    data['ur']= ur;
    return data;
  }
}
