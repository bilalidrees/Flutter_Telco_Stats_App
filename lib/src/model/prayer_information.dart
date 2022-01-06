class PrayerInfo {
  String? imsak;
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? midnight;
  String? calcMethod;
  String? dateStr;
  Date? date;
  String? hijriStr;
  HijriDate? hijriDate;

  PrayerInfo(
      {this.imsak,
        this.fajr,
        this.sunrise,
        this.dhuhr,
        this.asr,
        this.sunset,
        this.maghrib,
        this.isha,
        this.midnight,
        this.calcMethod,
        this.dateStr,
        this.date,
        this.hijriStr,
        this.hijriDate});

  PrayerInfo.fromJson(Map<String, dynamic> json) {
    imsak = json['imsak'];
    fajr = json['fajr'];
    sunrise = json['sunrise'];
    dhuhr = json['dhuhr'];
    asr = json['asr'];
    sunset = json['sunset'];
    maghrib = json['maghrib'];
    isha = json['isha'];
    midnight = json['midnight'];
    calcMethod = json['calc_method'];
    dateStr = json['date_str'];
    date = json['date'] != null ?  Date.fromJson(json['date']) : null;
    hijriStr = json['hijri_str'];
    hijriDate = json['hijri_date'] != null
        ?  HijriDate.fromJson(json['hijri_date'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['imsak'] = imsak;
    data['fajr'] = fajr;
    data['sunrise'] = sunrise;
    data['dhuhr'] = dhuhr;
    data['asr'] = asr;
    data['sunset'] = sunset;
    data['maghrib'] = maghrib;
    data['isha'] = isha;
    data['midnight'] = midnight;
    data['calc_method'] = calcMethod;
    data['date_str'] = dateStr;
    if (date != null) {
      data['date'] = date!.toJson();
    }
    data['hijri_str'] = hijriStr;
    if (hijriDate != null) {
      data['hijri_date'] = hijriDate!.toJson();
    }
    return data;
  }
}

class Date {
  int? y;
  int? m;
  int? d;

  Date({this.y, this.m, this.d});

  Date.fromJson(Map<String, dynamic> json) {
    y = json['y'];
    m = json['m'];
    d = json['d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['y'] = y;
    data['m'] = m;
    data['d'] = d;
    return data;
  }
}

class HijriDate {
  int? hy;
  int? hm;
  dynamic hd;

  HijriDate({this.hy, this.hm, this.hd});

  HijriDate.fromJson(Map<String, dynamic> json) {
    hy = json['hy'];
    hm = json['hm'];
    hd = json['hd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['hy'] = hy;
    data['hm'] = hm;
    data['hd'] = hd;
    return data;
  }
}
